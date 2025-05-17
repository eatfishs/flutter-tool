/// @author: jiangjunhui
/// @date: 2024/12/31
library;
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appBar_widget.dart';

class Test3TouterPagePage extends StatelessWidget {
  const Test3TouterPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: CustomAppBar(
            title: '测试3',
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
