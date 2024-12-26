/**
 * @author: jiangjunhui
 * @date: 2024/12/25
 */
import 'package:flutter/material.dart';

import '../../core/router/router_url.dart';

// 测试工具类
const String COLOR_PAGE_URL = "ColorPage";
const String DATE_PAGE_URL = "datePage";
const String DB_PAGE_URL = "DBPage";


const String ROOT_PAGE_URL = "rootPage";
const String LOGIN_PAGE_URL = "loginPage";




class PagesURL {
  ///
  static RouterURL rootrUrl = const RouterURL(name: ROOT_PAGE_URL, path: ROOT_PAGE_URL);
  static RouterURL loginUrl = const RouterURL(name: LOGIN_PAGE_URL, path: LOGIN_PAGE_URL);
  /// 颜色
  static RouterURL colorUrl = const RouterURL(name: COLOR_PAGE_URL, path: COLOR_PAGE_URL);
  /// 日期
  static RouterURL daterUrl = const RouterURL(name: DATE_PAGE_URL, path: DATE_PAGE_URL);
  /// 数据库
  static RouterURL dbUrl = const RouterURL(name: DB_PAGE_URL, path: DB_PAGE_URL);


}

















