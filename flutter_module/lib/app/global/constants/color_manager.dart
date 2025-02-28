/**
 * @author: jiangjunhui
 * @date: 2025/2/28
 */
import 'package:flutter/material.dart';
import 'dart:ui';

// 定义颜色模式枚举
enum ColorMode {
  light,
  dark,
}

// 颜色管理类
class ColorManager {
  // 当前颜色模式
  static ColorMode _currentMode = ColorMode.light;

  // 设置颜色模式
  static void setColorMode(ColorMode mode) {
    _currentMode = mode;
  }

  // 获取当前颜色模式
  static ColorMode get currentMode => _currentMode;

  // 获取背景颜色
  static Color get backgroundColor {
    return _currentMode == ColorMode.light
        ? const Color(0xFFFFFFFF) // 白天模式白色背景
        : const Color(0xFF000000); // 暗夜模式黑色背景
  }

  // 获取文本颜色
  static Color get textColor {
    return _currentMode == ColorMode.light
        ? const Color(0xFF000000) // 白天模式黑色文本
        : const Color(0xFFFFFFFF); // 暗夜模式白色文本
  }

  // 获取主要颜色
  static Color get primaryColor {
    return _currentMode == ColorMode.light
        ? const Color(0xFF007BFF) // 白天模式蓝色主要颜色
        : const Color(0xFF0056b3); // 暗夜模式深蓝色主要颜色
  }
}
