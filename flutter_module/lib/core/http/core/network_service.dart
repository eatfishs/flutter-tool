import 'dart:async';
import 'package:dio/dio.dart';
import '../interceptors/custom_cache_Interceptor.dart';
import '../manager/my_cache_newwork_manager.dart';
import '../manager/my_dio_manager.dart';
import '../interceptors/data_transform_Interceptor.dart';
import '../interceptors/error_handle_Interceptor.dart';
import '../interceptors/loading_interceptor.dart';
import '../interceptors/refresh_token_interceptors.dart';
import '../interceptors/custom_log_interceptor.dart';
import '../model/my_base_list_model.dart';
import '../model/my_base_model.dart';
import '../model/my_response_model.dart';
import 'my_request_options.dart';

class NetworkService<T> {
  late Dio _dio = Dio();
  late MyRequestOptions _options;
  List<Interceptor>? _interceptors;

  NetworkService(
      {List<Interceptor>? interceptors}):
        _interceptors = interceptors {
  /// 配置拦截器
  configureInterceptors(_interceptors);
}

/// 配置options
void configureOptions(MyRequestOptions options) {
  print("_________options:${options.urlPath}");
  _options = options;
  _dio.options.baseUrl = _options.baseUrl;
  _dio.options.connectTimeout = _options.connectTimeout;
  _dio.options.receiveTimeout = _options.receiveTimeout;
  _dio.options.headers = _options.headers;
}

/// 配置拦截器
void configureInterceptors(List<Interceptor>? interceptors) {
  // 移除所有拦截器
  _dio.interceptors.clear();
  // 配置拦截器
  List<Interceptor> interceptorList = _interceptors ?? [];
  if (interceptorList.isNotEmpty) {
    for (Interceptor item in interceptorList) {
      _dio.interceptors.add(item);
    }
  } else {
    _addDefaultInterceptors();
  }

  _interceptors = _dio.interceptors;
}

/// 添加拦截器
void _addDefaultInterceptors() {
  // 数据转换拦截器
  _dio.interceptors.add(DataTransformInterceptor());
  // 刷新token
  _dio.interceptors.add(RefreshTokenInterceptor());
  // 弹窗
  _dio.interceptors
      .add(LoadingInterceptor(isShowLoading: true));
  // 添加日志打印拦截器
  _dio.interceptors.add(CustomLogInterceptor());
  // 添加错误处理拦截器
  _dio.interceptors.add(ErrorHandleInterceptor(
      isShowHttpErrorMsg: true, isShowDataErrorMsg: true));
  // 缓存拦截器
  MyNetworkCacheManager cacheManager = MyNetworkCacheManager();
  _dio.interceptors.add(CustomCacheInterceptor(cacheManager: cacheManager));
}

// GET 请求方法
Future<MyBaseModel<T>> get<T>({required MyRequestOptions options,
  required T Function(Object? json) fromJsonT}) async {
  // 发起请求
  MyResopnseModel response = await _request(options: options);
  _options.method = MyRequestMethod.get;

  if (response.isHttpSucess() == true) {
    try {
      return MyBaseModel.fromJson(
        response.data,
        fromJsonT,
      );
    } catch (e, stackTrace) {
      print('json转model失败 Stack trace:'
          ' $stackTrace');
      print('json转model失败: $e');
      throw e;
    }
  } else {
    throw _handleError(resopnse: response);
  }
}

// GET 请求方法
Future<MyBaseListModel<T>> getList<T>({required MyRequestOptions options,
  required T Function(Object? json) fromJsonT}) async {
  // 发起请求
  MyResopnseModel response = await _request(options: options);
  _options.method = MyRequestMethod.get;
  if (response.isHttpSucess() == true) {
    return MyBaseListModel.fromJson(
      response.data,
      fromJsonT,
    );
  } else {
    throw _handleError(resopnse: response);
  }
}

//  POST 请求方法
Future<MyBaseModel<T>> post<T>({required MyRequestOptions options,
  required T Function(Object? json) fromJsonT}) async {
  // 发起请求
  MyResopnseModel response = await _request(options: options);
  _options.method = MyRequestMethod.post;

  if (response.isHttpSucess() == true) {
    return MyBaseModel.fromJson(
      response.data,
      fromJsonT,
    );
  } else {
    throw _handleError(resopnse: response);
  }
}

//  POST 请求方法
Future<MyBaseListModel<T>> postList<T>({required MyRequestOptions options,
  required T Function(Object? json) fromJsonT}) async {
  // 发起请求
  MyResopnseModel response = await _request(options: options);
  _options.method = MyRequestMethod.post;

  if (response.isHttpSucess() == true) {
    return MyBaseListModel.fromJson(
      response.data,
      fromJsonT,
    );
  } else {
    throw _handleError(resopnse: response);
  }
}

/// 发起请求
Future<MyResopnseModel> _request({required MyRequestOptions options}) async {
  // 配置options
  configureOptions(options);
  CancelToken cancelToken =
  MyDioManager.instance.getCancelToken(options: _options);
  try {
    Response? response;
    if (options.method == MyRequestMethod.get) {
      response = await _dio.get(
        _options.urlPath,
        queryParameters: _options.params,
        cancelToken: cancelToken,
      );
    } else if (options.method == MyRequestMethod.post) {
      response = await _dio.post(
        _options.urlPath,
        queryParameters: _options.params,
        cancelToken: cancelToken,
      );
    }
    if (response != null) {
      MyResopnseModel resopnseModel = MyResopnseModel(
          requestOptions: options,
          statusCode: response.statusCode,
          responseHeaders: response.headers.map,
          statusMessage: response.statusMessage,
          data: response.data);
      return resopnseModel;
    }
    throw Exception('没有定义的请求方式');
  } on DioError catch (e) {
    // 请求过程出错
    print(' 请求过程出错: ${e.message}');
    throw _handleError(e: e);
  } finally {
    String cancelTokenKey =
    MyDioManager.instance.getCancelTokenKey(options: _options);
    MyDioManager.instance.cancelTokens.remove(cancelTokenKey);
  }
}

/// 请求过程出错
String _handleError({MyResopnseModel? resopnse, DioError? e}) {
  return "";
}}
