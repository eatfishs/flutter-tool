/**
 * @author: jiangjunhui
 * @date: 2025/5/21
 */
import 'package:flutter/material.dart';
import 'package:my_flutter_demo/provider_demo/page/second_provider_page.dart';
import 'package:provider/provider.dart';
import '../model/counter_model.dart';

class FirstProviderPage extends StatelessWidget {
  const FirstProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CounterModel(),
        child: Scaffold(
        appBar: AppBar(title: const Text('Page 1')),
          body: FirstPage())
    );
  }
}




class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    return Container(
      child: Column(
        children: [
          // 展示资源中的数据
          Text('Counter: ${_counter.count}'),
          // 用资源更新方法来设置按钮点击回调
          TextButton(
              child: Text('进入二级界面'),
              onPressed: (){
                final counter = context.read<CounterModel>(); // 获取实例
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: counter, // 明确使用 ChangeNotifierProvider
                      child: SecondProviderPage(),
                    ),
                  ),
                );
              })
        ],
      ),
    );

  }

}

