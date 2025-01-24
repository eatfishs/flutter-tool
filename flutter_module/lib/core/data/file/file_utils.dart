/**
 * @author: jiangjunhui
 * @date: 2025/1/23
 */
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static const Custom_Cached_File_Key = "Custom_Cached_File_Key";

  FileUtils._privateConstructor();

  static final FileUtils _instance = FileUtils._privateConstructor();

  factory FileUtils() {
    return _instance;
  }

  Future<File> _localFile(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final fullPath = '$path/${Custom_Cached_File_Key}/$fileName';
      final dir = Directory('$path/${Custom_Cached_File_Key}');
      // 检查目录是否存在，如果不存在则创建
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return File(fullPath);
    } catch (e) {
      print('获取文件目录地址失败: $e');
      rethrow;
    }
  }

  /// 写入文件
  Future<void> writeFile(String fileName, String data) async {
    try {
      final file = await _localFile(fileName);
      print("文件地址：${file.path}");
      file.writeAsString(data);
    } catch (e) {
      print('文件写入失败: $e');
      rethrow;
    }
  }

  /// 读取文件
  Future<String?> getFile(String fileName) async {
    try {
      final file = await _localFile(fileName);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      print('文件读取失败: $e');
      rethrow;
    }
  }

  /// 移除指定文件
  Future<void> removeFilePath(String fileName) async{
    try {
      final file = await _localFile(fileName);
      // 移除文件
      await file.delete();
    } catch (e) {
      print('移除文件时出错: $e');
    }
  }
}
