/**
 * @author: jiangjunhui
 * @date: 2025/1/23
 */
import 'package:flutter/material.dart';
import '../../../core/http/core/my_request_options.dart';
import '../../../core/http/core/network_service.dart';
import '../../../core/http/model/my_base_model.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import 'model/login_model.dart';
import 'model/userinfo_model.dart';

class NetworkServicePage extends StatefulWidget {
  const NetworkServicePage({super.key});

  @override
  State<NetworkServicePage> createState() => _NetworkServicePageState();
}

class _NetworkServicePageState extends State<NetworkServicePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '测试网络请求',
        actions: [],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child: TextButton(onPressed: _get, child: Text("get请求"))),
            SizedBox(height: 30),
            SizedBox(height: 50),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child: TextButton(onPressed: _post, child: Text("post请求"))),
          ],
        ),
      ),
    );
  }
}
