/**
 * @author: jiangjunhui
 * @date: 2025/1/23
 */
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/widgets/custom_appBar_widget.dart';
class NetworkServicePage extends StatefulWidget {
  const NetworkServicePage({super.key});

  @override
  State<NetworkServicePage> createState() => _NetworkServicePageState();
}

class _NetworkServicePageState extends State<NetworkServicePage> {


  Future<String> returnTwice() {
    try {
      int num = int.parse('abc');
      print(num);
      return Future.value("尝试将非数字字符串转为整数，会抛出 FormatException 异常");
    } catch (e) {
      print("-----catch:${e}");
      return Future.value("红红火火恍恍惚惚");
    }
  }


  void _test() async {
    // 调用函数并获取返回的 Future
    final resultFuture = returnTwice();
    // 获取第一次返回的参数
    final firstResult = await resultFuture;
    print('结果: $firstResult');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '测试网络请求',
        actions: [
        ],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child:
                TextButton(onPressed: _test, child: Text("存储"))),
            SizedBox(height: 30),


          ],
        ),
      ),
    );
  }

}

 
 
 
 
 
 
 
 
 
 
 
 