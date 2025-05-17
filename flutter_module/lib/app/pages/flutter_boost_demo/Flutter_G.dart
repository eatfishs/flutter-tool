/// @author: jiangjunhui
/// @date: 2025/4/18
library;
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appBar_widget.dart';

class FlutterG extends StatelessWidget {
  const FlutterG({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FlutterG',
        actions: const [
        ],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Container(

      ),
    );
  }
}

 