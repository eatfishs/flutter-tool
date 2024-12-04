import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/app/pages/color_page.dart';



void main() => runApp(const MyApp());
// 声明 MethodChannel
const platform = MethodChannel('flutter_postData');

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
        child: BaseWidget()
      ),
    );
  }
}


class BaseWidget extends StatefulWidget {
  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  List<Widget> _list = [
    ColorPage()
  ];

  List<String> getData() {
    List<String> _data = [
      "颜色"
    ];
    return _data;
  }
  Widget _itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return _list[index];
        }));
      },
      child: Container(
        child: Card(
          color: Colors.white,
          child: Center(
            child: Text(getData()[index],
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemExtent: 50.0, //强制高度为50.0
          itemCount: getData().length,
          itemBuilder: _itemBuilder),
    );
  }
}

