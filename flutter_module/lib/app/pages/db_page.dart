/**
 * @author: jiangjunhui
 * @date: 2024/12/6
 */
import 'package:flutter/material.dart';
import '../../core/thirdlib/sp.dart';
import '../../core/widgets/custom_appBar_widget.dart';

class dbPage extends StatelessWidget {
  const dbPage({super.key});
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
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () async {
                    await PreferencesHelper.instance.setString('example_key', 'new_value');
                    // 刷新UI或导航到其他地方
                  },
                  tooltip: 'Update Value',
                  child: Icon(Icons.edit),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    await PreferencesHelper.instance.getString('example_key');
                    // 刷新UI或导航到其他地方
                  },
                  tooltip: 'Update Value',
                  child: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        );
  }
}
