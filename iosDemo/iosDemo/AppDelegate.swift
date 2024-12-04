//
//  AppDelegate.swift
//  iosDemo
//
//  Created by jiangjunhui on 2024/11/30.
//
import UIKit
import Flutter
// The following library connects plugins with iOS platform code to this app.
import FlutterPluginRegistrant
@UIApplicationMain

class AppDelegate: FlutterAppDelegate { // More on the FlutterAppDelegate.
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine")

  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // 启动引擎
      flutterEngine.run();
      // 注册引擎
      GeneratedPluginRegistrant.register(with: self.flutterEngine);
      
      
      // 创建命名方法通道
      let methodChannel = FlutterMethodChannel.init(name: "flutter_postData", binaryMessenger: flutterEngine.binaryMessenger)
        // 往方法通道注册方法调用处理回调
        methodChannel.setMethodCallHandler { (call, result) in
            if("flutter_postData" == call.method){
                //打印flutter传来的值
                print(call.arguments ?? {})
                //向flutter传递值
                DispatchQueue.main.async {
                    result(["1","2","3"]);
                }
                  
            }
        }
 
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }
}
