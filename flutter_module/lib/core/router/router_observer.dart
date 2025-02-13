/**
 * @author: jiangjunhui
 * @date: 2024/12/25
 */
import 'package:flutter/material.dart';

class RouterObserver extends NavigatorObserver {
  void log(value) => debugPrint('MyNavObserver:$value');

  /// 当一个新的路由被推送到导航栈时，此方法会被调用。
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('新的路由被推送到导航栈: ${route.toString()}, previousRoute= ${previousRoute?.toString()}');
  }

  /// 当一个路由从导航栈中弹出时，此方法会被调用。route 参数表示被弹出的路由，previousRoute 参数
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('路由从导航栈中弹出: ${route.toString()}, previousRoute= ${previousRoute?.toString()}');
  }

  /// 当一个路由从导航栈中被移除时，此方法会被调用。移除路由和弹出路由不同，移除操作可以移除导航栈中任意位置的路由，而弹出操作只能移除栈顶的路由。
  /// route 参数表示被移除的路由，previousRoute 参数表示在该路由移除后，其下一个路由（如果存在的话）。
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('didRemove: ${route.toString()}, previousRoute= ${previousRoute?.toString()}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('didReplace: new= ${newRoute?.toString()}, old= ${oldRoute?.toString()}');
  }

  /// 当用户开始进行一个导航手势（如在 iOS 上从屏幕边缘向左滑动返回上一页）时，此方法会被调用。
  /// route 参数表示当前正在操作的路由，previousRoute 参数表示在手势操作后可能会显示的前一个路由（如果存在的话）。
  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('didStartUserGesture: ${route.toString()}, '
        'previousRoute= ${previousRoute?.toString()}');
  }

  /// 用户结束导航手势时，此方法会被调用。无论手势是否成功完成导航操作，只要手势结束，就会触发这个方法。
  @override
  void didStopUserGesture() {
    log('didStopUserGesture');
  }
}
