/**
 * @author: jiangjunhui
 * @date: 2024/12/26
 */
import 'package:flutter/services.dart';

// 声明 MethodChannel
const platform = MethodChannel('flutter_postData');
// 定义具体的函数名
const String Router_Page_Method = "Router_Page_Method";

class APPChannelModel {
  String code;
  String message;
  Map<String, Object> data;

  APPChannelModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory APPChannelModel.fromJson(Map<String, dynamic> json) =>
      APPChannelModel(
        code: json["code"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toString(),
      };
}

class MyAppChannelUtil {
  /// 仅仅处理外界传入的函数名
  /// 监听原生向flutter发送消息
  static void setMethodCallHandler(
      String method, Future<dynamic> Function(APPChannelModel model)? handler) {
    platform.setMethodCallHandler((callback) async {
      // 仅仅处理外界传入的函数名
      if ((handler != null)) {
        Map<String, dynamic> result = callback.arguments as Map<String, dynamic>;
        APPChannelModel _model = APPChannelModel.fromJson(result);
        handler(_model);
      }
    });
  }

  // 原生跟flutter交互
  static Future<APPChannelModel?> invokeMethod(
      {required String method, required APPChannelModel model}) async {
    Map<String, dynamic> _data = {
      "code": "",
      "message": "",
      "data": {"": ""}
    };
    Map<String, dynamic> result = await platform.invokeMapMethod(method, {
          "code": model.code,
          "message": model.message,
          "data": model.data
        }) ??
        _data;
    APPChannelModel _model = APPChannelModel.fromJson(result);
    return Future.value(_model);
  }
}






















