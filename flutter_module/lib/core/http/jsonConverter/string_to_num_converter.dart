/**
 * @author: jiangjunhui
 * @date: 2025/2/10
 */
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

// 自定义转换器，将 String 转换为 num
class StringToNumConverter implements JsonConverter<num?, String?> {
  const StringToNumConverter();

  @override
  num? fromJson(String? json) {
    return json != null ? num.tryParse(json) : null;
  }

  @override
  String? toJson(num? object) {
    return object?.toString();
  }
}



// 自定义 String 转 int 类型转换器
class StringToIntConverter implements JsonConverter<int?, String?> {
  const StringToIntConverter();

  @override
  int? fromJson(String? json) {
    // 如果 json 不为空，尝试将其解析为 int 类型；若解析失败则返回 null
    return json != null ? int.tryParse(json) : null;
  }

  @override
  String? toJson(int? object) {
    // 将 int 类型对象转换为 String 类型
    return object?.toString();
  }
}

 
 
 
 
 
 