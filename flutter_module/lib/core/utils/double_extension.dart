/**
 * @author: jiangjunhui
 * @date: 2025/1/24
 */
import 'dart:math';


extension DoubleExtension on double {
  /**
   * double num = 3.1415926;
      double result = num.toPrecision(2);
      print(result); // 输出: 3.14
   * */
  /// 保留指定小数位数
  double toPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits).toDouble();
    return ((this * mod).round().toDouble() / mod);
  }
}
 
 
 
 
 
 
 
 
 