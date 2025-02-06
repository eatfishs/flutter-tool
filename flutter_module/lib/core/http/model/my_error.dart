import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:dio/dio.dart';
import '../core/my_request_options.dart';
import 'my_response_model.dart';

/// FileName my_error.dart
///
/// @Author jiangjunhui
/// @Date 2023/6/25 21:25
///
/// @Description TODO

Map<String, String> _errorCodeMessage = {
  "400": "状态码：400 请求参数错误",
  "401": "状态码：401 身份验证错误",
  "403": "状态码：403 服务器拒绝请求",
  "404": "状态码：404 找不到服务器地址",
  "407": "状态码：407 需要代理授权",
  "408": "状态码：408 请求超时",
  "500": "状态码：500 服务器内部错误",
  "501": "状态码：501 尚未实施",
  "502": "状态码：502 错误网关",
  "503": "状态码：503 服务不可用",
  "504": "状态码：504 网关超时",
  "505": "HTTP 版本不受支持",
  "-1000": "解析不到数据"
};

class MyDioExceptionModel {
  /// 响应对应的请求配置。
  MyResopnseModel? resopnse;

  /// 异常错误
  DioError? _error;

  MyDioExceptionModel({MyResopnseModel? resopnse, DioError? e}) {
    resopnse = resopnse;
    _error = e;
  }

}
