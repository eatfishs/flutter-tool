import 'dart:async';
import '../core/boost_bridge.dart';
import '../params/boost_params.dart';
import '../core/route_mapper.dart';

class BoostNavigator {
  static final BoostNavigator _instance = BoostNavigator._();

  BoostNavigator._();

  static BoostNavigator get instance => _instance;

  Future<T?> push<T>(String routeName, {dynamic params, bool withContainer = true, bool opaque = true, required arguments}) async {
    final serializedParams = BoostParams.serialize(params);
    final routeFactory = RouteMapper.instance.getRouteFactory(routeName);
    if (routeFactory != null) {
      // 处理Flutter页面跳转
      return await BoostNavigator.instance.push(
        routeName,
        withContainer: withContainer,
        opaque: opaque,
        arguments: serializedParams,
      );
    } else {
      // 处理原生页面跳转
      return await BoostBridge.instance.callNativeFunction('push', {
        'routeName': routeName,
        'params': serializedParams,
      });
    }
  }

  Future<T?> pop<T>({dynamic result, String? uniqueId}) async {
    final serializedResult = BoostParams.serialize(result);
    return await BoostNavigator.instance.pop(
      uniqueId: uniqueId,
      result: serializedResult,
    );
  }


}