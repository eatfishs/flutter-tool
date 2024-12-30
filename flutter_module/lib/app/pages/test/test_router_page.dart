/**
 * @author: jiangjunhui
 * @date: 2024/12/30
 */
import 'package:flutter/material.dart';
import 'package:flutter_module/core/router/router_util.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import '../../pageRouter/pages_url_constant.dart';

class kkTestRouterPage extends StatefulWidget {
  const kkTestRouterPage({super.key});

  @override
  State<kkTestRouterPage> createState() => _kkTestRouterPageState();
}

class _kkTestRouterPageState extends State<kkTestRouterPage> {

  /// push 传值
  void _pushToValue() {
    MyRouter.router(
        routerURL: PagesURL.testRouterUrl1, context: context, param: {"one":"1","two":"2"});
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(
      title: '测试路由',
      actions: [
      ],
      onBackPressed: () {
        // Handle back button press, if needed
        Navigator.pop(context);
      },
    ),
    body: Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(height: 50,
              width: 200,
              color: Colors.red,
              child: TextButton(
                  onPressed: _pushToValue, child: Text("pusht跳转")))
        ],
      ),
    ),
  );
}}











