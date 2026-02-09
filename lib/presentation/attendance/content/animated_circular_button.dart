import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'dart:math' as m;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedHalfCircularButton extends StatefulWidget {
  final VoidCallback? onComplete;
  final bool isCheckedIn;
  final String title;
  final Color color;

  const AnimatedHalfCircularButton({
    super.key,
    required this.title,
    required this.color,
    this.onComplete,
    this.isCheckedIn = false,
  });

  @override
  State<AnimatedHalfCircularButton> createState() =>
      _AnimatedHalfCircularButtonState();
}

class _AnimatedHalfCircularButtonState extends State<AnimatedHalfCircularButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
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
      aspectRatio: DeviceUtil.isTablet ? 1.2.r : 1.5.r,
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
                  radius: 165.r,
                  color: widget.color,
                  strokeWidth: 5.0.r,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32.0, 0, 0),
                    child: Image.asset(
                      "assets/images/tap_figer.png",
                      color: Colors.white,
                      height: 50.h,
                      width: 50.w,
                    ),
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ArcShapePainter extends CustomPainter {
  late double progress;
  late double radius;
  late Color color;
  late double strokeWidth;

  late Paint _activePaint;
  late Paint _inActivePaint;
  late Paint _solidPaint;
  late Paint _solidShadowPaint;
  late Paint _solidProgressPaint;

  ArcShapePainter({
    required this.color,
    this.progress = .5,
    this.radius = 400,
    this.strokeWidth = 4,
  }) {
    _activePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    _inActivePaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    _solidProgressPaint = Paint()
      ..style = PaintingStyle.fill;

    _solidPaint = Paint()..style = PaintingStyle.fill;

    _solidShadowPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressRect = Rect.fromCircle(center: center, radius: radius + 16.0);

    final gradient = LinearGradient(
      colors: [color.withValues(alpha: 0.9), Colors.white.withValues(alpha: 0.3)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(rect);
    _solidPaint.shader = gradient;
    _solidProgressPaint.shader = gradient;

    // Half circle: start at π and sweep π
    final startAngle = m.pi;
    final sweepAngle = m.pi;

    //Draw solid progress
    canvas.drawArc(rect, startAngle, startAngle, false, _solidPaint);
    //Draw solid progress
    canvas.drawArc(
      progressRect,
      startAngle,
      startAngle,
      true,
      _solidShadowPaint,
    );
    // Draw background arc (inactive)
    canvas.drawArc(rect, startAngle, sweepAngle, false, _inActivePaint);
    //Draw solid progress
    canvas.drawArc(
      progressRect,
      startAngle,
      sweepAngle * progress,
      true,
      _solidProgressPaint,
    );
    // Draw progress arc (active)
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle * progress,
      false,
      _activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AnimatedCircularButton extends StatefulWidget {
  final VoidCallback? onComplete;
  final bool isCheckedIn;
  final String title;
  final Color color;

  const AnimatedCircularButton({
    super.key,
    required this.title,
    required this.color,
    this.onComplete,
    this.isCheckedIn = false,
  });

  @override
  State<AnimatedCircularButton> createState() => _AnimatedCircularButtonState();
}

class _AnimatedCircularButtonState extends State<AnimatedCircularButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    //Init the animation and it's event handler
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
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
      aspectRatio: DeviceUtil.isTablet ? 1.2.r : 1.9,
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
                  strokeWidth: 5.0.r,
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
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
