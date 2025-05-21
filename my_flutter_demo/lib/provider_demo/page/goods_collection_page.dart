/**
 * @author: jiangjunhui
 * @date: 2025/5/21
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/goodsList_Provider_model.dart';
import '../models/goods.dart';

class GoodsCollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selector'),),
      body: GoodsPage(),
    );
  }
}


class GoodsPage extends StatelessWidget {
  const GoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoodsListModelProvider(),
      child: Consumer<GoodsListModelProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.total,
            itemBuilder: (context, index) {
              return Selector<GoodsListModelProvider, Goods>(
                selector: (context, provider) => provider.goodsList[index],
                shouldRebuild: (prev, next) => prev != next,
                builder: (context, data, child) {
                  print('No.${index + 1} rebuild');
                  return ListTile(
                    title: Text(data.goodsName),
                    trailing: IconButton(
                      icon: Icon(
                        data.isCollection ? Icons.star : Icons.star_border,
                        color: data.isCollection ? Colors.yellow : null,
                      ),
                      onPressed: () => provider.collect(index),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}



 
 
 
 
 
 
 
 
 