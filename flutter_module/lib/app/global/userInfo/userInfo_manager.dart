/// @author: jiangjunhui
/// @date: 2025/3/11
library;

import 'dart:async';
import 'package:synchronized/synchronized.dart';

class UserInfoManager {
  // 静态私有实例
  static final UserInfoManager _instance = UserInfoManager._internal();

  // 工厂方法返回单例实例
  factory UserInfoManager() {
    return _instance;
  }

  // 私有构造函数
  UserInfoManager._internal();

  // 用于同步的锁
  final Lock _lock = Lock();

  // 用户 ID 变量
  String? _userId;

  // 获取用户 ID 的方法，使用锁确保线程安全
  Future<String?> getUserId() async {
    return await _lock.synchronized(() async {
      return _userId;
    });
  }

  // 设置用户 ID 的方法，使用锁确保线程安全
  Future<void> setUserId(String? userId) async {
    await _lock.synchronized(() async {
      _userId = userId;
    });
  }
}
