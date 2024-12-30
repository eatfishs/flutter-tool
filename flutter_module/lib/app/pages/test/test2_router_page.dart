/**
 * @author: jiangjunhui
 * @date: 2024/12/30
 */
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
class kkTest1RouterPage extends StatefulWidget {
  const kkTest1RouterPage({super.key});

  @override
  State<kkTest1RouterPage> createState() => _kkTest1RouterPageState();
}

class _kkTest1RouterPageState extends State<kkTest1RouterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '第二个页面',
        actions: [
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
