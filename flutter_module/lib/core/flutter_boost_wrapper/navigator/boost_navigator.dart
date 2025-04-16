import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart'; // 引入 material 库以使用动画和导航相关组件
import '../core/boost_bridge.dart';
import '../core/route_mapper.dart';
import '../exception/boost_error_handler.dart';
import '../params/boost_params.dart';
import 'route_interceptor.dart';

/// 过渡动画类型枚举
enum TransitionType {
  native, // 平台默认
  material, // Material风格
  cupertino, // Cupertino风格
  fade, // 淡入淡出
  custom, // 自定义动画
  slideFromRight, // 从右侧滑入
  slideFromBottom, // 从底部滑入
}

/// 统一导航器（支持三端路由）
class BoostNavigator {
  static final _instance = BoostNavigator._internal();
  final _pendingResults = <String, Completer<dynamic>>{};
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  factory BoostNavigator() => _instance;

  BoostNavigator._internal();

  /// 执行路由跳转（核心方法）
  Future<T?> push<T>({
    required String path,
    dynamic params,
    RouteType type = RouteType.auto,
    TransitionType transition = TransitionType.native,
    bool withContainer = true,
    int requestCode = 0,
  }) async {
    // 生成唯一路由ID
    final routeId = _generateRouteId(path, requestCode);
    final completer = Completer<T?>();
    _pendingResults[routeId] = completer;

    try {
      // 1. 参数序列化
      final serializedParams = BoostParams.serialize(params);

      // 2. 路由拦截处理
      final interceptResult = await RouteInterceptorManager.process(
        path,
        serializedParams,
      );
      if (interceptResult != RouteDecision.continue_router) {
        _handleInterception(routeId, interceptResult);
        return completer.future;
      }

      // 3. 路由类型决策
      final resolvedType = _resolveRouteType(path, type);

      // 4. 执行跳转
      if (resolvedType case RouteType.flutter) {
        return _pushFlutterRoute<T>(
          path,
          serializedParams,
          routeId,
          transition,
          withContainer,
        );
      } else if (resolvedType case RouteType.native) {
        return _pushNativeRoute<T>(
          path,
          serializedParams,
          routeId,
          requestCode,
        );
      } else if (resolvedType case RouteType.web) {
        return _pushWebRoute<T>(path, serializedParams, routeId);
      }
    } catch (e, stack) {
      _pendingResults.remove(routeId);

       BoostErrorHandler.handleRouteError(path, params, e, stack);
      rethrow;
    }
  }

  /// 统一返回方法
  static void pop<T>([T? result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState!.pop(result);
    } else {
      // 假设 FlutterBoost 有 closeCurrent 方法
      // FlutterBoost.instance.closeCurrent(result: result);
    }
  }

  /// 处理Flutter页面返回结果
  void _handleFlutterResult<T>(String routeId, T? result) {
    _pendingResults[routeId]?.complete(result);
    _pendingResults.remove(routeId);
  }

  /// 处理原生页面返回结果
  void handleNativeResult<T>(String routeId, dynamic result) {
    final deserialized = BoostParams.deserialize<T>(result);
    _pendingResults[routeId]?.complete(deserialized);
    _pendingResults.remove(routeId);
  }

  /// 路由类型决策逻辑
  RouteType _resolveRouteType(String path, RouteType type) {
    if (type != RouteType.auto) return type;
    return RouteMapper.resolveRouteType(path);
  }

  /// 生成路由唯一标识
  String _generateRouteId(String path, int requestCode) {
    return '${path}_${DateTime.now().millisecondsSinceEpoch}_$requestCode';
  }

  /// 执行Flutter路由跳转
  Future<T?> _pushFlutterRoute<T>(
      String path,
      dynamic params,
      String routeId,
      TransitionType transition,
      bool withContainer,
      ) async {
    final pageBuilder = RouteMapper.getBuilder(path);
    if (pageBuilder == null) {
      _pendingResults[routeId]?.complete(null);
      _pendingResults.remove(routeId);
      return null;
    }

    final deserializedParams = BoostParams.deserialize<Map<String, dynamic>>(params);
    final page = pageBuilder(navigatorKey.currentContext!, deserializedParams);

    Route<T> route;
    switch (transition) {
      case TransitionType.material:
        route = MaterialPageRoute<T>(
          builder: (context) => page,
        );
        break;
      case TransitionType.cupertino:
        route = CupertinoPageRoute<T>(
          builder: (context) => page,
        );
        break;
      case TransitionType.fade:
        route = PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
        break;
      case TransitionType.custom:
      // 自定义动画示例：缩放动画
        route = PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
              ),
              child: child,
            );
          },
        );
        break;
      case TransitionType.slideFromRight:
        route = PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
        break;
      case TransitionType.slideFromBottom:
        route = PageRouteBuilder<T>(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
        break;
      default:
        route = MaterialPageRoute<T>(
          builder: (context) => page,
        );
    }

    final result = await navigatorKey.currentState?.push<T>(route);
    _handleFlutterResult(routeId, result);
    return result;
  }

  /// 执行原生路由跳转
  Future<T?> _pushNativeRoute<T>(
      String path,
      dynamic params,
      String routeId,
      int requestCode,
      ) async {
    final nativeParams = BoostParams.serializeForNative(params);

    return BoostBridge.invokeNative<T>(
      method: 'openNativePage',
      params: {
        'path': path,
        'params': nativeParams,
        'requestCode': requestCode,
        'routeId': routeId,
      },
    );
  }

  /// 执行Web路由跳转
  Future<T?> _pushWebRoute<T>(
      String path, dynamic params, String routeId) async {
    // 这里可以实现Web路由跳转逻辑
    return null;
  }

  /// 处理路由拦截结果
  void _handleInterception(String routeId, RouteDecision decision) {
    // 这里可以实现路由拦截处理逻辑
    _pendingResults[routeId]?.complete(null);
    _pendingResults.remove(routeId);
  }


}

