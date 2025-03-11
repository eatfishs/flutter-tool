/**
 * @author: jiangjunhui
 * @date: 2025/2/24
 */
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../http/core/network_service.dart';

// MVC 基类 Controller
abstract class BaseController extends ChangeNotifier {
  NetworkService networkService = NetworkService();

  /// onInit()：Controller 初始化时触发，适合初始化数据
  @mustCallSuper
  void onInit() {}

  /// onDispose()：Controller 销毁时触发，用于资源清理
  @mustCallSuper
  void onDispose() {
    networkService.cancelAllRequests();
  }

  /// 统一请求网络
  void loadData() {}

  /// 统一错误处理入口 handleError()
  void handleError(dynamic error) {
    debugPrint('Controller Error: $error');
    // 可扩展统一错误处理逻辑
  }

  // 状态标记
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  BaseController() {
    onInit();
  }

  @override
  void dispose() {
    if (!_isDisposed) {
      _isDisposed = true;
      onDispose();
      super.dispose();
    }
  }

  /*
  * 提供 safeNotify() 方法，避免在 disposed 状态下触发通知 继承 ChangeNotifier 实现自动监听管理
  * */
  // 安全更新方法（防重复通知）
  @protected
  void safeNotify() {
    if (!_isDisposed) notifyListeners();
  }
}

/*
// 子类 Controller
class CounterController extends BaseController {
  final AnalyticsService _analytics; // 依赖注入示例
  int _count = 0;

  int get count => _count;

  CounterController(this._analytics);

  void increment() {
    _count++;
    _analytics.trackEvent('counter_increment');
    safeNotify();
  }

  Future<void> asyncIncrement() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      _count += 2;
      safeNotify();
    } catch (e) {
      handleError(e);
    }
  }

  @override
  void onDispose() {
    _analytics.dispose();
    super.onDispose();
  }
}
* */
