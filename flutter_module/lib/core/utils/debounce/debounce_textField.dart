/// @author: jiangjunhui
/// @date: 2025/2/20
library;
import 'dart:async';

import 'package:flutter/material.dart';
/*
DebounceTextField(
  delay: Duration(seconds: 1),
  onDebounced: (value) {
    print("防抖后的搜索值: $value");
  },
  decoration: InputDecoration(hintText: "输入关键词搜索"),
);
* */
class DebounceTextField extends StatefulWidget {
  final Duration delay;
  final ValueChanged<String> onDebounced;
  final TextEditingController? controller;
  final InputDecoration? decoration;

  const DebounceTextField({
    super.key,
    this.delay = const Duration(milliseconds: 500),
    required this.onDebounced,
    this.controller,
    this.decoration,
  });

  @override
  _DebounceTextFieldState createState() => _DebounceTextFieldState();
}

class _DebounceTextFieldState extends State<DebounceTextField> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: widget.decoration,
      onChanged: (value) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(widget.delay, () => widget.onDebounced(value));
      },
    );
  }
}
