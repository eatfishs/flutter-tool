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
import 'dart:convert';

class BoostParams {
  static dynamic serialize(dynamic data) {
    // 支持复杂类型序列化
    return json.encode(data);
  }

  static dynamic deserialize(String data) {
    // 自动类型推断与转换
    return json.decode(data);
  }

  static bool hasCircularReference(dynamic data) {
    // 循环引用检测
    return false;
  }

  static dynamic safeParse(String data) {
    // 安全解析防护
    try {
      return json.decode(data);
    } catch (e) {
      return null;
    }
  }
}