/// @author: jiangjunhui
/// @date: 2025/3/5
library;

import 'package:rxdart/rxdart.dart';

class RxStream<T> {
  final BehaviorSubject<T> _subject = BehaviorSubject<T>();

  Stream<T> get stream => _subject.stream;

  // 添加数据
  void add(T value) => _subject.sink.add(value);

  // 链式操作符示例：防抖 + 过滤空值
  Stream<T> debounceAndFilter(Duration duration) {
    return stream
        .debounceTime(duration) // 防抖
        .where((value) => value != null); // 过滤空值
  }

  // 合并多个流（例如：搜索输入 + 筛选条件）
  static Stream<R> combineStreams<A, B, R>(
      Stream<A> streamA,
      Stream<B> streamB,
      R Function(A, B) combiner,
      ) {
    return Rx.combineLatest2(streamA, streamB, combiner);
  }

  // 关闭资源
  void dispose() => _subject.close();
}


 
 
 
 
 
 
 
 
 