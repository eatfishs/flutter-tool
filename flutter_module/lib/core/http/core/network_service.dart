import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_module/core/http/core/my_dio_manager.dart';
import 'package:flutter_module/core/http/interceptors/data_transform_Interceptor.dart';
import 'package:flutter_module/core/http/interceptors/error_handle_Interceptor.dart';
import 'package:flutter_module/core/http/interceptors/loading_interceptor.dart';
import 'package:flutter_module/core/http/interceptors/refresh_token_interceptors.dart';

import '../interceptors/logging_interceptor.dart';
import 'my_cache_newwork_manager.dart';
import 'my_request_options.dart';

class NetworkService {
  Dio _dio = Dio();
  final MyRequestOptions options;
  final List<Interceptor>? interceptors;

  NetworkService({required this.options, this.interceptors}) {
    // 基本配置
    _dio.options.baseUrl = options.baseUrl;
    _dio.options.connectTimeout = options.connectTimeout;
    _dio.options.receiveTimeout = options.receiveTimeout;
    _dio.options.headers = options.headers;
    _dio.options.contentType = options.contentType;
    // if interceptors
    // 拦截器
    _addInterceptors();
  }

  /// 添加拦截器
  void _addInterceptors() {
    // 添加日志打印拦截器
    _dio.interceptors.add(LoggingInterceptor());
    // 刷新token
    _dio.interceptors.add(RefreshTokenInterceptor());
    // 数据转换拦截器
    _dio.interceptors.add(DataTransformInterceptor());
    // 添加错误处理拦截器
    _dio.interceptors.add(ErrorHandleInterceptor());
    // 弹窗
    _dio.interceptors
        .add(LoadingInterceptor(isShowLoading: true, showErrorLoading: true));
  }

  // GET 请求方法
  Future<Response> get() async {
    CancelToken cancelToken =
        MyDioManager.instance.getCancelToken(options: options);
    try {
      // 发起请求
      Response _response = await _dio.get(
        options.urlPath,
        queryParameters: options.params,
        cancelToken: cancelToken,
      );

      return _response;
    } on DioError catch (e) {
      // 可以添加更详细的错误处理逻辑
      print('Error occurred during GET request: ${e.message}');
      rethrow;
    } finally {
      String cancelTokenKey =
          MyDioManager.instance.getCancelTokenKey(options: options);
      MyDioManager.instance.cancelTokens.remove(cancelTokenKey);
    }
  }

  //  POST 请求方法
  Future<Response> post() async {
    CancelToken cancelToken =
        MyDioManager.instance.getCancelToken(options: options);
    try {
      // 发起请求
      Response _response = await _dio.post(
        options.urlPath,
        queryParameters: options.params,
        cancelToken: cancelToken,
      );

      return _response;
    } on DioError catch (e) {
      // 可以添加更详细的错误处理逻辑
      print('Error occurred during GET request: ${e.message}');
      rethrow;
    } finally {
      String cancelTokenKey =
          MyDioManager.instance.getCancelTokenKey(options: options);
      MyDioManager.instance.cancelTokens.remove(cancelTokenKey);
    }
  }
}
