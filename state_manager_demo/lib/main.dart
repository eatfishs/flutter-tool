import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> getData() {
    List<String> data = [
      "provider_demo",
      "bloc_demo",
      "getx_demo"
    ];
    return data;
  }
  Widget _itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        // MyRouter.router(
        //     routerURL: _pathList[index], context: context);
      },
      child: Container(
        child: Card(
          color: Colors.white,
          child: Center(
            child: Text(getData()[index],
                style: const TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            child: ListView.builder(
                itemExtent: 50.0, //强制高度为50.0
                itemCount: getData().length,
                itemBuilder: _itemBuilder),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
