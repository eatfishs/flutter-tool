/**
 * @author: jiangjunhui
 * @date: 2025/5/29
 */
import 'package:flutter/material.dart';
import 'package:my_flutter_demo/bloc_demo/pages/counter_first_bloc_page.dart';

import 'bloc_demo/pages/product_list_page.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  List<String> getData() {
    List<String> data = [
      "Bloc_计算器demo",
      "Bloc_商品列表"
    ];
    return data;
  }

  void _navigateToPage1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CounterFirstBlocPagePage()),
    );
  }

  void _navigateToPage2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductListBlocPage()),
    );

  }

  Widget _itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        if(index == 0) {
          _navigateToPage1(context);
        } else if (index == 1) {
          _navigateToPage2(context);
        }
      },
      child: Container(
        child: Card(
          color: Colors.white,
          child: Center(
            child: Text(getData()[index],
                style: const TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Provider Demo')),
        body: Container(
          child: ListView.builder(
              itemExtent: 50.0, //强制高度为50.0
              itemCount: getData().length,
              itemBuilder: _itemBuilder),
        ),
      ),
    );
  }
}









 
 
 
 
 
 
 
 
 
 