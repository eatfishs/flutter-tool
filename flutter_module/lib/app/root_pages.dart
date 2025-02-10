/**
 * @author: jiangjunhui
 * @date: 2024/12/25
 */
import 'package:flutter/material.dart';
import 'package:flutter_module/app/global/pageRouter/router_path.dart';
import '../core/router/router_url.dart';
import '../core/router/my_router.dart';



class RootPages extends StatefulWidget {
  const RootPages({super.key});
  @override
  State<RootPages> createState() => _RootPagesState();
}

class _RootPagesState extends State<RootPages> {

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
    PagesURL.cacheImageUrl,
    PagesURL.testRouterUrl,
    PagesURL.flutterCallNaviveURL,
    PagesURL.NetworkServiceURL,
    PagesURL.CustomRefreshWidgetURL,
    PagesURL.EventBusURL,
    PagesURL.ToastUtilURL
  ];

  List<String> getData() {
    List<String> _data = [
      "颜色",
      "日期",
      "数据库",
      "图片缓存",
      "测试路由",
      "flutter向原生传值",
      "网络请求",
      "刷新",
      "EventBus",
      "ToastUtil"
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
