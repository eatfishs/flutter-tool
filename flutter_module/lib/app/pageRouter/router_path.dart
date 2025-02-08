/**
 * @author: jiangjunhui
 * @date: 2024/12/25
 */

import '../../core/router/router_url.dart';

// 测试工具类
const String COLOR_PAGE_URL = "ColorPage";
const String DATE_PAGE_URL = "datePage";
const String DB_PAGE_URL = "DBPage";
const String TestRouterPage = "TestRouterPage";
const String TestRouterPage1 = "TestRouterPage_one";
const String TestRouterPage_redirect = "TestRouterPage_one_redirect";
const String TestRouterPage2 = "TestRouterPage_two";
const String TestRouterPage4 = "TestRouterPage_Four";
const String Cache_Image_Page_URL = "CacheImagePage_URL";
const String Flutter_Call_Navive_Page_URL = "Flutter_Call_Navive_Page_URL";
const String Network_Service_Page_URL = "Network_Service_Page_URL";
const String Custom_Refresh_Widget_URL = "Custom_Refresh_Widget_URL";
const String ROOT_PAGE_URL = "rootPage";
const String LOGIN_PAGE_URL = "loginPage";
const String EVENT_BUS_URL = "EVENT_BUS_URL";
const String Toast_Util_URL = "Toast_Util_URL";



class PagesURL {
  ///
  static RouterURL rootrUrl = const RouterURL(name: ROOT_PAGE_URL, path: ROOT_PAGE_URL);
  static RouterURL loginUrl = const RouterURL(name: LOGIN_PAGE_URL, path: LOGIN_PAGE_URL);
  /// 测试路由
  static RouterURL testRouterUrl = const RouterURL(name: TestRouterPage, path: TestRouterPage);
  static RouterURL testRouterUrl1 = const RouterURL(name: TestRouterPage1, path: TestRouterPage1);
  static RouterURL testRouterUrl2 = const RouterURL(name: TestRouterPage2, path: TestRouterPage2);
  static RouterURL testRouterUrl4= const RouterURL(name: TestRouterPage4, path: TestRouterPage4);
  static RouterURL testRouterUrl_redirect = const RouterURL(name: TestRouterPage_redirect, path: TestRouterPage_redirect);
  /// 颜色
  static RouterURL colorUrl = const RouterURL(name: COLOR_PAGE_URL, path: COLOR_PAGE_URL);
  /// 日期
  static RouterURL daterUrl = const RouterURL(name: DATE_PAGE_URL, path: DATE_PAGE_URL);
  /// 数据库
  static RouterURL dbUrl = const RouterURL(name: DB_PAGE_URL, path: DB_PAGE_URL);
  /// 图片缓存
  static RouterURL cacheImageUrl = const RouterURL(name: Cache_Image_Page_URL, path: Cache_Image_Page_URL);
  /// flutter和原生的交互
  static RouterURL flutterCallNaviveURL = const RouterURL(name: Flutter_Call_Navive_Page_URL, path: Flutter_Call_Navive_Page_URL);
  /// 网络请求
  static RouterURL NetworkServiceURL = const RouterURL(name: Network_Service_Page_URL, path: Network_Service_Page_URL);
  /// 刷新组件
  static RouterURL CustomRefreshWidgetURL = const RouterURL(name: Custom_Refresh_Widget_URL, path: Custom_Refresh_Widget_URL);
  /// EventBus
  static RouterURL EventBusURL = const RouterURL(name: EVENT_BUS_URL, path: EVENT_BUS_URL);
 /// 弹窗
  static RouterURL ToastUtilURL = const RouterURL(name: Toast_Util_URL, path: Toast_Util_URL);

}

















