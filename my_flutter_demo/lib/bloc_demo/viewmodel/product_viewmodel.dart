/**
 * @author: jiangjunhui
 * @date: 2025/6/12
 */
import 'dart:async';

import 'package:flutter/material.dart';

import '../Repository/product_repository.dart';
import '../models/product_model.dart';
// 视图状态枚举
enum ViewState { initial, loading, loaded, error }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ProductViewModel(this._repository);

  // 获取商品列表
  Future<void> fetchProducts() async {
    _setState(ViewState.loading);

    try {
      _products = await _repository.getProducts();
      _setState(ViewState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  // 切换收藏状态
  Future<void> toggleFavorite(ProductModel product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      // 先更新UI状态
      _products[index] = _products[index].copyWith(
        isFavorite: !_products[index].isFavorite,
      );
      notifyListeners();

      try {
        // 然后更新数据源
        await _repository.toggleFavorite(_products[index]);
      } catch (e) {
        // 如果更新失败，恢复UI状态
        _products[index] = _products[index].copyWith(
          isFavorite: !_products[index].isFavorite,
        );
        notifyListeners();
        _errorMessage = e.toString();
        _setState(ViewState.error);
      }
    }
  }

  // 删除商品
  Future<void> deleteProduct(ProductModel product) async {
    _products.removeWhere((p) => p.id == product.id);
    notifyListeners();

    try {
      await _repository.deleteProduct(product);
    } catch (e) {
      // 如果删除失败，恢复商品列表
      await fetchProducts();
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  // 设置状态并通知监听器
  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
 