/**
 * @author: jiangjunhui
 * @date: 2024/12/26
 */
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../core/utils/string_utils.dart';

// 声明 MethodChannel
const platform = MethodChannel('flutter_postData');
// 定义具体的函数名
const String Router_Page_Method = "Router_Page_Method";

class APPChannelModel {
  String code;
  String message;
  Map<dynamic?, dynamic?> data;

  APPChannelModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory APPChannelModel.fromJson(Map<String, dynamic> json) {
    return APPChannelModel(
      code: json["code"],
      message: json["message"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() =>
      {"code": code, "message": message, "data": data.toString()};
}

class MyAppMethodChannelHandler {
  static Map<String, dynamic> _data = {
    "code": "-1",
    "message": "解析失败",
    "data": {"": ""}
  };

  /// 函数名如果为空，返回所有函数
  /// 监听原生向flutter发送消息
  static void setMethodCallHandler(String? method,
      Future<dynamic> Function(APPChannelModel model, String method)? handler) {
    platform.setMethodCallHandler((callback) async {
      // 仅仅处理外界传入的函数名
      if (handler != null) {
        if ((JHStingUtils.isEmpty(method) == true) ||
            (method == callback.method)) {
          dynamic arguments = callback.arguments;
          Map<Object?, Object?> targetMap = {};
          try {
            if (arguments is String) {
              targetMap = jsonDecode(arguments) as Map<Object?, Object?>;
            } else if (arguments is Map<Object?, Object?>) {
              targetMap = arguments;
            }
          } on PlatformException catch (e) {
            print("监听原生向flutter发送消息类型解析失败:${e.message}");
          }
          Map<String, dynamic> resultMap = MyAppMethodChannelHandler._data;

          resultMap = Map.fromEntries(
            targetMap.entries.where((entry) => entry.key is String).map(
                (entry) => MapEntry(entry.key as String, entry.value ?? "")),
          );
          try {
            APPChannelModel _model = APPChannelModel.fromJson(resultMap);
            handler(_model, callback.method);
          } catch (e) {
            print("json转model失败:${e}");
          }
        }
      }
    });
  }

  // 调用原生方法的封装函数
  static Future<APPChannelModel?> callNativeMethod(
      {required String method, required APPChannelModel model}) async {
    try {
      // 调用原生方法，等待结果
      Map<String, dynamic> result = await platform.invokeMapMethod(method, {
            "code": model.code,
            "message": model.message,
            "data": model.data
          }) ??
          _data;
      APPChannelModel _model = APPChannelModel.fromJson(result);
      return Future.value(_model);
    } on PlatformException catch (e) {
      // 处理平台异常
      print("Failed to call native method '$method': ${e.message}");
      rethrow;
    }
  }
}
