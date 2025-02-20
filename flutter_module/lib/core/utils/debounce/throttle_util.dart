/**
 * @author: jiangjunhui
 * @date: 2025/2/20
 */
import 'package:flutter/material.dart';

typedef ThrottleFunction = void Function();
/*
节流在按钮点击中的应用
class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late final VoidCallback throttledOnPress;

  @override
  void initState() {
    super.initState();
    throttledOnPress = throttle(() {
      print('Button pressed');
    }, Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: throttledOnPress,
      child: Text('Throttled Button'),
    );
  }
}
* */
ThrottleFunction throttle(
  void Function() fn, [
  Duration duration = const Duration(milliseconds: 500),
]) {
  DateTime? lastExecution;
  return () {
    final now = DateTime.now();
    if (lastExecution == null || now.difference(lastExecution!) >= duration) {
      fn();
      lastExecution = now;
    }
  };
}

// 支持参数的泛型版本
typedef ThrottleFunctionWithParam<T> = void Function(T arg);

ThrottleFunctionWithParam<T> throttleParam<T>(
  void Function(T) fn, [
  Duration duration = const Duration(milliseconds: 500),
]) {
  DateTime? lastExecution;
  return (T arg) {
    final now = DateTime.now();
    if (lastExecution == null || now.difference(lastExecution!) >= duration) {
      fn(arg);
      lastExecution = now;
    }
  };
}
