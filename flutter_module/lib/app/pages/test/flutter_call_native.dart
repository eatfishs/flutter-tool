/**
 * @author: jiangjunhui
 * @date: 2025/1/17
 */
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import '../../global/channel/app_channel.dart';
class FlutterCallNativePage extends StatelessWidget {
  const FlutterCallNativePage({super.key});

  void _postData() async {
    APPChannelModel _model = APPChannelModel(code: "0", message: "传值成功",data: {"one":"1"});
    APPChannelModel? _resultModel =  await MyAppMethodChannelHandler.callNativeMethod(method: "post_data", model: _model);
    print("flutter向原生传值,接收到返回值:${_resultModel.toJson()}");
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: CustomAppBar(
            title: 'flutter向原生传值',
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
              children: [
                SizedBox(height: 50),
                Container(
                    height: 50,
                    width: 200,
                    color: Colors.red,
                    child:
                    TextButton(onPressed: _postData, child: Text("flutter向原生传值"))),

              ],
            ),
          ),
        );
  }
}

 
 
 
 
 
 
 
 
 
 
 
 