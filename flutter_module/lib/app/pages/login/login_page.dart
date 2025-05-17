/// @author: jiangjunhui
/// @date: 2024/12/25
library;
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appBar_widget.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: CustomAppBar(
            title: '登陆',
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

