import 'package:dio/dio.dart';
import 'package:flutter_module/core/http/interceptors/cache_Interceptor.dart';
import 'package:flutter_module/core/http/interceptors/data_transform_Interceptor.dart';
import 'package:flutter_module/core/http/interceptors/error_handle_Interceptor.dart';
import 'package:flutter_module/core/http/interceptors/loading_interceptor.dart';
import 'package:flutter_module/core/http/interceptors/refresh_token_interceptors.dart';
import 'package:flutter_module/core/utils/extension_string.dart';
import '../interceptors/logging_interceptor.dart';
import 'my_request_options.dart';

/// FileName my_dio.dart
///
/// @Author jiangjunhui
/// @Date 2023/6/8 16:50
///
/// @Description TODO
///

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  late Dio _dio;
  final Map<String, CancelToken> _cancelTokens = {};

  // 私有构造函数，确保单例
  NetworkService._internal() {
    final options = MyRequestOptions();
    // 基本配置
    _dio = Dio();
    _dio.options.baseUrl = options.baseUrl;
    _dio.options.connectTimeout = options.connectTimeout;
    _dio.options.receiveTimeout = options.receiveTimeout;
    _dio.options.headers = options.headers;
    _dio.options.contentType = options.contentType;

    // 添加日志打印拦截器
    _dio.interceptors.add(LoggingInterceptor());
    // 刷新token
    _dio.interceptors.add(RefreshTokenInterceptor());
    // 数据转换拦截器
    _dio.interceptors.add(DataTransformInterceptor());
    // 缓存拦截器
    _dio.interceptors.add(CacheInterceptor(cachePolicy: MyCachePolicy.firstCache));
    // 添加错误处理拦截器
    _dio.interceptors.add(ErrorHandleInterceptor());
    // 弹窗
    _dio.interceptors.add(LoadingInterceptor(isShowLoading: true, showErrorLoading: true));

  }

// 工厂构造函数，返回单例实例
  factory NetworkService() {
    return _instance;
  }

  // 获取 Dio 实例
  Dio get dio => _dio;

  // 示例的 GET 请求方法
  Future<Response> get(MyRequestOptions options) async {
    try {
      CancelToken cancelToken = _getCancelToken(options: options);
      final _response = await _dio.get(
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
      String cancelTokenKey = _getCancelTokenKey(options: options);
      _cancelTokens.remove(cancelTokenKey);
    }
  }

  // 示例的 POST 请求方法
  Future<Response> post(MyRequestOptions options) async {
    try {
      CancelToken cancelToken = _getCancelToken(options: options);
      final _response = await _dio.post(
        options.urlPath,
        data: options.params,
        cancelToken: cancelToken,
      );
      return _response;
    } on DioError catch (e) {
      print('Error occurred during POST request: ${e.message}');
      rethrow;
    } finally {
      String cancelTokenKey = _getCancelTokenKey(options: options);
      _cancelTokens.remove(cancelTokenKey);
    }
  }

  // 取消某个请求
  void cancelRequest(String cancelTokenKey) {
    final cancelToken = _cancelTokens[cancelTokenKey];
    if (cancelToken != null) {
      cancelToken.cancel('Request cancelled by user');
      _cancelTokens.remove(cancelTokenKey);
    }
  }

  // 取消全部请求
  void cancelAllRequests() {
    _cancelTokens.forEach((key, cancelToken) {
      cancelToken.cancel('All requests cancelled by user');
    });
    _cancelTokens.clear();
  }

  /// 获取CancelToken
  CancelToken _getCancelToken({required MyRequestOptions options}) {
    String cancelTokenKey = _getCancelTokenKey(options: options);
    CancelToken? cancelToken;
    cancelToken = _cancelTokens[cancelTokenKey];
    if (cancelToken == null) {
      cancelToken = CancelToken();
      _cancelTokens[cancelTokenKey] = cancelToken;
    }
    return cancelToken;
  }

  /// 获取CancelTokenKey
  String _getCancelTokenKey({required MyRequestOptions options}) {
    String url = options.baseUrl + options.urlPath;
    String paramString = options.params.toString();
    String cancelTokenKey = (url + paramString).md5Hash();
    return cancelTokenKey;
  }
}
