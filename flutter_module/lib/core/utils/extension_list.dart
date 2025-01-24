/**
 * @author: jiangjunhui
 * @date: 2024/12/5
 */
import 'dart:convert';
import 'object_utils.dart';

/// 判断集合是否为空
bool isEmptyList(Iterable? list) {
  return list == null || list.isEmpty;
}

extension ExtensionList<E> on List<E> {
  /// Transform list to json
  /// 将list转化为json字符串
  String toJsonString() {
    return jsonEncode(this);
  }

  /// 将list转化为json字符串，换行
  String getJsonPretty() {
    return JsonEncoder.withIndent('\t').convert(this);
  }

  /// Checks if data is null.
  /// 判断对象是否为null
  bool isNull() => ObjectUtils.isNull(this);

  /// Checks if data is null or Blank (Empty or only contains whitespace).
  /// 检查数据是否为空或空(空或只包含空格)
  bool isNullOrBlank() => ObjectUtils.isNullOrBlank(this);

  /// 字符串拼接
  String joinWithOptions({required String separator}) {
    return map((e) => e.toString()).join(separator);
  }

  /*
  * List<int> numbers = [1, 2, 3];
  List<String> strings = numbers.mapToList((element) => element.toString());
  print(strings); // 输出: [1, 2, 3]
  * */

  /// 对列表中的每个元素执行操作并返回新列表
  List<R> mapToList<R>(R Function(E element) transform) {
    List<R> result = [];
    for (E element in this) {
      result.add(transform(element));
    }
    return result;
  }

  /**
   * List<int> numbers = [1, 2, 2, 3, 3, 3];
      List<int> distinctNumbers = numbers.distinct();
      print(distinctNumbers); // 输出: [1, 2, 3]
   * */

  /// 列表元素去重
  List<E> distinct() {
    return toSet().toList();
  }
}
