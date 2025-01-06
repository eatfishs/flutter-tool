/**
 * @author: jiangjunhui
 * @date: 2024/12/30
 */
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appBar_widget.dart';

class kkTest1RouterPage extends StatefulWidget {
  final Map<String, dynamic>? queryParam;

  const kkTest1RouterPage({Key? key, required this.queryParam})
      : super(key: key);

  @override
  State<kkTest1RouterPage> createState() => _kkTest1RouterPageState();
}

class _kkTest1RouterPageState extends State<kkTest1RouterPage> {
  String _queryParam = "";
  void getParam() {
    String text = widget.queryParam.toString();
    this.setState(() {
      _queryParam =
      "上级界面传入参数：$text";
    });
  }

  @override
  void initState() {
    super.initState();
    print("===========================");
    getParam();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: '第一个页面',
        actions: [],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context,"我是第一个页面返回的字符串");
        },
      ),
      body: Container(
        height: 100,
        child: Text('$_queryParam'),
      ),
    );
  }
}
