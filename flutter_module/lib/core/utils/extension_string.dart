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
}











