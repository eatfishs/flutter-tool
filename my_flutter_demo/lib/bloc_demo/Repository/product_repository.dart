/**
 * @author: jiangjunhui 
 * @date: 2025/6/12
 */
 import 'package:flutter/material.dart';
import 'package:my_flutter_demo/bloc_demo/models/product_model.dart';
import 'dart:async';

// 商品仓库接口
abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<void> toggleFavorite(ProductModel product);
  Future<void> deleteProduct(ProductModel product);
}

// 模拟实现的商品仓库
class MockProductRepository implements ProductRepository {
  final List<ProductModel> _products = [
    ProductModel(
      id: 1,
      name: 'iPhone 14',
      price: 5999.0,
      description: '最新款苹果手机',
      isFavorite: false,
      imageUrl: 'https://picsum.photos/seed/iphone14/300/200',
    ),
    ProductModel(
      id: 2,
      name: 'MacBook Pro',
      price: 12999.0,
      description: '专业级笔记本电脑',
      isFavorite: true,
      imageUrl: 'https://picsum.photos/seed/macbook/300/200',
    ),
    ProductModel(
      id: 3,
      name: 'iPad Air',
      price: 4799.0,
      description: '轻薄便携平板电脑',
      isFavorite: false,
      imageUrl: 'https://picsum.photos/seed/ipadair/300/200',
    ),
    ProductModel(
      id: 4,
      name: 'Apple Watch',
      price: 2999.0,
      description: '智能手表',
      isFavorite: true,
      imageUrl: 'https://picsum.photos/seed/applewatch/300/200',
    ),
    ProductModel(
      id: 5,
      name: 'AirPods Pro',
      price: 1999.0,
      description: '主动降噪耳机',
      isFavorite: false,
      imageUrl: 'https://picsum.photos/seed/airpods/300/200',
    ),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 500));
    return _products;
  }

  @override
  Future<void> toggleFavorite(ProductModel product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = _products[index].copyWith(
        isFavorite: !_products[index].isFavorite,
      );
    }
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> deleteProduct(ProductModel product) async {
    _products.removeWhere((p) => p.id == product.id);
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
