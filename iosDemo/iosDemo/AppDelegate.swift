//
//  AppDelegate.swift
//  iosDemo
//
//  Created by jiangjunhui on 2024/11/30.
//
import UIKit
import Flutter
import FlutterPluginRegistrant
@UIApplicationMain

class AppDelegate: FlutterAppDelegate { // More on the FlutterAppDelegate.
  
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    // 创建命名方法通道
    var methodChannel: FlutterMethodChannel?
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        // 启动引擎
        flutterEngine.run();
        // 注册引擎
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
        // 创建命名方法通道
        methodChannel = FlutterMethodChannel.init(name: "flutter_postData", binaryMessenger: flutterEngine.binaryMessenger)
        
  
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}
