/**
 * @author: jiangjunhui
 * @date: 2025/5/21
 */
import 'package:flutter/material.dart';
import '../models/goods.dart';
class GoodsListModelProvider with ChangeNotifier {
  List<Goods> _goodsList =
  List.generate(10, (index) => Goods(false, '商品 $index'));

  List<Goods> get goodsList => [..._goodsList]; // 返回不可变列表
  int get total => _goodsList.length;

  void collect(int index) {
    _goodsList[index] = Goods(
      !_goodsList[index].isCollection,
      _goodsList[index].goodsName,
    );
    notifyListeners();
  }
}

 
 
 
 
 
 
 
 
 
 
 