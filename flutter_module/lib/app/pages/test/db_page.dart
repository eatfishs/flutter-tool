/**
 * @author: jiangjunhui
 * @date: 2024/12/6
 */
import 'package:flutter/material.dart';
import '../../../core/data/db/database_helper.dart';
import '../../../core/data/file/file_utils.dart';
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

  Future<String?> _getString() async {
    String? text = await PreferencesHelper.getString('example_key');
    setState(() {
      _string = text ?? "";
    });
    return text;
  }

  void _writeFile() async {
    // 获取 FileUtils 单例实例
    final fileUtils = FileUtils();
    // 写入文件
    await fileUtils.writeFile('test.txt', 'Hello, World!');
  }

  void _db() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    // 插入数据
    int id = await dbHelper.insert({'name': 'Alice'}, 'my_table');
    print('Inserted with ID: $id');
    // 查询所有数据
    List<Map<String, dynamic>> allRows = await dbHelper.queryAll('my_table');
    print('All rows: $allRows');
    // 根据条件查询数据
    List<Map<String, dynamic>> filteredRows = await dbHelper.query(
      'my_table',
      where: 'name = ?',
      whereArgs: ['Alice'],
    );
    print('Filtered rows: $filteredRows');
    // 更新数据
    int updatedRows = await dbHelper.update(
      'my_table',
      {'name': 'Bob'},
      'id = ?',
      whereArgs: [id],
    );
    print('Updated $updatedRows rows');
    // 删除数据
    int deletedRows = await dbHelper.delete(
      'my_table',
      'id = ?',
      whereArgs: [id],
    );
    print('Deleted $deletedRows rows');
    // 关闭数据库
    await dbHelper.close();
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
            SizedBox(height: 50),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child: TextButton(onPressed: _setString, child: Text("存储"))),
            SizedBox(height: 30),
            Container(
                height: 50,
                width: 375,
                child: TextButton(
                    onPressed: _getString, child: Text(this._string))),
            SizedBox(height: 30),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child: TextButton(onPressed: _writeFile, child: Text("写入文件"))),
            SizedBox(height: 30),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child: TextButton(onPressed: _db, child: Text("数据库操作"))),
          ],
        ),
      ),
    );
  }
}
