/**
 * @author: jiangjunhui
 * @date: 2025/4/15
 */

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_module/core/log/log.dart';

/// 统一异常处理中枢
class BoostErrorHandler {
  static void handleRouteError(
      String path,
      dynamic params,
      dynamic error,
      StackTrace stack,
      ) {
    Log.error('RouteError: $path', error, stack);
  }

  static void handleBridgeError(
      String method,
      dynamic params,
      dynamic error,
      StackTrace stack,
      ) {
    Log.error('BridgeError: $method', error, stack);

  }
}
