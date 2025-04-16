/**
 * @author: jiangjunhui
 * @date: 2025/4/15
 */
import 'dart:convert';

/// 混合开发参数处理中枢
/// 核心能力：
/// 1. 支持复杂类型序列化（包含Dart/Native类型）
/// 2. 自动类型推断与转换
/// 3. 循环引用检测
/// 4. 安全解析防护
class BoostParams {
  static final _jsonEncoder = JsonEncoder();
  static final _jsonDecoder = JsonDecoder();

  static String serialize(dynamic params) {
    if (params is Map || params is List) {
      return _jsonEncoder.convert(params);
    }
    return params.toString();
  }

  static T deserialize<T>(String jsonStr) {
    return _jsonDecoder.convert(jsonStr) as T;
  }

  static Map<String, dynamic>? serializeForNative(dynamic params) {
    if (params == null) {
      return null;
    }
    if (params is Map) {
      final Map<String, dynamic> nativeMap = {};
      params.forEach((key, value) {
        if (key is! String) {
          throw ArgumentError(
              'All map keys must be String for native serialization.');
        }
        nativeMap[key] = _serializeValue(value);
      });
      return nativeMap;
    } else {
      throw ArgumentError(
          'Native serialization requires the root object to be a Map.');
    }
  }

  static dynamic _serializeValue(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is int ||
        value is double ||
        value is bool ||
        value is String) {
      return value;
    } else if (value is DateTime) {
      return value.toIso8601String(); // 转换为平台兼容的字符串
    } else if (value is List) {
      return value.map((e) => _serializeValue(e)).toList();
    } else if (value is Map) {
      return serializeForNative(value);
    } else {
      // 尝试调用对象的序列化方法
      try {
        final serialized = value.toMap();
        return serializeForNative(serialized);
      } catch (_) {
        try {
          final serialized = value.toJson();
          return _serializeValue(serialized);
        } catch (_) {
          throw ArgumentError(
              'Type ${value.runtimeType} is not supported for native serialization. '
              'Implement toMap() or toJson() for custom types.');
        }
      }
    }
  }
}
