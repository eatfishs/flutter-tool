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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    final fullPath = '$path/${Custom_Cached_File_Key}/$fileName';
    final dir = Directory('$path/${Custom_Cached_File_Key}');
    // 检查目录是否存在，如果不存在则创建
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return File(fullPath);
  }

  /// 写入文件
  Future<File> writeFile(String fileName, String data) async {
    final file = await _localFile(fileName);
    print("文件地址：${file.path}");
    return file.writeAsString(data);
  }

  /// 读取文件
  Future<String> readFile(String fileName) async {
    try {
      final file = await _localFile(fileName);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }
}