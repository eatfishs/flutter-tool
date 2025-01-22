/**
 * @author: jiangjunhui
 * @date: 2024/12/6
 */
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  /// 异步设置字符串值
  static Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /// 异步获取字符串值，带默认值
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    return value;
  }

  /// 异步设置整数值
  static Future<void> setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  /// 异步获取整数值，带默认值
  static Future<int?> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(key);
    return value;
  }

  /// 异步设置布尔值
  static Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  /// 异步获取布尔值，带默认值
  static Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(key);
    return value;
  }

/// 异步设置双精度浮点数值
  static Future<void> setDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  /// 异步获取双精度浮点数值，带默认值
  static Future<double?> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? value = prefs.getDouble(key);
    return value;
  }

  /// get keys.
  /// 获取sp中所有的key
  static Future<Set<String>> getKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }

  /// remove.
  /// 移除sp中key的值
  static Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  /// 清除所有键值对
  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
