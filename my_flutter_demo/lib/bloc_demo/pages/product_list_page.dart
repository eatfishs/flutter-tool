/**
 * @author: jiangjunhui
 * @date: 2025/6/12
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_demo/bloc_demo/bloc/product/product_bloc.dart';
import 'package:my_flutter_demo/bloc_demo/pages/product_list_Item.dart';
import 'package:provider/provider.dart';
import '../Repository/product_repository.dart';
import '../viewmodel/product_viewmodel.dart';

class ProductListBlocPage extends StatelessWidget {
  const ProductListBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: const ProductListBlocView(),
    );
  }
}





class ProductListBlocView extends StatelessWidget {
  const ProductListBlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品列表'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => ProductViewModel(
          RepositoryProvider.of<ProductRepository>(context),
        )..fetchProducts(),
        child: Consumer<ProductViewModel>(
          builder: (context, viewModel, _) {
            switch (viewModel.state) {
              case ViewState.initial:
              case ViewState.loading:
                return const Center(child: CircularProgressIndicator());

              case ViewState.loaded:
                if (viewModel.products.isEmpty) {
                  return const Center(
                    child: Text('没有商品，请添加商品'),
                  );
                }
                return ListView.builder(
                  itemCount: viewModel.products.length,
                  itemBuilder: (context, index) {
                    return ProductListItem(
                      product: viewModel.products[index],
                      viewModel: viewModel,
                    );
                  },
                );

              case ViewState.error:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('错误: ${viewModel.errorMessage}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => viewModel.fetchProducts(),
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
