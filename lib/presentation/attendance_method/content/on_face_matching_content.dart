import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnFaceMatchingContent extends StatelessWidget {
  final String? faceData;

  const OnFaceMatchingContent({super.key,this.faceData});

  @override
  Widget build(BuildContext context) {
    Uint8List bytesImage;
    bytesImage = const Base64Decoder().convert(faceData!);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Image.memory(bytesImage,width: double.infinity,fit: BoxFit.cover,)),
              ],
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Lottie.asset("assets/images/face_animation.json")),
            Positioned(
                top: 0,
                bottom: 150,
                left: 0,
                right: 0,
                child: Lottie.asset("assets/images/face_scan.json")),
          ],
        ),
      ),
    );
  }
}
