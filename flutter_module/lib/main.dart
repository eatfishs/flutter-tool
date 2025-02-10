import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'app/global/channel/app_channel.dart';
import 'core/screenutil/screen_adapter.dart';
import 'app/global/pageRouter/router_page.dart';


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
    MyAppMethodChannelHandler.setMethodCallHandler(Router_Page_Method,
        (model, method) async {
      print(
          "=================app-MyAppChannelUtil跟flutter交互====================");
      print(model.toString());
      print(method);
      print(
          "==================app-MyAppChannelUtil跟flutter交互===================");
    });
  }

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配
    ScreenAdapter.init(context);

    return MaterialApp.router(
      title: "Flutter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 30)),
      ),
      routerConfig: routerTest("home"),
      builder: EasyLoading.init(),
    );
  }
}
