/**
 * @author: jiangjunhui
 * @date: 2025/2/8
 */

import 'package:flutter_screenutil/flutter_screenutil.dart';

// 为 int 类型添加扩展
extension IntScreenExtensions on int {
  /// 转换为适配后的像素值
  double get px => toDouble().w;

  /// 转换为适配后的响应式像素值（这里使用与 px 相同逻辑，可按需调整）
  double get rpx => toDouble().w;
}

// 为 double 类型添加扩展
extension DoubleScreenExtensions on double {
  /// 转换为适配后的像素值
  double get px => w;

  /// 转换为适配后的响应式像素值（这里使用与 px 相同逻辑，可按需调整）
  double get rpx => w;
}
 
 
 
 
 
 
 
 
 
 