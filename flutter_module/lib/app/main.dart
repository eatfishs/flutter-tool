
import 'package:flutter/material.dart';
import 'pageRouter/router_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(bodyMedium:TextStyle(fontSize: 30)),
      ),
      routerConfig: router,
    );
  }
}


