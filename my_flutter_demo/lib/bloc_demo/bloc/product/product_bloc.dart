import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_flutter_demo/bloc_demo/models/product_model.dart';
import '../../Repository/product_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _repository;

  ProductBloc(this._repository) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  // 处理加载商品事件
  Future<void> _onLoadProducts(
      LoadProducts event,
      Emitter<ProductState> emit,
      ) async {
    try {
      emit(ProductLoading());
      final products = await _repository.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  // 处理切换收藏状态事件
  Future<void> _onToggleFavorite(
      ToggleFavorite event,
      Emitter<ProductState> emit,
      ) async {
    if (state is ProductLoaded) {
      try {
        final currentState = state as ProductLoaded;
        final updatedProducts = currentState.products.map((product) {
          return product.id == event.product.id
              ? product.copyWith(isFavorite: !product.isFavorite)
              : product;
        }).toList();

        emit(ProductLoaded(updatedProducts));
        await _repository.toggleFavorite(event.product);
      } catch (e) {
        emit(ProductError(e.toString()));
        // 发生错误时恢复状态
        add(LoadProducts());
      }
    }
  }

}
