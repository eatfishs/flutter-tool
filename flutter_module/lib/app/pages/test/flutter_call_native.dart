/// @author: jiangjunhui
/// @date: 2025/1/17
library;
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import '../../global/channel/app_channel.dart';
class FlutterCallNativePage extends StatelessWidget {
  const FlutterCallNativePage({super.key});

  void _postData() async {
    APPChannelModel model = APPChannelModel(code: "0", message: "传值成功",data: {"one":"1"});
    APPChannelModel? resultModel =  await MyAppMethodChannelHandler.callNativeMethod(method: "post_data", model: model);
    print("flutter向原生传值,接收到返回值:${resultModel.toJson()}");
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: CustomAppBar(
            title: 'flutter向原生传值',
            actions: const [
            ],
            onBackPressed: () {
              // Handle back button press, if needed
              Navigator.pop(context);
            },
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                    height: 50,
                    width: 200,
                    color: Colors.red,
                    child:
                    TextButton(onPressed: _postData, child: const Text("flutter向原生传值"))),

              ],
            ),
          ),
        );
  }
}

 
 
 
 
 
 
 
 
 
 
 
 