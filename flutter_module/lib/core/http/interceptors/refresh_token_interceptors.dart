/**
 * @author: jiangjunhui
 * @date: 2025/1/22
 */
import 'package:dio/dio.dart';
import 'dart:async';

/**
 * 用户权限鉴定、token刷新
 */

class RefreshTokenInterceptor extends Interceptor {
  String? _token;
  Completer<String>? _refreshTokenCompleter;

  Future<String> _fetchToken() async {
    // 这里模拟请求 Token 的过程，实际应用中可以使用 dio 或其他方式发送请求获取
    await Future.delayed(Duration(seconds: 1));
    return 'your_token_value';
  }

  Future<String> _getToken() async {
    if (_refreshTokenCompleter == null) {
      _refreshTokenCompleter = Completer<String>();
      try {
        _token = await _fetchToken();
        _refreshTokenCompleter!.complete(_token);
      } catch (e) {
        _refreshTokenCompleter!.completeError(e);
      }
    }
    return _refreshTokenCompleter!.future;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_token == null) {
      try {
        _token = await _getToken();
        options.headers['Token'] = _token;
        handler.next(options);
      } catch (e) {
        handler.reject(DioError(requestOptions: options, error: e));
      }
    } else {
      options.headers['Token'] = _token;
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    handler.next(error);
  }
}
 
 
 
 
 
 
 
 
 
 
 
 
 