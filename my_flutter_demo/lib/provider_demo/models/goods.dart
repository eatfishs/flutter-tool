/**
 * @author: jiangjunhui
 * @date: 2025/5/21
 */
import 'package:flutter/material.dart';

class Goods {
  final bool isCollection;
  final String goodsName;

  Goods(this.isCollection, this.goodsName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Goods &&
              runtimeType == other.runtimeType &&
              isCollection == other.isCollection &&
              goodsName == other.goodsName;

  @override
  int get hashCode => isCollection.hashCode ^ goodsName.hashCode;
}
 
 
 
 