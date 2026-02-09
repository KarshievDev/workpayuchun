import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GeneralImagePreviewScreen extends StatelessWidget {
  const GeneralImagePreviewScreen({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(imageUrl),
        heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
      ),
    );
  }
}