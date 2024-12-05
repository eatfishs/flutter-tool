/**
 * @author: jiangjunhui
 * @date: 2024/12/5
 */
import 'dart:convert';
import 'object_utils.dart';
extension ExtensionList on List {
  /// Transform list to json
  /// 将list转化为json字符串
  String toJsonString() {
    return jsonEncode(this);
  }

  /// 将list转化为json字符串，换行
  String getJsonPretty() {
    return JsonEncoder.withIndent('\t').convert(this);
  }

  /// Checks if data is null.
  /// 判断对象是否为null
  bool isNull() => ObjectUtils.isNull(this);

  /// Checks if data is null or Blank (Empty or only contains whitespace).
  /// 检查数据是否为空或空(空或只包含空格)
  bool isNullOrBlank() => ObjectUtils.isNullOrBlank(this);

}