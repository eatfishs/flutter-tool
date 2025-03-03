/**
 * @author: jiangjunhui
 * @date: 2025/3/3
 */
import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:flutter_module/core/log/log.dart';

// 弹窗类型枚举
enum DialogType {
  center, // 中间弹窗
  bottom, // 底部弹窗
}

// 弹窗队列管理器（支持多种弹窗类型）
class DialogQueue {
  static final DialogQueue _instance = DialogQueue._internal();

  factory DialogQueue() => _instance;

  DialogQueue._internal();

  final Queue<DialogConfig> _queue = Queue();
  bool _isDialogShowing = false;

  // 添加弹窗到队列
  void add({
    required BuildContext context,
    required WidgetBuilder builder,
    DialogType type = DialogType.center,
    VoidCallback? onDismiss,
    Color? backgroundColor, // 底部弹窗专用参数
    ShapeBorder? shape, // 底部弹窗专用参数
  }) {
    _queue.add(DialogConfig(
      context: context,
      builder: builder,
      type: type,
      onDismiss: onDismiss,
      backgroundColor: backgroundColor,
      shape: shape,
    ));

    _checkNext();
  }

  // 显示弹窗核心逻辑
  void _checkNext() async {

    Log.error("_queue.length:${_queue.isEmpty}-->_isDialogShowing:${_isDialogShowing}");
    if (_queue.isEmpty || _isDialogShowing) return;

    _isDialogShowing = true;
    final config = _queue.removeFirst();

    switch (config.type) {
      case DialogType.center:
        await _showCenterDialog(config);
        break;
      case DialogType.bottom:
        await _showBottomSheet(config);
        break;
    }

    config.onDismiss?.call();
    _isDialogShowing = false;
    _checkNext();
  }

  // 显示中间弹窗
  Future<void> _showCenterDialog(DialogConfig config) async {
    await showDialog(
      context: config.context,
      builder: config.builder,
      // 设置点击背景时对话框不消失
      barrierDismissible: false,
    );
  }

  // 显示底部弹窗
  Future<void> _showBottomSheet(DialogConfig config) async {
    final ShapeBorder shape = config.shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        );

    await showModalBottomSheet(
      context: config.context,
      backgroundColor: config.backgroundColor ?? Colors.white,
      shape: shape,
      isDismissible: false,
      enableDrag: false,
      builder: config.builder,
      isScrollControlled: false,
    );
  }
}

// 弹窗配置增强类
class DialogConfig {
  final BuildContext context;
  final WidgetBuilder builder;
  final DialogType type;
  final VoidCallback? onDismiss;
  final Color? backgroundColor;
  final ShapeBorder? shape;

  DialogConfig({
    required this.context,
    required this.builder,
    this.type = DialogType.center,
    this.onDismiss,
    this.backgroundColor,
    this.shape,
  });
}
