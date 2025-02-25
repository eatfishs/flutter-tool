//
//  FlutterEngineManager.swift
//  iosDemo
//
//  Created by jiangjunhui on 2025/2/25.
//

import UIKit
import Flutter

class FlutterEnginePool {
    // MARK: - 单例
    static let shared = FlutterEnginePool()
    private init() {}
    
    // MARK: - 核心属性
    private let engineGroup = FlutterEngineGroup(name: "flutter_engine_pool", project: nil)
    private var activeEngines: [String: FlutterEngine] = [:]  // 使用中的引擎 [路由标识: 引擎]
    private var idleEngines: [String: FlutterEngine] = [:]    // 闲置引擎池
    private let queue = DispatchQueue(label: "com.flutter.engine.pool.lock")  // 线程安全队列
    
    // MARK: - 配置参数
    private let maxIdleCount = 3           // 最大闲置引擎数
    private let maxIdleTime: TimeInterval = 300  // 闲置超时时间（秒）
    private var timer: Timer?              // 闲置检测定时器
    
    // MARK: - 公开方法
    /// 获取引擎（按路由标识）
    func getEngine(for route: String) -> FlutterEngine {
        return queue.sync {
            // 1. 查找可用闲置引擎
            if let engine = idleEngines.removeValue(forKey: route) {
                activeEngines[route] = engine
                return engine
            }
            
            // 2. 创建新引擎
            let engine = engineGroup.makeEngine(
                withEntrypoint: "main",
                libraryURI: nil,
                initialRoute: route
            )
            GeneratedPluginRegistrant.register(with: engine)
            activeEngines[route] = engine
            
            // 3. 启动闲置检测
            startIdleCheckTimer()
            
            return engine
        }
    }
    
    /// 归还引擎到池中
    func recycleEngine(for route: String) {
        queue.async {
            guard let engine = self.activeEngines.removeValue(forKey: route) else { return }
            
            // 1. 超过最大闲置数时销毁最旧的引擎
            if self.idleEngines.count >= self.maxIdleCount, let firstKey = self.idleEngines.keys.first {
                self.idleEngines.removeValue(forKey: firstKey)?.destroyContext()
            }
            
            // 2. 记录闲置时间戳（用于LRU回收）
            let metadata = ["recycleTime": Date()]
            engine.setMetadata(metadata)
            
            // 3. 存入闲置池
            self.idleEngines[route] = engine
        }
    }
    
    /// 强制销毁所有引擎（用于内存警告）
    func purgeAllEngines() {
        queue.async {
            self.activeEngines.values.forEach { $0.destroyContext() }
            self.idleEngines.values.forEach { $0.destroyContext() }
            self.activeEngines.removeAll()
            self.idleEngines.removeAll()
        }
    }
    
    // MARK: - 私有方法
    private func startIdleCheckTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.checkIdleEngines()
        }
    }
    
    private func checkIdleEngines() {
        queue.async {
            let now = Date()
            
            // 清理超时引擎
            self.idleEngines = self.idleEngines.filter { route, engine in
                guard let metadata = engine.metadata as? [String: Any],
                      let recycleTime = metadata["recycleTime"] as? Date else {
                    return false
                }
                
                if now.timeIntervalSince(recycleTime) > self.maxIdleTime {
                    engine.destroyContext()
                    return false
                }
                return true
            }
        }
    }
}

// MARK: - 内存警告扩展
extension FlutterEnginePool {
    func setupMemoryWarningObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemoryWarning),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    
    @objc private func handleMemoryWarning() {
        purgeAllEngines()
    }
}
