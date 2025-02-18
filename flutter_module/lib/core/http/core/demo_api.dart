/**
 * @author: jiangjunhui
 * @date: 2025/1/24
 */
import 'package:flutter/material.dart';

/*
import '../../../app/pages/test/model/login_model.dart';
import '../../../app/pages/test/model/userinfo_model.dart';
import '../model/my_base_model.dart';
import 'my_request_options.dart';
import 'network_service.dart';

main() {
  NetworkService networkService = NetworkService();

  void _get() async {
    MyRequestOptions options = MyRequestOptions(url: "/userInfo");
    try {
      MyBaseModel<UserInfoModel> result = await networkService.get(
          options: options,
          fromJsonT: (json) =>
              UserInfoModel.fromJson(json as Map<String, dynamic>));
      if (result.isSucess()) {
        print('User name: ${result.data?.name}');
        print('User age: ${result.data?.age}');
      } else {
        print('请求错误message: ${result.message}===code:${result.code}');
      }
    } catch (e) {
      print('NetworkServicePageState Error: $e');
    }
  }

  void _post() async {
    MyRequestOptions options = MyRequestOptions(url: "/login");
    try {
      MyBaseModel<LoginModel> result = await networkService.post(
          options: options,
          fromJsonT: (json) =>
              LoginModel.fromJson(json as Map<String, dynamic>));
      if (result.isSucess()) {
        print('User userId: ${result.data?.userId}');
        print('User token: ${result.data?.token}');
      } else {
        print('NetworkServicePageState Request failed: ${result.message}');
      }
    } catch (e) {
      print('NetworkServicePageState Error: $e');
    }
  }
}







* */
 