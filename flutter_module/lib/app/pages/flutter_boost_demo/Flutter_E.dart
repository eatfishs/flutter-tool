/**
 * @author: jiangjunhui
 * @date: 2025/4/18
 */
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appBar_widget.dart';

class FlutterE extends StatelessWidget {
  const FlutterE({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FlutterE',
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

 