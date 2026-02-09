import 'package:flutter/material.dart';

class SpeechBubbleTailPainter extends CustomPainter {
  final Color color;
  final Color? borderColor;

  SpeechBubbleTailPainter({required this.color, this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    // Create a curved tail pointing down and to the right (towards the robot)
    path.moveTo(size.width - 12, 0); // Start from left
    path.quadraticBezierTo(
      size.width - 6,
      size.height * 0.3,
      size.width - 2,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 4,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - 8,
      size.height * 0.6,
      size.width - 12,
      0,
    );
    path.close();

    // Draw border if specified
    if (borderColor != null) {
      final Paint borderPaint =
          Paint()
            ..color = borderColor!
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5;
      canvas.drawPath(path, borderPaint);
    }

    // Fill the tail
    final Paint fillPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! SpeechBubbleTailPainter ||
        oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor;
  }
}