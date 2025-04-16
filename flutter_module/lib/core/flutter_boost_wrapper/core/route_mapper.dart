import 'dart:convert';

import '../navigator/boost_navigator.dart';

/// 路由元数据
class RouteConfig {
  final String routePath;
  final RouteType routeType; // flutter/native/web
  final dynamic builder;
  final Map<String, ParamType> paramsSchema;

  const RouteConfig({
    required this.routePath,
    required this.routeType,
    required this.builder,
    this.paramsSchema = const {}
  });
}

/// 路由类型枚举
enum RouteType {
  auto,    // 自动判断
  flutter, // Flutter页面
  native,  // 原生页面
  web      // Web页面
}

/// 参数类型枚举
enum ParamType {
  int,
  double,
  bool,
  string,
  json
}

/// 智能路由映射器
/// 职责：
/// 1. 路由表管理
/// 2. 动态路由注册
/// 3. 参数类型校验
class RouteMapper {
  static final _routeTable = <String, RouteConfig>{};
  static final _dynamicRoutes = RegExp(r'^\/dynamic\/\w+');

  /// 注册路由配置
  static void register(RouteConfig config) {
    // 路径冲突检测
    if (_routeTable.containsKey(config.routePath)) {
      throw Exception('Route conflict: ${config.routePath}');
    }
    _routeTable[config.routePath] = config;
  }

  /// 路由解析入口
  static RouteMatchResult resolve(String url, dynamic rawParams) {
    final uri = Uri.parse(url);

    // 1. 精确匹配
    if (_routeTable.containsKey(uri.path)) {
      return _matchStaticRoute(uri, rawParams);
    }

    // 2. 动态路由匹配
    if (_dynamicRoutes.hasMatch(uri.path)) {
      // 实现动态路由匹配逻辑
    }

    return RouteMatchResult(null, null);
  }

  static RouteType resolveRouteType(String path) {
    final config = _routeTable[path];
    return config?.routeType ?? RouteType.auto;
  }

  static dynamic getBuilder(String path) {
    final config = _routeTable[path];
    return config?.builder;
  }

  static _matchStaticRoute(Uri uri, dynamic rawParams) {
    final config = _routeTable[uri.path]!;
    // 实现参数校验逻辑
    return RouteMatchResult(config, null);
  }
}

class RouteMatchResult {
  final RouteConfig? config;
  final Map<String, dynamic>? params;

  RouteMatchResult(this.config, this.params);
}