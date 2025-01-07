import 'package:flutter/material.dart';
import 'global/channel/app_channel.dart';
import 'app/pageRouter/router_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _pageString = "home";
  @override
  void initState() {
    super.initState();

    // platform.setMethodCallHandler((call) async {
    //   setState(() {
    //     Object? pageObj = call.arguments;
    //     String pageString = "home";
    //     if (pageObj is String) {
    //       pageString = pageObj;
    //     }
    //     AlertDialog(
    //       title: Text(pageString),
    //     );
    //   });
    // });

    MyAppChannelUtil.setMethodCallHandler(Router_Page_Method, (model) async {
      Object? pageObj = model.data["page"];
      String pageString = "home";
      if (pageObj is String) {
         pageString = pageObj;
      }
      setState(() {
        _pageString = pageString;
      });
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
      routerConfig: routerTest(_pageString),
    );
  }
}
