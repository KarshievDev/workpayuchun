import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HalfCircleShimmerButton extends StatelessWidget {
  const HalfCircleShimmerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8E8E8),
      highlightColor: Colors.white,
      child: CustomPaint(
        size: Size(width, height / 5),
        painter: HalfCircleArcPainter(),
      ),
    );
  }
}

class HalfCircleArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFE8E8E8)
          ..strokeWidth = 8
          ..style = PaintingStyle.fill;

    final Rect arcRect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    canvas.drawArc(arcRect, 3.14, 3.14, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
