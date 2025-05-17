/// @author: jiangjunhui
/// @date: 2025/4/15
library;
import 'package:flutter/widgets.dart';


class GlobalContext {
  static BuildContext? _context;

  static set context(BuildContext context) {
    _context = context;
  }

  static BuildContext? get buildContext => _context;
}







