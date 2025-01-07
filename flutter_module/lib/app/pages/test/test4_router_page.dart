/**
 * @author: jiangjunhui
 * @date: 2025/1/6
 */
import 'package:flutter/material.dart';
import 'package:flutter_module/core/router/router_util.dart';

import '../../../core/widgets/custom_appBar_widget.dart';
import '../../pageRouter/pages_url_constant.dart';

class Test4RouterPage extends StatelessWidget {
  const Test4RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '测试4',
        actions: [
        ],
        onBackPressed: () {
          // Handle back button press, if needed
          MyRouter.backToRoot(context: context);
        },
      ),
      body: Container(

      ),
    );;
  }
}
