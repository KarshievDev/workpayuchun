import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DraggableVoiceButton extends StatelessWidget {
  final double size;
  final EdgeInsets margin;
  final bool isDraggable;
  final bool isDragging;
  final Offset position;
  final Size screenSize;
  final Animation<double> scaleAnimation;
  final Animation<double> pulseAnimation;
  final Function(DragStartDetails) onPanStart;
  final Function(DragUpdateDetails) onPanUpdate;
  final Function(DragEndDetails) onPanEnd;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const DraggableVoiceButton({
    super.key,
    required this.size,
    required this.margin,
    required this.isDraggable,
    required this.isDragging,
    required this.position,
    required this.screenSize,
    required this.scaleAnimation,
    required this.pulseAnimation,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: screenSize.width - margin.right - size + position.dx,
      top: screenSize.height - margin.bottom - size + position.dy,
      child: GestureDetector(
        onPanStart: isDraggable ? onPanStart : null,
        onPanUpdate: isDraggable ? onPanUpdate : null,
        onPanEnd: isDraggable ? onPanEnd : null,
        onTap: onTap,
        onLongPress: onLongPress,
        child: AnimatedBuilder(
          animation: Listenable.merge([scaleAnimation, pulseAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: scaleAnimation.value *
                  (isDragging ? 1.05 : pulseAnimation.value),
              child: SizedBox(
                width: size,
                height: size,
                child: Lottie.asset(
                  'assets/lottie/ai_robot.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}