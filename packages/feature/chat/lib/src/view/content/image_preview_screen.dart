import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../service/download_service.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({super.key, required this.message});
  final String? message;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  downloadImage(widget.message);
                });
              },
              icon: const Icon(Icons.download))
        ],
      ),
      body: PhotoView(
        imageProvider: MemoryImage(base64Decode(widget.message??'')),
        heroAttributes: PhotoViewHeroAttributes(tag: widget.message??''),
      ),
    );
  }

}
