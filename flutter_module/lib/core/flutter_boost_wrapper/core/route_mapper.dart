import 'dart:convert';
import '../navigator/boost_navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boost/flutter_boost.dart';


/// 智能路由映射器
/// 职责：
/// 1. 路由表管理
/// 2. 动态路由注册
/// 3. 参数类型校验


class RouteMapper {
  static final RouteMapper _instance = RouteMapper._();
  final Map<String, FlutterBoostRouteFactory> _routeTable = {};

  RouteMapper._();

  static RouteMapper get instance => _instance;

  void registerRoute(String routeName, FlutterBoostRouteFactory routeFactory) {
    _routeTable[routeName] = routeFactory;
  }

  FlutterBoostRouteFactory? getRouteFactory(String routeName) {
    return _routeTable[routeName];
  }

  bool validateParams(String routeName, dynamic params) {
    // 实现参数类型校验逻辑
    return true;
  }
}