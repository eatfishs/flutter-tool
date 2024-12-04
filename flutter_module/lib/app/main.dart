import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() => runApp(const MyApp());
// 声明 MethodChannel
const platform = MethodChannel('flutter_postData');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application..
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}




class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter"),),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () async{
              List result;
              try{
                result = await platform.invokeMethod('flutter_postData',{"flutter":"flutter value"});
              }catch(e){
                result = [];
              }
              print(result.toString());
            },
              child: const Text('获取APP的设备信息'),)
          ],
        ),
      ),
    );
  }
}

