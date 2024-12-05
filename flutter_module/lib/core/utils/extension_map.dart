/**
 * @author: jiangjunhui
 * @date: 2024/12/5
 */
import 'dart:convert';
import 'object_utils.dart';

extension ExtensionMap on Map {
  /// Transform map to json
  /// 将map转化为json字符串
  String toJsonString() {
    return jsonEncode(this);
  }

  /// Checks if data is null.
  /// 检查数据是否为空或空
  bool isNull() => ObjectUtils.isNull(this);

  /// Checks if data is null or Blank (Empty or only contains whitespace).
  /// 检查数据是否为空或空
  bool isNullOrBlank() => ObjectUtils.isNullOrBlank(this);
}