
import '../core/my_request_options.dart';
import 'my_base_list_model.dart';
import 'my_base_model.dart';

/// FileName my_response.dart
///
/// @Author jiangjunhui
/// @Date 2023/6/8 14:01
///
/// @Description TODO

class MyResopnseModel {
  /// 响应对应的请求配置。
  MyRequestOptions requestOptions;

  /// 响应的 HTTP 状态码。
  int? statusCode;

  /// 响应对应状态码的详情信息。
  String? statusMessage;

  /// 响应头
  Map<String, dynamic> responseHeaders = Map<String, dynamic>();

  /// 原始数据值
  String data;


  MyResopnseModel(
      this.requestOptions, this.statusCode, this.statusMessage, this.data);
}





















