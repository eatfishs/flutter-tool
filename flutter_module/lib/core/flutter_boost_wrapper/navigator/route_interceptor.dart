import '../core/route_mapper.dart';

enum RouteDecision {
  continue_router,
  stop_router
}

class RouteInterceptorManager {
  static Future<RouteDecision> process(String path, dynamic params) async {
    // 实现路由拦截逻辑
    return RouteDecision.continue_router;
  }
}