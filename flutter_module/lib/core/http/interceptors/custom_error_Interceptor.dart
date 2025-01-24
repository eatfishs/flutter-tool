/**
 * @author: jiangjunhui
 * @date: 2025/1/23
 */
import 'dart:convert';

import 'package:dio/dio.dart';
import '../core/my_cache_newwork_manager.dart';

class CustomErrorInterceptor extends Interceptor {
  // 缓存管理类
  final MyNetworkCacheManager cacheManager;

  CustomErrorInterceptor({required this.cacheManager});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (cacheManager.cachePolicy == MyNetworkCachePolicy.firstCache) {
      final cacheJsonString = await cacheManager.getCacheData(options);
      if (cacheJsonString != null) {
        // 有缓存数据，先返回缓存响应
        final response = Response(
          requestOptions: options,
          data: json.decode(cacheJsonString),
          statusCode: 200,
        );
        handler.resolve(response);
      }
    }

    // 继续请求网络
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (cacheManager.cachePolicy == MyNetworkCachePolicy.firstCache ||
        cacheManager.cachePolicy == MyNetworkCachePolicy.firstRequest) {
      try {
        String data = json.encode(response.data);
        cacheManager.saveCache(response.requestOptions, data);
      } catch (e) {
        handler.next(response);
      }
    }

    handler.next(response);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (cacheManager.cachePolicy == MyNetworkCachePolicy.firstRequest) {
      final cacheJsonString =
          await cacheManager.getCacheData(err.requestOptions);
      if (cacheJsonString != null) {
        // 有缓存数据，先返回缓存响应
        final response = Response(
          requestOptions: err.requestOptions,
          data: json.decode(cacheJsonString),
          statusCode: 200,
        );
        // 返回正确的响应
        handler.resolve(response);
      }
    } else {
      // 继续传递错误
      handler.next(err);
    }
  }
}
