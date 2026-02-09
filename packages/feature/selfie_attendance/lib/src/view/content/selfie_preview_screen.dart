import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SelfiePreviewScreen extends StatelessWidget {
  const SelfiePreviewScreen(
      {super.key, required this.picture, required this.callBackButton});

  final Widget callBackButton;

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    const double mirror = math.pi;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    width: double.infinity,
                    child: Transform(alignment: Alignment.center, transform: Matrix4.rotationY(mirror),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(File(picture.path), fit: BoxFit.cover))),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: callBackButton,
                )
              ]),
              Positioned(top: 30.0,left: 25.0,child: IconButton.outlined(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_sharp,),color: Colors.black)),


              // Positioned(
              //     bottom: 60,
              //     left: 25,
              //     right: 25,
              //     child: callBackButton)
            ],
          ),
        ),
      ),
    );
  }
}
