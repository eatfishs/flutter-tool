part of 'product_bloc.dart';


// 商品状态基类
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

// 初始状态
class ProductInitial extends ProductState {}

// 加载中状态
class ProductLoading extends ProductState {}

// 加载完成状态
class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

// 错误状态
class ProductError extends ProductState {
  final String error;

  const ProductError(this.error);

  @override
  List<Object> get props => [error];
}
