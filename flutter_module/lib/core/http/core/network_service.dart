import 'dart:async';
import 'package:dio/dio.dart';
import '../manager/my_dio_manager.dart';
import '../interceptors/data_transform_Interceptor.dart';
import '../interceptors/error_handle_Interceptor.dart';
import '../interceptors/loading_interceptor.dart';
import '../interceptors/refresh_token_interceptors.dart';
import '../interceptors/custom_log_interceptor.dart';
import '../model/my_base_list_model.dart';
import '../model/my_base_model.dart';
import '../model/my_error.dart';
import '../model/my_response_model.dart';
import 'my_request_options.dart';

class NetworkService<T> {
  Dio _dio = Dio();
  final MyRequestOptions _options;
  final List<Interceptor>? _interceptors;

  NetworkService(
      {required MyRequestOptions options, List<Interceptor>? interceptors})
      : _interceptors = interceptors,
        _options = options {
    // 基本配置
    _dio.options.baseUrl = _options.baseUrl;
    _dio.options.connectTimeout = _options.connectTimeout;
    _dio.options.receiveTimeout = _options.receiveTimeout;
    _dio.options.headers = _options.headers;
    _dio.options.contentType = _options.contentType;

    // 拦截器
    List<Interceptor> interceptorList = _interceptors ?? [];
    if (interceptorList.isNotEmpty) {
      for (Interceptor _interceptors in interceptorList) {
        _dio.interceptors.add(_interceptors);
      }
    } else {
      _addInterceptors();
    }
  }

  /// 添加拦截器
  void _addInterceptors() {
    // 添加日志打印拦截器
    _dio.interceptors.add(CustomLogInterceptor());
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
  Future<MyBaseModel<T>> get<T>(
      MyRequestOptions options, T Function(Object? json) fromJsonT) async {
    // 发起请求
    MyResopnseModel response = await _request(options);
    if (response.isHttpSucess() == true) {
      return MyBaseModel.fromJson(
        response.data,
        fromJsonT,
      );
    } else {
      throw _handleError(resopnse: response);
    }
  }

  // GET 请求方法
  Future<MyBaseListModel<T>> getList<T>(
      MyRequestOptions options, T Function(Object? json) fromJsonT) async {
    // 发起请求
    MyResopnseModel response = await _request(options);
    if (response.isHttpSucess() == true) {
      return MyBaseListModel.fromJson(
        response.data,
        fromJsonT,
      );
    } else {
      throw _handleError(resopnse:response);
    }
  }

  //  POST 请求方法
  Future<MyBaseModel<T>> post<T>(
      MyRequestOptions options, T Function(Object? json) fromJsonT) async {
    // 发起请求
    MyResopnseModel response = await _request(options);
    if (response.isHttpSucess() == true) {
      return MyBaseModel.fromJson(
        response.data,
        fromJsonT,
      );
    } else {
      throw _handleError(resopnse:response);
    }
  }

  //  POST 请求方法
  Future<MyBaseListModel<T>> postList<T>(
      MyRequestOptions options, T Function(Object? json) fromJsonT) async {
    // 发起请求
    MyResopnseModel response = await _request(options);
    if (response.isHttpSucess() == true) {
      return MyBaseListModel.fromJson(
        response.data,
        fromJsonT,
      );
    } else {
      throw _handleError(resopnse:response);
    }
  }

  /// 发起请求
  Future<MyResopnseModel> _request(MyRequestOptions options) async {
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
  MyDioExceptionModel _handleError({MyResopnseModel? resopnse, DioError? e}) {
    return MyDioExceptionModel(e: e);
  }
}
