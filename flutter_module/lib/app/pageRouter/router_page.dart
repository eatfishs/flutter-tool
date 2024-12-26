/**
 * @author: jiangjunhui
 * @date: 2024/12/25
 */
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_module/app/pageRouter/pages_constant.dart';
import 'package:flutter_module/app/pages/login/login_page.dart';
import 'package:flutter_module/app/pages/test/color_page.dart';
import 'package:flutter_module/app/pages/test/date_page.dart';
import 'package:flutter_module/app/pages/test/db_page.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/Unknown_widget.dart';
import '../root_pages.dart';

class RouterPages {
  /// 首页
  static RouteBase homeRouter = GoRoute(
      name: PagesURL.rootrUrl.name,
      path: PagesURL.rootrUrl.path,
      pageBuilder: (_, GoRouterState state) => CustomTransitionPage(
          child: RootPages(),
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(opacity: animation, child: child)));

  ///
  static RouteBase ColorRouter = GoRoute(
      name: PagesURL.colorUrl.name,
      path: PagesURL.colorUrl.path,
      builder: (context, state) => ColorPage());

  static RouteBase dateRouter = GoRoute(
      name: PagesURL.daterUrl.name,
      path: PagesURL.daterUrl.path,
      builder: (context, state) => DatePage());

  static RouteBase dbRouter = GoRoute(
      name: PagesURL.dbUrl.name,
      path: PagesURL.dbUrl.path,
      builder: (context, state) => dbPage());

  /// 登录
  static RouteBase loginRouter = GoRoute(
      name: PagesURL.loginUrl.name,
      path: PagesURL.loginUrl.path,
      builder: (context, state) => LoginPage());
}

FutureOr<String?> redirectUrl(BuildContext context, GoRouterState state) {
  debugPrint('loginRedirect :${state.name}');
  final String userId = "";
  if (userId.isEmpty) {
    return state.namedLocation(PagesURL.loginUrl.name);
  }
  return null;
}

final router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, GoRouterState state) {
      return UnknownPage();
    },
    debugLogDiagnostics: true,
    observers: [
      RouteObserver()
    ],
    routes: [
      GoRoute(
          path: "/",
          name: "home",
          builder: (_, state) => RootPages(),
          routes: [
            RouterPages.homeRouter,
            RouterPages.loginRouter,

            RouterPages.ColorRouter,
            RouterPages.dateRouter,
            RouterPages.dbRouter
          ])

    ]);
