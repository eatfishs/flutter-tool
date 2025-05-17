/// @author: jiangjunhui
/// @date: 2024/12/5
library;
import 'dart:convert';

/// json 格式转化工具类
class JsonUtils {
  // 将 Map 转换为 String
  static String mapToString(Map<String, dynamic> map) {
    return map.toString();
  }

  // 将 String 转换为 Map
  static Map<String, dynamic> stringToMap(String str) {
    return str.isNotEmpty ? Map<String, dynamic>.from(json.decode(str)) : {};
  }

  // 将 List 转换为 String
  static String listToString(List<dynamic> list) {
    return list.toString();
  }

  // 将 String 转换为 List
  static List<dynamic> stringToList(String str) {
    return str.isNotEmpty ? List<dynamic>.from(json.decode(str)) : [];
  }

  // 将 Map 转换为 List
  static List<dynamic> mapToList(Map<String, dynamic> map) {
    return map.entries.map((entry) => entry.value).toList();
  }

  // 将 List 转换为 Map
  static Map<String, dynamic> listToMap(List<dynamic> list) {
    Map<String, dynamic> result = {};
    for (int i = 0; i < list.length; i++) {
      result['item_$i'] = list[i];
    }
    return result;
  }
}
