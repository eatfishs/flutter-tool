import 'package:dio/dio.dart';

/// FileName my_request.dart
///
/// @Author jiangjunhui
/// @Date 2023/6/8 14:00
///
/// @Description TODO

/// 请求方式
enum MyRequestMethod { get, post }

class MyRequestOptions {
  /// 基础url
  String baseUrl = "https://www.google.com/";

  /// HTTP 请求头。
  Map<String, dynamic> headers = Map<String, dynamic>();

  /// 连接服务器超时时间.
  Duration connectTimeout = Duration(seconds: 10);

  /// 接收数据的超时设置。
  ///
  /// 这里的超时对应的时间是：
  ///  - 在建立连接和第一次收到响应数据事件之前的超时。
  ///  - 每个数据事件传输的间隔时间，而不是接收的总持续时间。
  ///
  /// 超时时会抛出类型为 [DioExceptionType.receiveTimeout] 的
  /// [DioException]。
  ///
  /// `null` 或 `Duration.zero` 即不设置超时。
  Duration receiveTimeout = Duration(seconds: 10);

  /// 编码类型
  String contentType = "";

  /// 请求方式
  MyRequestMethod method = MyRequestMethod.get;

  /// 请求路径
  String urlPath = "";

  /// 参数
  Map<String, dynamic> params = Map<String, dynamic>();

  MyRequestOptions() {}

  String getMethod() {
    if (method == MyRequestMethod.get) {
      return "get";
    }
    return "post";
  }
}
