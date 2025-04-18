import '../core/route_mapper.dart';

import 'dart:async';
import 'package:flutter/widgets.dart';
import '../params/global_context.dart';

typedef RouteInterceptorHandler = Future<bool> Function(String routeName, dynamic params);

class RouteInterceptorManager {
  static final RouteInterceptorManager _instance = RouteInterceptorManager._();
  final List<(int priority, RouteInterceptorHandler handler)> _interceptors = [];

  RouteInterceptorManager._();

  static RouteInterceptorManager get instance => _instance;

  void addInterceptor(int priority, RouteInterceptorHandler handler) {
    _interceptors.add((priority, handler));
    _interceptors.sort((a, b) => a.$1.compareTo(b.$1));
  }

  Future<bool> intercept(String routeName, dynamic params) async {
    for (final (_, handler) in _interceptors) {
      final shouldContinue = await handler(routeName, params);
      if (!shouldContinue) {
        return false;
      }
    }
    return true;
  }
}