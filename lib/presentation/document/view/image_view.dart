import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
        imageProvider: const AssetImage("assets/images/img_noc.png")
    );
  }
}
