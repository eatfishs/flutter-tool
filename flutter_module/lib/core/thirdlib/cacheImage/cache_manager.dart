/**
 * @author: jiangjunhui
 * @date: 2025/1/7
 */
import 'dart:io';
import 'package:flutter_module/core/thirdlib/cacheImage/cache_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class MyCacheManager {
  /// 获取图片本地路径
  static Future<String> getFilePath(String imageUrl) async {
    CacheManager manager = MyCustomCacheManager.instance;
    File file = await manager.getSingleFile(imageUrl);
    print("获取图片本地路径==${file.path}");
    return file.path;
  }

  /// 移除指定路径下图片
  static Future<void> clearImageCache(String imageUrl) async {
    CacheManager manager = MyCustomCacheManager.instance;
    // 移除单个文件的缓存
    try {
      await manager.removeFile(imageUrl);
      print(' 移除指定路径下图片已成功移除');
    } catch (e) {
      print(' 移除指定路径下图片缓存时出错: $e');
    }
  }

  /// 移除所有图片
  static Future<void> clearAllCache() async {
    CacheManager manager = MyCustomCacheManager.instance;
    try {
      await manager.emptyCache();
      print('移除所有图片缓存已成功移除');
    } catch (e) {
      print('移除所有图片缓存时出错: $e');
    }
  }


  static Future<String> getCacheSize() async {
    // 配置缓存目录
    CacheManager manager = MyCustomCacheManager.instance;
    int size = await manager.store.getCacheSize();
    double cacheSize = size / 1024 / 1024;
    return cacheSize.toStringAsFixed(2);
  }

}

class MyCustomCacheManager {
  static const Custom_Cached_Image_Key = "Custom_Cached_Image_Key";
  static CacheManager instance = CacheManager(
    Config(
      Custom_Cached_Image_Key,
      // 缓存时间
      stalePeriod: Duration(days: 30),
      // maxNrOfCacheObjects规定了最大缓存文件数量为 50 个
      maxNrOfCacheObjects: 50,
      // 存储缓存信息的数据库名称
      repo: JsonCacheInfoRepository(databaseName: Custom_Cached_Image_Key),
      // 其他配置
      fileSystem: IOFileSystem(Custom_Cached_Image_Key),
    ),
  );
}