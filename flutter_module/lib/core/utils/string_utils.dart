/// @author: jiangjunhui
/// @date: 2024/12/5
library;
import 'dart:convert';
import 'package:crypto/crypto.dart';
/// 文本工具类
class JHStingUtils {
  /// Base64 编码
  static String base64Encode(String input) {
    return base64.encode(input.codeUnits);
  }
  static String MD5(String input) {
    // 创建一个 MD5 实例
    var bytes = utf8.encode(input);
    var digest = md5.convert(bytes);
    // 将字节数组转换为十六进制字符串
    return digest.toString();
  }
  /// Base64 解码
  static String base64Decode(String input) {
    List<int> codeUnits = base64.decode(input);
    return String.fromCharCodes(codeUnits);
  }
  /// 判断文本内容是否为空
  static bool isEmpty(String? text) {
    return text == null || text.isEmpty;
  }

  /// 判断文本内容是否不为空
  static bool isNotEmpty(String text) {
    return !isEmpty(text);
  }

  /// 判断字符串是以xx开头
  static bool startsWith(String? str, Pattern prefix, [int index = 0]) {
    return str != null && str.startsWith(prefix, index);
  }

  /// 判断一个字符串以任何给定的前缀开始
  static bool startsWithAny(
    String? str,
    List<Pattern> prefixes, [
    int index = 0,
  ]) {
    return str != null &&
        prefixes.any((prefix) => str.startsWith(prefix, index));
  }

  /// 判断字符串中是否包含xx
  static bool contains(String? str, Pattern searchPattern,
      [int startIndex = 0]) {
    return str != null && str.contains(searchPattern, startIndex);
  }

  /// 判断一个字符串是否包含任何给定的搜索模式
  static bool containsAny(
    String? str,
    List<Pattern> searchPatterns, [
    int startIndex = 0,
  ]) {
    return str != null &&
        searchPatterns.any((prefix) => str.contains(prefix, startIndex));
  }

  /// 比较两个字符串是否相同
  static int compare(String? str1, String? str2) {
    if (str1 == str2) {
      return 0;
    }
    if (str1 == null || str2 == null) {
      return str1 == null ? -1 : 1;
    }
    return str1.compareTo(str2);
  }


  /// 每隔 x位 加 pattern。比如用来格式化银行卡
  static String formatDigitPattern(String text,
      {int digit = 4, String pattern = ' '}) {
    text = text.replaceAllMapped(RegExp('(.{$digit})'), (Match match) {
      return '${match.group(0)}$pattern';
    });
    if (text.endsWith(pattern)) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  /// 每隔 x位 加 pattern, 从末尾开始
  static String formatDigitPatternEnd(String text,
      {int digit = 4, String pattern = ' '}) {
    String temp = reverse(text);
    temp = formatDigitPattern(temp, digit: digit, pattern: pattern);
    temp = reverse(temp);
    return temp;
  }

  /// 每隔4位加空格
  static String formatSpace4(String text) {
    return formatDigitPattern(text);
  }

  /// 每隔3三位加逗号
  /// num 数字或数字字符串。int型。
  static String formatComma3(Object num) {
    return formatDigitPatternEnd(num.toString(), digit: 3, pattern: ',');
  }

  /// 每隔3三位加逗号
  /// num 数字或数字字符串。double型。
  static String formatDoubleComma3(Object num,
      {int digit = 3, String pattern = ','}) {
    List<String> list = num.toString().split('.');
    String left =
        formatDigitPatternEnd(list[0], digit: digit, pattern: pattern);
    String right = list[1];
    return '$left.$right';
  }

  /// 隐藏手机号中间n位
  static String hideNumber(String phoneNo,
      {int start = 3, int end = 7, String replacement = '****'}) {
    return phoneNo.replaceRange(start, end, replacement);
  }

  /// 替换字符串中的数据
  static String replace(String text, Pattern from, String replace) {
    return text.replaceAll(from, replace);
  }

  /// 按照正则切割字符串
  static List<String> split(String text, Pattern pattern) {
    return text.split(pattern);
  }

  /// 反转字符串
  static String reverse(String text) {
    if (isEmpty(text)) {
      return '';
    }
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      var codeUnitAt = text.codeUnitAt(i);
      sb.writeCharCode(codeUnitAt);
    }
    return sb.toString();
  }


}
