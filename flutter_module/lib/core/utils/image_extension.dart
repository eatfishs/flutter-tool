/// @author: jiangjunhui
/// @date: 2025/1/24
library;
import 'package:flutter/material.dart';

extension ImageExtension on Image {
  /**
   * Image.asset('assets/images/sample.jpg', width: 200, height: 200)
      .rotate(45), // 使用旋转扩展方法，将图片旋转 45 度
   */

  /// 根据指定的角度旋转图片
  Widget rotate(double degrees) {
    return Transform.rotate(
      angle: degrees * (3.1415926 / 180),
      child: this,
    );
  }


  ///  图片灰度
  Widget toGrayscale() {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0, 0, 0, 1, 0,
      ]),
      child: this,
    );
  }

}

 
 
 
 
 
 
 
 
 