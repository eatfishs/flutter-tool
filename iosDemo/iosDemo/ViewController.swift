//
//  ViewController.swift
//  iosDemo
//
//  Created by jiangjunhui on 2024/11/30.
//

import UIKit
import Flutter

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    
      let button = UIButton(type:UIButton.ButtonType.custom)
      button.addTarget(self, action: #selector(showRootPage), for: .touchUpInside)
      button.setTitle("showRootPage!", for: UIControl.State.normal)
      button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
      button.backgroundColor = UIColor.blue
      self.view.addSubview(button)
      
      let button1 = UIButton(type:UIButton.ButtonType.custom)
      button1.addTarget(self, action: #selector(showTestRouterPage), for: .touchUpInside)
      button1.setTitle("showColorPage!", for: UIControl.State.normal)
      button1.frame = CGRect(x: 80.0, y: 350.0, width: 160.0, height: 40.0)
      button1.backgroundColor = UIColor.blue
      self.view.addSubview(button1)
  }

    
    @objc func showRootPage() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // 模拟发送消息给Flutter
        appDelegate.methodChannel?.invokeMethod("Router_Page_Method", arguments: ["code":"0","message":"向flutter传递值-home","data":["page":"home"]])
        
   
        
        let flutterEngine = appDelegate.flutterEngine
        let flutterViewController =
          FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(flutterViewController, animated: true)
    }
    
  @objc func showTestRouterPage() {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      // 模拟发送消息给Flutter
//      appDelegate.methodChannel?.invokeMethod("Router_Page_Method", arguments: ["code":"0","message":"向flutter传递值-TestRouterPage","data":["page":"TestRouterPage"]])
      
      appDelegate.methodChannel?.invokeMethod("Router_Page_Method", arguments: "TestRouterPage")
 
      
      let flutterEngine = appDelegate.flutterEngine
      let flutterViewController =
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
      self.navigationController?.pushViewController(flutterViewController, animated: true)
  }
}
