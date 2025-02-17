/**
 * @author: jiangjunhui
 * @date: 2025/2/17
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_module/app/global/pageRouter/router_path.dart';
import 'package:go_router/go_router.dart';

class RouteGuard {
  static bool isLoggedIn = false;

  static FutureOr<String?> authGuard(
      BuildContext context,
      GoRouterState state,
      ) {
    debugPrint('loginRedirect :${state.name}');
    final String userId = "";
    if (userId.isEmpty) {
      return state.namedLocation(PagesURL.loginUrl.name);
    }
    return null;

  }
}


 
 
 
 
 
 
 
 
 
 