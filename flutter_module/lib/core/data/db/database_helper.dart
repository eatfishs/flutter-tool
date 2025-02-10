/**
 * @author: jiangjunhui
 * @date: 2025/2/10
 */
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // 单例模式
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // 初始化数据库
  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_table(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );
  }

  /*
  int id = await dbHelper.insert({'name': 'Alice'}, 'my_table');
  print('Inserted with ID: $id');
  * */
  // 插入数据
  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await database;
    return await db.insert(tableName, row);
  }

  /*
  List<Map<String, dynamic>> allRows = await dbHelper.queryAll('my_table');
  print('All rows: $allRows');
  * */
  // 查询所有数据
  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await database;
    return await db.query(tableName);
  }

  /*
  // 根据条件查询数据
  List<Map<String, dynamic>> filteredRows = await dbHelper.query(
    'my_table',
    where: 'name = ?',
    whereArgs: ['Alice'],
  );
  print('Filtered rows: $filteredRows');
  * */
  // 根据条件查询数据
  Future<List<Map<String, dynamic>>> query(String tableName,
      {String? where,
      List<dynamic>? whereArgs,
      String? orderBy,
      int? limit,
      int? offset}) async {
    Database db = await database;
    return await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  /*
  int updatedRows = await dbHelper.update(
    'my_table',
    {'name': 'Bob'},
    'id = ?',
    whereArgs: [id],
  );
  print('Updated $updatedRows rows');
  * */
  // 更新数据
  Future<int> update(String tableName, Map<String, dynamic> row, String where,
      {List<dynamic>? whereArgs}) async {
    Database db = await database;
    return await db.update(
      tableName,
      row,
      where: where,
      whereArgs: whereArgs,
    );
  }

  /*
  int deletedRows = await dbHelper.delete(
    'my_table',
    'id = ?',
    whereArgs: [id],
  );
  print('Deleted $deletedRows rows');
  * */
  // 删除数据
  Future<int> delete(String tableName, String where,
      {List<dynamic>? whereArgs}) async {
    Database db = await database;
    return await db.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // 关闭数据库
  Future close() async {
    Database db = await database;
    return db.close();
  }
}
