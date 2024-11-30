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
      
      
      
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }
}
