/// @author: jiangjunhui
/// @date: 2025/2/20
library;
import 'dart:async';


typedef DebounceFunction = void Function();
/*
防抖在搜索框中的应用
TextField(
  onChanged: debounceParam<String>((value) {
    print('Searching for $value');
  }, Duration(seconds: 1)),
);
* */
DebounceFunction debounce(
  void Function() fn, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  Timer? timer;
  return () {
    timer?.cancel();
    timer = Timer(delay, fn);
  };
}

// 支持参数的泛型版本
typedef DebounceFunctionWithParam<T> = void Function(T arg);

DebounceFunctionWithParam<T> debounceParam<T>(
  void Function(T) fn, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  Timer? timer;
  return (T arg) {
    timer?.cancel();
    timer = Timer(delay, () => fn(arg));
  };
}
