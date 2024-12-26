import 'package:flutter/widgets.dart';
import 'package:flutter_module/core/router/router_url.dart';
import 'package:go_router/go_router.dart';

enum MyRouterEnum { push, present }

class MyRouter {
  /// 功能描述 路由跳转
  static router(
      {required RouterURL routerURL,
      Map<String, dynamic>? param,
      required BuildContext context,
      MyRouterEnum status = MyRouterEnum.push}) {
    final name = routerURL.name;
    Map<String, dynamic> queryParameters = param ?? Map<String, dynamic>();
    if (status == MyRouterEnum.push) {
      context.pushNamed(name, queryParameters: queryParameters);
    } else if (status == MyRouterEnum.present) {
      context.goNamed(name, queryParameters: queryParameters);
    }
  }
}
