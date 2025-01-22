/**
 * @author: jiangjunhui
 * @date: 2024/12/6
 */
import 'package:flutter/material.dart';
import '../../../core/data/sp/sp.dart';
import '../../../core/widgets/custom_appBar_widget.dart';

class dbPage extends StatefulWidget {

  const dbPage({super.key});

  @override
  State<dbPage> createState() => _dbPageState();
}

class _dbPageState extends State<dbPage> {
  String _string = "获取初始化值";
  Future<void> _setString() async {
    await PreferencesHelper.setString('example_key', '新值');
  }
  Future<String?> _getString() async{
    String? text = await PreferencesHelper.getString('example_key');
    setState(() {
      _string = text ?? "";
    });
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '数据库',
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextButton(onPressed: _setString, child: Text("存储")),
            SizedBox(height: 30),
            TextButton(onPressed: _getString, child: Text(this._string))
          ],
        ),
      ),
    );
  }
}


