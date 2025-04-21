/**
 * @author: jiangjunhui
 * @date: 2025/4/18
 */
import 'package:flutter/material.dart';
import 'package:flutter_module/app/pages/flutter_boost_demo/flutter_B.dart';
import 'package:flutter_module/core/log/log.dart';
@pragma('vm:entry-point')
void featureMain() {
  Log.error("测试多引擎");
  runApp(FlutterB()); // 对应模块1的根组件
}
 
 
 
 
 
 
 
 
 
 
 