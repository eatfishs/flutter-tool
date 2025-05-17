/// @author: jiangjunhui
/// @date: 2025/1/24
library;
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  /// 切圆角
  Widget withRoundedCorners(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  /// 点击事件
  Widget onTap(void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  /**
   * Text('Press and hold me').onLongPress(() {
      print('Long pressed!');
      });
   * */
  /// 长按事件
  Widget onLongPress(void Function()? onLongPress) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: this,
    );
  }

}
