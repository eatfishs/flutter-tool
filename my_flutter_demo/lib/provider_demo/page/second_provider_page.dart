/**
 * @author: jiangjunhui
 * @date: 2025/5/21
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/counter_model.dart';
 class SecondProviderPage extends StatefulWidget {
   const SecondProviderPage({super.key});

   @override
   State<SecondProviderPage> createState() => _SecondProviderPageState();
 }

 class _SecondProviderPageState extends State<SecondProviderPage> {
   @override
   void initState() {
     super.initState();
     print('initState');
   }

   @override
   void didChangeDependencies() {
     super.didChangeDependencies();
     print('didChangeDependencies-SecondProviderPage');
   }
   @override
   void deactivate() {
     super.deactivate();
     print('deactivate-SecondProviderPage');
   }

   @override
   void dispose() {
     print('dispose-SecondProviderPage');
     super.dispose();
   }
   @override
   Widget build(BuildContext context) {
     // 取出资源
     final _counter = Provider.of<CounterModel>(context);
     return Scaffold(
       appBar: AppBar(title: Text('SecondProviderPage'),),
       // 展示资源中的数据
       body: Container(
         child: Column(
           children: [
             Text('Counter: ${_counter.count}'),
             // 用资源更新方法来设置按钮点击回调
             TextButton(
                 onPressed:  _counter.increment,
                 child: Icon(Icons.add))
           ],
         ),
       ),
     );

   }

 }

 
 
 
 
 
 
 
 
 
 