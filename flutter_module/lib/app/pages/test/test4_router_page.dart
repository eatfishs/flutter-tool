/// @author: jiangjunhui
/// @date: 2025/1/6
library;
import 'package:flutter/material.dart';
import 'package:flutter_module/core/log/log.dart';
import 'package:flutter_module/core/router/my_router.dart';

import '../../../core/widgets/custom_appBar_widget.dart';
import '../../global/pageRouter/router_path.dart';

class Test4RouterPage extends StatelessWidget {
  const Test4RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '测试4',
        actions: const [
        ],
        onBackPressed: () {
          // Handle back button press, if needed
          // MyRouter.backToRoot(context: context);
          final list = MyRouter.getAllRoutes();
          Log.debug("-------list:$list");

          MyRouter.popUntil(context: context, routerURL: PagesURL.ToastUtilURL);
        },
      ),
      body: Container(

      ),
    );
  }
}
