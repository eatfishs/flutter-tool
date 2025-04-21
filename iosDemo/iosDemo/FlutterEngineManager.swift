//
//  FlutterEngineManager.swift
//  iosDemo
//
//  Created by jiangjunhui on 2025/2/25.
//

import Flutter
import FlutterPluginRegistrant
import UIKit

final class FlutterEnginePool {
    static let shared = FlutterEnginePool()
    private init() {
        setupMemoryWarningObserver()
    }
    
    // MARK: - Properties
    private var cachedEngines: [String: [FlutterEngine]] = [:]
    private let syncQueue = DispatchQueue(label: "com.flutter.engine.pool.queue")
    private let maxCacheCount = 3 // 每个业务场景最大缓存数
    
    //  获取引擎
    func getEngine(identifier: String) -> FlutterEngine {
        var engine: FlutterEngine!
        
        syncQueue.sync {
            if var engines = cachedEngines[identifier], !engines.isEmpty {
                engine = engines.removeLast()
            } else {
                engine = createNewEngine(identifier: identifier)
            }
        }
        
        return engine
    }
    
    // 回收引擎
    func recycleEngine(_ engine: FlutterEngine, identifier: String) {
        syncQueue.async { [weak self] in
            guard let self = self else { return }
            
            self.resetEngineState(engine)
            
            if self.cachedEngines[identifier] == nil {
                self.cachedEngines[identifier] = []
            }
            
            if var engines = self.cachedEngines[identifier] {
                if engines.count >= self.maxCacheCount {
                    engines.removeFirst() // LRU 淘汰
                }
                engines.append(engine)
                self.cachedEngines[identifier] = engines
            }
        }
    }
    
    // 创建新引擎
    private func createNewEngine(identifier: String) -> FlutterEngine {
        let engine = FlutterEngine(name: identifier, project: nil, allowHeadlessExecution: true)
        engine.run(withEntrypoint: nil)
        return engine
    }
    
    // 重置引擎状态
    private func resetEngineState(_ engine: FlutterEngine) {
        // 通过 MethodChannel 通知 Flutter 端重置状态
        // 示例：清理路由栈 (Navigator.of(context).popUntil((route) => route.isFirst))
        // 或者重启引擎（根据业务需求选择）
        engine.destroyContext()
        engine.run(withEntrypoint: nil)
    }
    
    // 清理所有缓存
    func clearAll() {
        syncQueue.async { [weak self] in
            self?.cachedEngines.removeAll()
        }
    }
    
    // 内存警告处理
    private func setupMemoryWarningObserver() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.clearAll()
        }
    }
}
