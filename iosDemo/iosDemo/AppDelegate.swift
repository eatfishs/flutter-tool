//
//  AppDelegate.swift
//  iosDemo
//
//  Created by jiangjunhui on 2024/11/30.
//
import Flutter
import FlutterPluginRegistrant
import UIKit

@UIApplicationMain

class AppDelegate: FlutterAppDelegate { // More on the FlutterAppDelegate.
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    // 创建命名方法通道
    var methodChannel: FlutterMethodChannel?

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 启动引擎
        flutterEngine.run()
        // 注册引擎
        GeneratedPluginRegistrant.register(with: flutterEngine)
        // 创建命名方法通道
        methodChannel = FlutterMethodChannel(name: "flutter_postData", binaryMessenger: flutterEngine.binaryMessenger)

        // 往方法通道注册方法调用处理回调
        methodChannel?.setMethodCallHandler { call, result in
            ifcall.method == "post_data" {
                // 打印flutter传来的值
                print("=====打印flutter传来的值=======")
                print(call.arguments ?? {})
                // 向flutter传递值
                DispatchQueue.main.async {
                    result(["code": "0",
                            "message": "向flutter传递值-methodChannel",
                            "data": ["page": "home"]])
                }
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
