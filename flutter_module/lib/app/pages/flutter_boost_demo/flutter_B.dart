/**
 * @author: jiangjunhui
 * @date: 2025/4/18
 */
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appBar_widget.dart';
 
class FlutterB extends StatelessWidget {
  const FlutterB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: CustomAppBar(
            title: 'FlutterB',
            actions: [
            ],
            onBackPressed: () {
              // Handle back button press, if needed
              Navigator.pop(context);
            },
          ),
          body: Container(

          ),
        );;
  }
}

 
 
 
 
 
 
 
 
 
 
 