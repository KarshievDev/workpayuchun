import 'package:flutter/material.dart';
import 'dart:math' as m;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabAnimatedCircularButton extends StatefulWidget {
  final VoidCallback? onComplete;
  final bool isCheckedIn;
  final String title;
  final Color color;

  const TabAnimatedCircularButton(
      {super.key,
      required this.title,
      required this.color,
      this.onComplete,
      this.isCheckedIn = false});

  @override
  State<TabAnimatedCircularButton> createState() =>
      _AnimatedCircularButtonState();
}

class _AnimatedCircularButtonState extends State<TabAnimatedCircularButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    //Init the animation and it's event handler
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
          controller.reset();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onLongPressStart(LongPressStartDetails details) {
    controller.reset();
    controller.forward();
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.9,
      child: ClipRRect(
        child: GestureDetector(
          onLongPressStart: _onLongPressStart,
          onLongPressEnd: _onLongPressEnd,
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, snapshot) {
                return CustomPaint(
                  painter: ArcShapePainter(
                    progress: animation.value,
                    radius: 90.r,
                    color: widget.color,
                    strokeWidth: 8.0,
                  ),
                  //Logo and text
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Logo
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 0, 0),
                        child: Image.asset(
                          "assets/images/tap_figer.png",
                          color: Colors.white,
                          height: 45.h,
                          width: 45.w,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(color: Colors.white, fontSize: 16.r),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

//Arc shape painter
class ArcShapePainter extends CustomPainter {
  //Define constructor parameters
  late double progress;
  late double radius;
  late Color color;
  late double strokeWidth;

  //Define private variables
  late Paint _activePaint;
  late Paint _inActivePaint;
  late Paint _solidPaint;

  //Create constructor and initialize private variables
  ArcShapePainter(
      {required this.color,
      this.progress = .5,
      this.radius = 400,
      this.strokeWidth = 8.0}) {
    _activePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    _inActivePaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    _solidPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var progressAngle = m.pi * 2.0 * progress;

    //Define center of the available screen
    Offset center = Offset(size.width / 2, size.height / 2);

    //Draw the line arc
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -m.pi / 2,
        progressAngle, false, _activePaint);

    canvas.drawCircle(center, radius, _inActivePaint);

    canvas.drawCircle(center, radius - 10.0, _solidPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
