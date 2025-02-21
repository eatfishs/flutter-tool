/**
 * @author: jiangjunhui
 * @date: 2025/1/23
 */
import 'dart:convert';

import 'package:dio/dio.dart';

import '../manager/my_cache_newwork_manager.dart';

class CustomCacheInterceptor extends Interceptor {
  // 缓存管理类
  final MyNetworkCacheManager cacheManager;

  CustomCacheInterceptor({required this.cacheManager});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final MyNetworkCachePolicy cachePolicy = cacheManager.cachePolicy;

    if (cachePolicy == MyNetworkCachePolicy.firstCache ||
        cachePolicy == MyNetworkCachePolicy.firstCacheRequest) {
      final cacheJsonString = await cacheManager.getCacheData(options);
      if (cacheJsonString != null) {
        // 有缓存数据，先返回缓存响应
        final response = Response(
          requestOptions: options,
          data: json.decode(cacheJsonString),
          statusCode: 200,
        );
        handler.resolve(response);

        // 对于需要继续请求的情况
        if (cachePolicy == MyNetworkCachePolicy.firstCacheRequest) {
          // 继续执行原始请求
          handler.next(options);
          return;
        }

        return;
      }
    }

    // 继续请求网络
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 请求成功响应
    if (response.statusCode == 200 &&
        cacheManager.cachePolicy != MyNetworkCachePolicy.none) {
      try {
        String data = json.encode(response.data);
        cacheManager.saveCache(response.requestOptions, data);
      } catch (e) {}
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
        return handler.resolve(response);
      }
    }

    // 继续传递错误
    handler.next(err);
  }
}
