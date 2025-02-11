import 'dart:async';
import 'package:dio/dio.dart';
import '../../utils/date_untils.dart';
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
  Dio _dio = Dio();
  late final MyRequestOptions _options;
  late final List<Interceptor>? _interceptors;

  NetworkService(
      {required MyRequestOptions options, List<Interceptor>? interceptors})
      : _interceptors = interceptors,
        _options = options {
    // 基本配置
    configureOptions(options);

    // 拦截器
    List<Interceptor> interceptorList = _interceptors ?? [];
    if (interceptorList.isNotEmpty) {
      for (Interceptor item in interceptorList) {
        _dio.interceptors.add(item);
        _interceptors?.add(item);
      }
    } else {
      _addDefaultInterceptors();
    }
  }

  /// 配置options
  void configureOptions(MyRequestOptions options) {
    _options = options;

    _dio.options.baseUrl = _options.baseUrl;
    _dio.options.connectTimeout = _options.connectTimeout;
    _dio.options.receiveTimeout = _options.receiveTimeout;
    _dio.options.headers = _options.headers;
  }

  /// 配置拦截器
  void configureInterceptors(List<Interceptor> interceptorList) {
    // 移除所有拦截器
    _dio.interceptors.clear();
    // 添加新的拦截器
    for (Interceptor item in interceptorList) {
      _dio.interceptors.add(item);
      _interceptors?.add(item);
    }
  }


  /// 添加拦截器
  void _addDefaultInterceptors() {
    // 刷新token
    _dio.interceptors.add(RefreshTokenInterceptor());
    // 弹窗
    _dio.interceptors
        .add(LoadingInterceptor(isShowLoading: true, showErrorLoading: true));
    // 添加日志打印拦截器
    _dio.interceptors.add(CustomLogInterceptor());
    // 数据转换拦截器
    _dio.interceptors.add(DataTransformInterceptor());
    // 添加错误处理拦截器
    _dio.interceptors.add(ErrorHandleInterceptor());
    // 缓存拦截器
    MyNetworkCacheManager cacheManager = MyNetworkCacheManager();
    _dio.interceptors.add(CustomCacheInterceptor(cacheManager: cacheManager));
  }

  // GET 请求方法
  Future<MyBaseModel<T>> get<T>(
      {required T Function(Object? json) fromJsonT}) async {
    _options.method = MyRequestMethod.get;
    // 发起请求
    MyResopnseModel response = await _request(_options);

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
  Future<MyBaseListModel<T>> getList<T>(
      {required T Function(Object? json) fromJsonT}) async {
    _options.method = MyRequestMethod.get;
    // 发起请求
    MyResopnseModel response = await _request(_options);
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
  Future<MyBaseModel<T>> post<T>(
      {required T Function(Object? json) fromJsonT}) async {
    _options.method = MyRequestMethod.post;
    // 发起请求
    MyResopnseModel response = await _request(_options);
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
  Future<MyBaseListModel<T>> postList<T>(
      {required T Function(Object? json) fromJsonT}) async {
    _options.method = MyRequestMethod.post;
    // 发起请求
    MyResopnseModel response = await _request(_options);
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
  Future<MyResopnseModel> _request(MyRequestOptions options) async {
    CancelToken cancelToken =
        MyDioManager.instance.getCancelToken(options: _options);
    try {
      print("当前时间戳3：${MyDateTimeUtil.getTimeStamp()}");
      Response? response;
      if (options.method == MyRequestMethod.get) {
        response = await _dio.get(
          _options.urlPath,
          queryParameters: _options.params,
          cancelToken: cancelToken,
        );
        print("当前时间戳4：${MyDateTimeUtil.getTimeStamp()}");
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
  }
}
