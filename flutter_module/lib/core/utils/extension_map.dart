/**
 * @author: jiangjunhui
 * @date: 2024/12/5
 */
import 'dart:convert';

/// 判断字典是否为空
bool isEmptyMap(Map? map) {
  return map == null || map.isEmpty;
}

extension ExtensionMap<K, V> on Map<K, V> {
  /// Transform map to json
  /// 将map转化为json字符串
  String toJsonString() {
    return jsonEncode(this);
  }

  /*
  * Map<String, int> map1 = {'a': 1, 'b': 2};
  Map<String, int> map2 = {'b': 3, 'c': 4};
  Map<String, int> mergedMap = map1.merge(map2);
  * */

  /// 合并两个 Map
  Map<K, V> merge(Map<K, V> other) {
    return {...this, ...other};
  }

  /*
  * Map<String, int> map = {'a': 1, 'b': 2, 'c': 3};
  Map<String, int> filteredMap = map.filter((key, value) => value > 1);
  print(filteredMap); // 输出: {b: 2, c: 3}
  * */

  /// 筛选符合条件的键值对
  Map<K, V> filter(bool Function(K key, V value) test) {
    final Map<K, V> result = {};
    forEach((K key, V value) {
      if (test(key, value)) {
        result[key] = value;
      }
    });
    return result;
  }

  /*
  * Map<String, int> map = {'a': 1, 'b': 2};
  Map<String, String> newMap = map.mapValues((value) => value.toString());
  print(newMap); // 输出: {a: 1, b: 2}
  * */

  /// 将 Map 的值转换为另一种类型
  Map<K, R> mapValues<R>(R Function(V value) transform) {
    final Map<K, R> result = {};
    forEach((K key, V value) {
      result[key] = transform(value);
    });
    return result;
  }

  /*
  Map<String, int> map = {'a': 1, 'b': 2, 'c': 3};
  MapEntry<String, int>? firstEntry = map.findFirst((key, value) => value > 1);
  print(firstEntry); // 输出: MapEntry(b: 2)
  * */

  /// 获取 Map 中第一个满足条件的键值对
  MapEntry<K, V>? findFirst(bool Function(K key, V value) test) {
    for (final entry in entries) {
      if (test(entry.key, entry.value)) {
        return entry;
      }
    }
    return null;
  }
}
