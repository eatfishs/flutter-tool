import 'package:dio/dio.dart';
import 'my_response_model.dart';

/// FileName my_error.dart
///
/// @Author jiangjunhui
/// @Date 2023/6/25 21:25
///
/// @Description TODO



class MyDioErrorModel {
  /// 响应对应的请求配置。
  MyResopnseModel? resopnse;

  /// 异常错误
  DioError? _error;

  MyDioErrorModel({MyResopnseModel? resopnse, DioError? e}) {
    resopnse = resopnse;
    _error = e;
  }

}
