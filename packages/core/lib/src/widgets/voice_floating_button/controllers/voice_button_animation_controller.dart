import 'package:flutter/material.dart';

class VoiceButtonAnimationController {
  late final AnimationController _scaleAnimationController;
  late final AnimationController _pulseAnimationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _pulseAnimation;

  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<double> get pulseAnimation => _pulseAnimation;

  void initialize(TickerProvider vsync) {
    // Scale animation for tap feedback
    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: vsync,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _scaleAnimationController, 
        curve: Curves.easeInOut,
      ),
    );

    // Pulse animation for attention
    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: vsync,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseAnimationController, 
        curve: Curves.easeInOut,
      ),
    );

    // Start subtle pulse animation
    _pulseAnimationController.repeat(reverse: true);
  }

  void dispose() {
    _scaleAnimationController.dispose();
    _pulseAnimationController.dispose();
  }

  Future<void> playTapAnimation() async {
    await _scaleAnimationController.forward();
    await _scaleAnimationController.reverse();
  }

  void startDragAnimation() {
    _scaleAnimationController.forward();
  }

  void endDragAnimation() {
    _scaleAnimationController.reverse();
  }
}