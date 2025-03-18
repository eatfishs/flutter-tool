/**
 * @author: jiangjunhui
 * @date: 2025/2/28
 */
import 'package:flutter/material.dart';

class TextSizeManager {
  // 设计稿基准宽度，根据实际设计稿修改
  static const double baseWidth = 375;

  // 根据设备宽度计算适配后的文字大小
  static double getAdaptiveTextSize(BuildContext context, double originalSize) {
    // 获取当前设备的屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;
    // 计算缩放比例
    double scale = screenWidth / baseWidth;
    // 返回适配后的文字大小
    return originalSize * scale;
  }

  // 提供不同字号的获取方法
  static double getSmallTextSize(BuildContext context) {
    return getAdaptiveTextSize(context, 12);
  }

  static double getMediumTextSize(BuildContext context) {
    return getAdaptiveTextSize(context, 16);
  }

  static double getLargeTextSize(BuildContext context) {
    return getAdaptiveTextSize(context, 20);
  }
}