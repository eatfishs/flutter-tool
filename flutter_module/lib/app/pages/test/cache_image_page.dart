/**
 * @author: jiangjunhui
 * @date: 2025/1/7
 */
import 'package:flutter/material.dart';
import '../../../core/cacheImage/cache_image.dart';
import '../../../core/cacheImage/cache_image_manager.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
String _iconUrl = "http://devimg.dongfangfuli.com/bfd/2020-07-23/dbf9ac6b2fe06aae4a50dd0a6f7f4865.png";
String _iconUrl1 = "http://devimg.dongfangfuli.com/bfd/2020-07-22/0efdabce138677a862a9c05fc71bca7a.png";
String _iconUrl3 = "http://devimg.dongfangfuli.com/bfd/2020-07-23/f073ed00d65ef0b1be1c4a9d8cbdc4ed.png";
String _iconUrl4 = "https://images-blogs.oss-cn-hangzhou.aliyuncs.com/image/web%E6%B8%B2%E6%9F%93%E8%BF%87%E7%A8%8B-3.png";
class CacheImagePage extends StatefulWidget {
  const CacheImagePage({super.key});

  @override
  State<CacheImagePage> createState() => _CacheImagePageState();
}

class _CacheImagePageState extends State<CacheImagePage> {
  String _imageUrl = _iconUrl4;
  String _cacheSize = "图片缓存大小：";

  void _getCacheSize() async {
    MyCacheImageManager.getFilePath(_imageUrl);
    String _size = await MyCacheImageManager.getCacheSize();
    setState(() {
      _cacheSize = "图片缓存大小：${_size}";
    });
  }


  void _clearAll() {
    MyCacheImageManager.clearAllCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '图片测试',
        actions: [],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            CachedImageWidget(imageUrl: _imageUrl, onSuccess: (image,iconUrl){
              print("图片下载成功：${image},=====${iconUrl}");
            },onError: (error,iconUrl){
              print("图片下载失败：${error},=====${iconUrl}");
            }),
            SizedBox(height: 50,),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child:
                TextButton(onPressed: _getCacheSize, child: Text("获取缓存大小"))),
            Container(
              height: 50,
              child: Text(_cacheSize),
            ),
            Container(
                height: 50,
                width: 200,
                color: Colors.red,
                child:
                TextButton(onPressed: _clearAll, child: Text("清空所有图片缓存"))),

          ],
        ),
      ),
    );
  }
}
