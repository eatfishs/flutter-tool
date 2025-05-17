import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('错误路由'),
      ),
      body: Container(
        child: const Text(
          '错误路由处理',
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
      ),
    );
  }
}
