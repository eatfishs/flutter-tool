import 'package:flutter/services.dart';
import 'dart:convert';
import '../../../core/utils/string_utils.dart';

// 声明 MethodChannel
const platform = MethodChannel('flutter_postData');
// 定义具体的函数名
const String Router_Page_Method = "Router_Page_Method";

class APPChannelModel {
  String code;
  String message;
  Map<dynamic, dynamic> data;

  APPChannelModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory APPChannelModel.fromJson(Map<String, dynamic> json) {
    return APPChannelModel(
      code: json["code"]?? "",
      message: json["message"]?? "",
      data: json["data"]?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data,
  };
}

class MyAppMethodChannelHandler {
  static Map<String, dynamic> _data = {
    "code": "-1",
    "message": "解析失败",
    "data": {}
  };

  /// 将 Map<Object?, Object?> 转换为 Map<String, dynamic>
  static Map<String, dynamic> convertToMapStringDynamic(
      Map<Object?, Object?> targetMap) {
    return Map.fromEntries(
      targetMap.entries.where((entry) => entry.key is String).map(
            (entry) => MapEntry(entry.key as String, entry.value?? ""),
      ),
    );
  }

  /// 解析参数为 Map<String, dynamic>
  static Map<String, dynamic> parseArguments(dynamic arguments) {
    Map<Object?, Object?> targetMap = {};
    try {
      if (arguments is String) {
        targetMap = jsonDecode(arguments) as Map<Object?, Object?>;
      } else if (arguments is Map<Object?, Object?>) {
        targetMap = arguments;
      }
    } on PlatformException catch (e) {
      print("类型解析失败:${e.message}");
    }
    return convertToMapStringDynamic(targetMap);
  }

  /// 函数名如果为空，返回所有函数
  /// 监听原生向flutter发送消息
  static void setMethodCallHandler(String? method,
      Future<dynamic> Function(APPChannelModel model, String method)? handler) {
    platform.setMethodCallHandler((callback) async {
      // 仅仅处理外界传入的函数名
      if (handler != null) {
        if ((JHStingUtils.isEmpty(method) == true) ||
            (method == callback.method)) {
          Map<String, dynamic> resultMap =
          parseArguments(callback.arguments);
          try {
            APPChannelModel _model = APPChannelModel.fromJson(resultMap);
            await handler(_model, callback.method);
          } catch (e) {
            print("json转model失败:${e}");
          }
        }
      }
    });
  }

  // 调用原生方法的封装函数
  static Future<APPChannelModel> callNativeMethod(
      {required String method, required APPChannelModel model}) async {
    try {
      dynamic arguments = await platform.invokeMapMethod(method, model.toJson());
      Map<String, dynamic> resultMap = parseArguments(arguments);
      // 生成返回结果model
      APPChannelModel _model = APPChannelModel.fromJson(resultMap);
      return _model;
    } on PlatformException catch (e) {
      // 处理平台异常
      print("Failed to call native method '$method': ${e.message}");
      rethrow;
    }
  }
}