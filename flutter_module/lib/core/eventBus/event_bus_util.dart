/**
 * @author: jiangjunhui
 * @date: 2025/2/7
 */
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';

/// 封装后的高级事件总线
class AppEventBus {
  static final EventBus _instance = EventBus();

  // 私有构造，确保单例
  AppEventBus._internal();

  /// 获取单例实例
  static EventBus get instance => _instance;

  /// 发送事件
  static void sendEvent<T>(T event) {
    if (kDebugMode) {
      print('[EventBus] Firing event: ${event.runtimeType}');
    }
    instance.fire(event);
  }

  /// 订阅事件，返回可取消的订阅对象
  static StreamSubscription<T> on<T>(void Function(T event) handler, {
    bool handleError = true,
    ErrorCallback? onError,
  }) {
    final subscription = instance.on<T>().listen((event) {
      if (kDebugMode) {
        print('[EventBus] Received event: ${event.runtimeType}');
      }
      _safeRun(() => handler(event), onError: onError);
    }, onError: handleError ? (error, stack) {
      _safeRun(() => onError?.call(error, stack));
    } : null);

    return subscription;
  }

  static void _safeRun(void Function() action, {ErrorCallback? onError}) {
    try {
      action();
    } catch (e, s) {
      if (kDebugMode) {
        print('[EventBus] Handler error: $e\n$s');
      }
      onError?.call(e, s);
    }
  }
}

/// Flutter Widget 集成扩展
mixin EventBusMixin<T extends StatefulWidget> on State<T> {
  final List<StreamSubscription> _eventSubscriptions = [];

  /// 安全订阅事件，自动管理生命周期
  void subscribe<Event>(void Function(Event event) handler, {
    bool handleError = true,
    ErrorCallback? onError,
  }) {
    _eventSubscriptions.add(
        AppEventBus.on<Event>(handler, handleError: handleError, onError: onError)
    );
  }

  @override
  void dispose() {
    for (final sub in _eventSubscriptions) {
      sub.cancel();
    }
    if (kDebugMode) {
      print('[EventBus] Canceled ${_eventSubscriptions.length} subscriptions');
    }
    super.dispose();
  }
}

typedef ErrorCallback = void Function(Object error, StackTrace stackTrace);