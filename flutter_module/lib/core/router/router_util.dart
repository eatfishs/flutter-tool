import 'package:flutter/widgets.dart';
import 'package:flutter_module/core/router/router_url.dart';
import 'package:go_router/go_router.dart';

enum MyRouterEnum { push, go }

class MyRouter {
  /// 功能描述 路由跳转
  static Future<T?> router<T extends Object?>(
      {required RouterURL routerURL,
      Map<String, dynamic>? param,
      required BuildContext context,
      MyRouterEnum routerType = MyRouterEnum.push}) {
    final name = routerURL.name;
    Map<String, dynamic> queryParameters = param ?? Map<String, dynamic>();
    return context.pushNamed(name, queryParameters: queryParameters);
  }





}
