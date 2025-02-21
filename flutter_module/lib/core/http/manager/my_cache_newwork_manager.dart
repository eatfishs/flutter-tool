/**
 * @author: jiangjunhui
 * @date: 2025/1/23
 */
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_module/core/utils/extension_string.dart';
import '../../data/file/file_utils.dart';


/// 缓存策略
enum MyNetworkCachePolicy {
  /// 不用缓存
  none,

  /// 先用缓存，在请求网络，得到网络数据后覆盖缓存
  firstCache,

  /// 先请求网络，失败后再返回缓存
  firstRequest,

  /// 先用缓存，在请求网络，得到网络数据后覆盖缓存，并且请求数据重新抛出去
  /// 这个策略 需要自己组装两次请求，不然对封装效果不好
  firstCacheRequest
}

class MyNetworkCacheManager {
  /// 缓存策略
  final MyNetworkCachePolicy cachePolicy = MyNetworkCachePolicy.none;
  /// 缓存过期时间（单位：秒）
  final int cacheExpirationTime = 24 * 60 * 60;

  /// 获取缓存
  Future<String?> getCacheData(RequestOptions options) async {
    final filePath = _getFilePath(options);
    final fileUtils = FileUtils();
    String? jsonString = await fileUtils.getFile(filePath);

    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonString.toMap();
      int timestamp = jsonMap['timestamp'];
      // 检查缓存是否过期
      if (DateTime.now().millisecondsSinceEpoch - timestamp < cacheExpirationTime * 1000) {
        return jsonMap['data'];
      }
      // 若缓存过期，删除缓存
      await _remove(options);
      return null;
    }
    return null;
  }

  /// 保存缓存
  Future<void> saveCache(RequestOptions options, String data) async {
    final filePath = _getFilePath(options);
    final fileUtils = FileUtils();
    Map<String, dynamic> cachedData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': data
    };
    final jsonString = json.encode(cachedData);
    fileUtils.writeFile(filePath, jsonString);
  }


  Future<void> _remove(RequestOptions options) async{
    final filePath = _getFilePath(options);
    final fileUtils = FileUtils();
    fileUtils.removeFilePath(filePath);
  }

  /// 获取文件路径
  String _getFilePath(RequestOptions options) {
    String url = options.uri.toString();
    String paramJsonString = options.queryParameters.toString();
    String method = options.method;
    return (method + url + paramJsonString).md5Hash();
  }
}

