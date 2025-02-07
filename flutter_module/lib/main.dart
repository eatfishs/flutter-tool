import 'package:flutter/material.dart';
import 'global/channel/app_channel.dart';
import 'app/pageRouter/router_page.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    //
    MyAppMethodChannelHandler.setMethodCallHandler(Router_Page_Method, (model, method) async {
      print("=================app-MyAppChannelUtil跟flutter交互====================");
      print(model.toString());
      print(method);
      print("==================app-MyAppChannelUtil跟flutter交互===================");
    });


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Flutter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 30)),
      ),
      routerConfig: routerTest("home"),
    );
  }
}
