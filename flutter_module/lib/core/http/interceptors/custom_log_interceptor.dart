/**
 * @author: jiangjunhui
 * @date: 2025/1/22
 */
import 'package:dio/dio.dart';

import '../../utils/date_untils.dart';


class CustomLogInterceptor extends Interceptor {
  // 请求开始时间
  int _startTime = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 记录请求日志
    _logRequest(options);

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 记录响应日志
    _logResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    // 记录错误日志
    _logError(error);
    handler.next(error);
  }

  // 记录请求日志
  void _logRequest(RequestOptions options) {
    /// 当前时间戳
    int currentTime = MyDateTimeUtil.getTimeStamp();
    _startTime = currentTime;
    print('''

      请求时间：${currentTime}
      请求方式: ${options.method}
      请求URL: ${options.uri}
      请求Headers: ${options.headers}
    ''');
  }

  // 记录响应日志
  void _logResponse(Response response) {
    /// 当前时间戳
    int entTime = MyDateTimeUtil.getTimeStamp();

    print('''
 
      网络请求耗时：${entTime - _startTime} 毫秒
      响应状态码: ${response.statusCode}
      响应: ${response.data}
    ''');
  }

  // 记录错误日志
  void _logError(DioError error) {

    print('''
    
    网络请求错误:
      ${error.toString()}
    ''');
  }
}
