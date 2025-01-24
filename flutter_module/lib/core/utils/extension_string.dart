/**
 * @author: jiangjunhui
 * @date: 2024/12/22
 */
import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringMd5Extension on String {
  String md5Hash() {
    // 将字符串转换为字节数组
    var content = utf8.encode(this);
    // 使用 md5 算法进行加密
    var digest = md5.convert(content);
    // 将加密结果转换为 hex 字符串
    return digest.toString();
  }

  // 扩展方法，将字符串转换为 Map<String, dynamic>
  Map<String, dynamic> toMap() {
    try {
      // 使用 json.decode 尝试将字符串解析为 Map
      return json.decode(this) as Map<String, dynamic>;
    } catch (e) {
      // 若解析失败，打印错误信息并返回一个空 Map
      print('转换出错: $e');
      return {};
    }
  }
}
