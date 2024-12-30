/**
 * @author: jiangjunhui
 * @date: 2024/12/25
 */
import 'package:flutter/material.dart';
import 'package:flutter_module/app/pageRouter/pages_url_constant.dart';
import 'package:flutter_module/app/pageRouter/router_page.dart';
import 'package:go_router/go_router.dart';

import '../core/router/router_url.dart';
import '../core/router/router_util.dart';


class RootPages extends StatelessWidget {
  const RootPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter"),),
      body: Container(
          child: BaseWidget()
      ),
    );
  }
}


class BaseWidget extends StatefulWidget {
  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  List<RouterURL> _pathList = [
    PagesURL.colorUrl,
    PagesURL.daterUrl,
    PagesURL.dbUrl,
    PagesURL.testRouterUrl
  ];

  List<String> getData() {
    List<String> _data = [
      "颜色",
      "日期",
      "数据库",
      "测试路由"
    ];
    return _data;
  }
  Widget _itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        MyRouter.router(
            routerURL: _pathList[index], context: context);
      },
      child: Container(
        child: Card(
          color: Colors.white,
          child: Center(
            child: Text(getData()[index],
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemExtent: 50.0, //强制高度为50.0
          itemCount: getData().length,
          itemBuilder: _itemBuilder),
    );
  }
}
