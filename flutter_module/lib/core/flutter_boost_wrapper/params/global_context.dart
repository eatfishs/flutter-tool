/**
 * @author: jiangjunhui
 * @date: 2025/4/15
 */
import 'package:flutter/widgets.dart';

class GlobalContext {
  static BuildContext? _context;

  static void setContext(BuildContext context) {
    _context = context;
  }

  static BuildContext? get context => _context;
}











