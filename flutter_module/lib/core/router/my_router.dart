import 'package:flutter/widgets.dart';
import 'package:flutter_module/core/log/log.dart';
import 'package:flutter_module/core/router/router_url.dart';
import 'package:go_router/go_router.dart';

enum MyRouterEnum { push, go }

class MyRouter {
  /// 功能描述 路由跳转
  static Future<T?> router<T extends Object?>(
      {required RouterURL routerURL,
      required BuildContext context,
      Map<String, dynamic>? param,
      MyRouterEnum routerType = MyRouterEnum.push}) {
    final name = routerURL.name;
    Map<String, dynamic> queryParameters = param ?? Map<String, dynamic>();
    if (routerType == MyRouterEnum.push) {
      return context.pushNamed(name, queryParameters: queryParameters);
    } else {
      context.goNamed(name, queryParameters: queryParameters);
      return Future.value();
    }
  }

  /// pop 返回
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    if (context.canPop()) {
      context.pop(result);
    } else {
      assert(false, '不能pop');
    }
  }

  /// 返回到指定界面
  static void popUntil({required BuildContext context, required RouterURL routerURL}) {
    try {
      final name = routerURL.name;
      Navigator.popUntil(context, ModalRoute.withName(name));
    } catch (e) {
      Log.error("返回到指定界面错误：${e.toString()}");
    }

  }

  /// 到根
  static void backToRoot({required BuildContext context}) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }


}
