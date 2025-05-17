/// @author: jiangjunhui
/// @date: 2025/2/20
library;
import 'package:flutter/material.dart';
/*
ThrottleButton(
  duration: Duration(seconds: 1),
  onPressed: () {
    print("节流后的按钮点击");
  },
  child: Text("提交"),
);
* */
class ThrottleButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Duration duration;
  final Widget child;

  const ThrottleButton({
    super.key,
    required this.onPressed,
    this.duration = const Duration(seconds: 1),
    required this.child,
  });

  @override
  _ThrottleButtonState createState() => _ThrottleButtonState();
}

class _ThrottleButtonState extends State<ThrottleButton> {
  DateTime? _lastPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final now = DateTime.now();
        if (_lastPressed == null ||
            now.difference(_lastPressed!) >= widget.duration) {
          _lastPressed = now;
          widget.onPressed();
        }
      },
      child: widget.child,
    );
  }
}
