/// @author: jiangjunhui
/// @date: 2024/12/30
library;
import 'package:flutter/material.dart';
import 'package:flutter_module/core/router/my_router.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import '../../global/pageRouter/router_path.dart';

class kkTestRouterPage extends StatefulWidget {
  const kkTestRouterPage({super.key});

  @override
  State<kkTestRouterPage> createState() => _kkTestRouterPageState();
}

class _kkTestRouterPageState extends State<kkTestRouterPage> {
  String _msg = "";


  /// push 传值
  void _pushToValue() {
    MyRouter.router(
        routerURL: PagesURL.testRouterUrl1,
        context: context,
        param: {"one": "1", "two": "2"}).then((value) => {
      setState(() {
        if (value is String) {
          _msg = value;
        }
      })
    });

  }
  /// go 传值
  void _goToValue() {
    MyRouter.router(
        routerURL: PagesURL.testRouterUrl1,
        context: context,
        routerType:MyRouterEnum.go,
        param: {"go——one": "1", "go——two": "2"});
  }
  void _pushCustomTransitionPageToValue() {
    MyRouter.router(
        routerURL: PagesURL.testRouterUrl2,
        context: context,
        param: {"Custom——one": "1", "Custom——two": "2"});
  }


  void _redirectUrl() {
    MyRouter.router(
        routerURL: PagesURL.testRouterUrl_redirect,
        context: context,
        param: {"one": "1", "two": "2"});
  }

  @override
  Widget build(BuildContext context) {
    final routeParams = GoRouter.of(context).routeInformationProvider.value;
    print('路由信息：$routeParams');


    return Scaffold(
      appBar: CustomAppBar(
        title: '测试路由',
        actions: const [],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child:
                    TextButton(onPressed: _pushToValue, child: const Text("pusht跳转"))),
            const SizedBox(height: 50),
            Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                color: Colors.red,
                child:Text(_msg)),
            const SizedBox(height: 50),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child:
                TextButton(onPressed: _goToValue, child: const Text("go跳转"))),
            const SizedBox(height: 50),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child:
                TextButton(onPressed: _pushCustomTransitionPageToValue, child: const Text("pusht动画跳转"))),
            const SizedBox(height: 50),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child:
                TextButton(onPressed: _redirectUrl, child: const Text("测试重定向"))),



          ],
        ),
      ),
    );
  }
}
