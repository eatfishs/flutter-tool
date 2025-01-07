/**
 * @author: jiangjunhui
 * @date: 2025/1/6
 */
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final CachedNetworkImageProvider? imageProvider;

  const CachedImageWidget({
    Key? key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.imageProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          placeholder ?? Container(color: Colors.grey[300]),
      errorWidget: (context, url, error) => errorWidget ?? Icon(Icons.error),
      width: width,
      height: height,
      fit: fit,
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider ?? CachedNetworkImageProvider(imageUrl),
        fit: fit,
        width: width,
        height: height,
      ),
    );
  }
}
