/**
 * @author: jiangjunhui
 * @date: 2024/12/30
 */
import 'package:flutter/material.dart';

import '../../../core/router/my_router.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import '../../pageRouter/router_path.dart';

class kkTest1RouterPage extends StatefulWidget {
  final Map<String, dynamic>? queryParam;

  const kkTest1RouterPage({Key? key, required this.queryParam})
      : super(key: key);

  @override
  State<kkTest1RouterPage> createState() => _kkTest1RouterPageState();
}

class _kkTest1RouterPageState extends State<kkTest1RouterPage> {
  String _queryParam = "";
  void getParam() {
    String text = widget.queryParam.toString();
    this.setState(() {
      _queryParam =
      "上级界面传入参数：$text";
    });
  }

  void _push() {
    MyRouter.router(routerURL: PagesURL.testRouterUrl4, context: context);
  }

  @override
  void initState() {
    super.initState();
    print("===========================");
    getParam();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: '第一个页面',
        actions: [],
        onBackPressed: () {
          MyRouter.pop(context,"我是第一个页面返回的字符串");
        },
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: Text('$_queryParam'),
          ),
          SizedBox(height: 50),
          Container(
              height: 50,
              width: 200,
              color: Colors.red,
              child:
              TextButton(onPressed: _push, child: Text("pusht动画跳转"))),
        ],
      )
    );
  }
}
