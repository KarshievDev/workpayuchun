import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:selfie_attendance/selfie_attendance.dart';

// Callback function type for capturing image
typedef GetSelfieImageCallback = void Function(XFile file);

class AttendanceSelfieScreen extends StatefulWidget {
  const AttendanceSelfieScreen({super.key,
    this.cameras,
    required this.onSelfieCaptured,
    required this.callBackButton});

  final List<CameraDescription>? cameras;
  final GetSelfieImageCallback onSelfieCaptured;
  final Widget callBackButton;

  @override
  State<AttendanceSelfieScreen> createState() => _AttendanceSelfieScreenState();
}

class _AttendanceSelfieScreenState extends State<AttendanceSelfieScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras![1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(children: [
              (controller.value.isInitialized)
                  ? CameraPreview(controller)
                  : Container(color: Colors.black,
                  child: const Center(child: CircularProgressIndicator())),
              Positioned(left: 0.0,
                  right: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                  child: Lottie.asset("assets/images/face_animation.json")),
              Positioned(top: 45.0,
                  left: 25.0,
                  child: IconButton.outlined(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_sharp,),
                      color: Colors.black)),
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.black,
            child: IconButton(
              onPressed: takePicture,
              iconSize: 80,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.circle, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    if (controller.value.isTakingPicture) {
      return null;
    }
    try {
      await controller.setFlashMode(FlashMode.off);
      XFile picture = await controller.takePicture();
      if (mounted) {
        widget.onSelfieCaptured(picture);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>
            SelfiePreviewScreen(
                picture: picture, callBackButton: widget.callBackButton),),
        );
      }
    } on CameraException catch (e) {
      debugPrint('Error occurred while taking picture: $e');
      return null;
    }
  }
}
