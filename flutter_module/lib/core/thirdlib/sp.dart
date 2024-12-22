/**
 * @author: jiangjunhui
 * @date: 2024/12/6
 */
import 'package:shared_preferences/shared_preferences.dart';


class PreferencesHelper {
  late SharedPreferences _preferences;
  PreferencesHelper._();

  static late PreferencesHelper _instance;

  // 获取单例实例
  static PreferencesHelper get instance => _getInstance();

  static PreferencesHelper _getInstance() {
    if (_instance == null) {
      _instance = PreferencesHelper._();
      _instance._init();
    }
    return _instance;
  }

  // 初始化 SharedPreferences
  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // 异步获取字符串值，带默认值
  Future<String?> getString(String key) async {
    return _preferences.getString(key);
  }

  // 异步设置字符串值
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  // 异步获取整数值，带默认值
  Future<int?> getInt(String key) async {
    return _preferences.getInt(key);
  }

  // 异步设置整数值
  Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  // 异步获取布尔值，带默认值
  Future<bool?> getBool(String key) async {
    return _preferences.getBool(key);
  }

  // 异步设置布尔值
  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  // 异步获取双精度浮点数值，带默认值
  Future<double?> getDouble(String key) async {
    return _preferences.getDouble(key);
  }

  // 异步设置双精度浮点数值
  Future<void> setDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  /// get keys.
  /// 获取sp中所有的key
  Future<Set<String>> getKeys() async {
    return _preferences.getKeys();
  }

  /// remove.
  /// 移除sp中key的值
  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  // 清除所有键值对
  Future<void> clear() async {
    await _preferences.clear();
  }
}
