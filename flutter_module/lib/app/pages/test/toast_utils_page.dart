/**
 * @author: jiangjunhui
 * @date: 2025/2/8
 */
import 'package:flutter/material.dart';

import '../../../core/toast/toast_util.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
 
 class ToastUtilsPage extends StatefulWidget {
   const ToastUtilsPage({super.key});
 
   @override
   State<ToastUtilsPage> createState() => _ToastUtilsPageState();
 }
 
 class _ToastUtilsPageState extends State<ToastUtilsPage> {
   @override
   void initState() {
     super.initState();
     print('initState');
   }
  
   @override
   void didChangeDependencies() {
     super.didChangeDependencies();
     print('didChangeDependencies');
   }
   @override
   void deactivate() {
     super.deactivate();
     print('deactivate');
   }
  
   @override
   void dispose() {
     print('dispose');
     super.dispose();
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
           appBar: CustomAppBar(
             title: 'Toast',
             actions: [
             ],
             onBackPressed: () {
               // Handle back button press, if needed
               Navigator.pop(context);
             },
           ),
           body: Container(
            alignment: Alignment.center,
            child: Column(
             children: [
              ElevatedButton(
               onPressed: () {
                ToastUtil.showToast(msg: "提示信息");
               },
               child: const Text('提示信息 Toast'),
              ),
               ElevatedButton(
                 onPressed: () {
                   ToastUtil.showLoading(msg: "loading", dismissOnTap: true);
                 },
                 child: const Text('loading'),
               ),

             ],
            ),
           ),
         );
   }
 
 }





 
 
 
 
 
 
 