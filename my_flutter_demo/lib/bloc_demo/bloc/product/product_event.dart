part of 'product_bloc.dart';

// 商品事件基类
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// 加载商品事件
class LoadProducts extends ProductEvent {}

// 切换商品收藏状态事件
class ToggleFavorite extends ProductEvent {
  final ProductModel product;

  const ToggleFavorite(this.product);

  @override
  List<Object> get props => [product];
}

// 删除商品事件
class DeleteProduct extends ProductEvent {
  final ProductModel product;

  const DeleteProduct(this.product);

  @override
  List<Object> get props => [product];
}
