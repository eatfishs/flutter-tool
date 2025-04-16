import 'package:flutter/material.dart';

/// 生命周期状态机
enum BoostLifecycleState {
  created,
  visible,
  inactive,
  paused,
  resumed,
  detached
}

/// 多维度生命周期管理
/// 职责：
/// 1. Flutter页面生命周期
/// 2. 原生容器生命周期
/// 3. 全局App生命周期
class LifecycleManager {
  static final _pageStates = <String, BoostLifecycleState>{};
  static final _listeners = <LifecycleListener>[];

  /// 注册全局监听
  static void addListener(LifecycleListener listener) {
    _listeners.add(listener);
  }

  /// 处理FlutterBoost页面事件
  static void onFlutterBoostEvent(String pageId, String eventType) {
    final newState = _convertEventToState(eventType);
    _updatePageState(pageId, newState);

    // 触发业务监听
    _listeners.forEach((listener) {
      listener.onPageStateChanged(pageId, newState);
    });
  }

  /// 处理原生生命周期事件
  static void handleAppState(String state) {
    switch (state) {
      case 'background':
        _notifyAppBackground();
        break;
      case 'foreground':
        _notifyAppForeground();
        break;
    }
  }

  /// 状态转换逻辑
  static BoostLifecycleState _convertEventToState(String event) {
    const eventMap = {
      'onCreate': BoostLifecycleState.created,
      'onShow': BoostLifecycleState.visible,
      'onHide': BoostLifecycleState.inactive,
      'onResume': BoostLifecycleState.resumed,
      'onPause': BoostLifecycleState.paused,
      'onDestroy': BoostLifecycleState.detached
    };
    return eventMap[event] ?? BoostLifecycleState.created;
  }

  /// 内存页状态管理
  static void _updatePageState(String pageId, BoostLifecycleState state) {
    if (state == BoostLifecycleState.detached) {
      _pageStates.remove(pageId);
    } else {
      _pageStates[pageId] = state;
    }

    // 自动释放资源
    if (state == BoostLifecycleState.detached) {
      // 假设 PageResourceRecycler 有 recycle 方法
      // PageResourceRecycler.recycle(pageId);
    }
  }

  static void _notifyAppBackground() {
    _listeners.forEach((listener) {
      listener.onAppBackground();
    });
  }

  static void _notifyAppForeground() {
    _listeners.forEach((listener) {
      listener.onAppForeground();
    });
  }
}

/// 生命周期监听协议
abstract class LifecycleListener {
  void onPageStateChanged(String pageId, BoostLifecycleState state);
  void onAppBackground();
  void onAppForeground();
}