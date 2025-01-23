import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// 缓存策略
enum MyCachePolicy {
  /// 不用缓存
  none,

  /// 先用缓存，在请求网络，得到网络数据后覆盖缓存
  firstCache,

  /// 先请求网络，失败后再返回缓存
  firstRequest,

  /// 先用缓存，在请求网络，得到网络数据后覆盖缓存，并且请求数据重新抛出去
  firstCacheRequest
}

class CacheInterceptor extends Interceptor {
  final MyCachePolicy cachePolicy;

  CacheInterceptor({required this.cachePolicy});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (cachePolicy == MyCachePolicy.none) {
      handler.next(options);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final cacheKey = '${options.method}-${options.uri.toString()}';
    if (cachePolicy == MyCachePolicy.firstCache || cachePolicy == MyCachePolicy.firstCacheRequest) {
      final cachedData = prefs.getString(cacheKey);
      if (cachedData!= null) {
        handler.resolve(Response(
          requestOptions: options,
          data: jsonDecode(cachedData),
          statusCode: 200,
        ));
      }
    }
    if (cachePolicy == MyCachePolicy.firstRequest) {
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (cachePolicy == MyCachePolicy.none) {
      handler.next(response);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final cacheKey = '${response.requestOptions.method}-${response.requestOptions.uri.toString()}';
    final jsonData = jsonEncode(response.data);
    await prefs.setString(cacheKey, jsonData);
    if (cachePolicy == MyCachePolicy.firstCacheRequest) {
      handler.next(response);
    } else if (cachePolicy == MyCachePolicy.firstRequest) {
      handler.next(response);
    } else {
      handler.resolve(Response(
        requestOptions: response.requestOptions,
        data: jsonDecode(jsonData),
        statusCode: 200,
      ));
    }
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    if (cachePolicy == MyCachePolicy.none || cachePolicy == MyCachePolicy.firstCache || cachePolicy == MyCachePolicy.firstCacheRequest) {
      handler.next(error);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final cacheKey = '${error.requestOptions.method}-${error.requestOptions.uri.toString()}';
    final cachedData = prefs.getString(cacheKey);
    if (cachePolicy == MyCachePolicy.firstRequest) {
      if (cachedData!= null) {
        handler.resolve(Response(
          requestOptions: error.requestOptions,
          data: jsonDecode(cachedData),
          statusCode: 200,
        ));
      } else {
        handler.next(error);
      }
    }
  }
}