import 'package:flutter/material.dart';

class VoiceButtonPositionController {
  Offset _position = Offset.zero;
  bool _isDragging = false;

  Offset get position => _position;
  bool get isDragging => _isDragging;

  void updatePosition(Offset newPosition) {
    _position = newPosition;
  }

  void setDragging(bool isDragging) {
    _isDragging = isDragging;
  }

  void onPanUpdate(DragUpdateDetails details) {
    _position = Offset(
      _position.dx + details.delta.dx,
      _position.dy + details.delta.dy,
    );
  }

  void snapToEdge({
    required Size screenSize,
    required EdgeInsets margin,
    required double buttonSize,
  }) {
    // Get current position considering the button center
    final currentX = _position.dx;
    final currentY = _position.dy;

    // Calculate the button's actual screen position
    final buttonLeft = screenSize.width - margin.right - buttonSize + currentX;
    final buttonTop = screenSize.height - margin.bottom - buttonSize + currentY;

    // Constrain to screen bounds
    double newX = currentX;
    double newY = currentY;

    // Horizontal constraints - prevent button from going outside screen
    if (buttonLeft < 0) {
      // Button is going off the left edge
      newX = -(screenSize.width - margin.right - buttonSize);
    } else if (buttonLeft + buttonSize > screenSize.width) {
      // Button is going off the right edge
      newX = screenSize.width - (screenSize.width - margin.right);
    }

    // Vertical constraints - prevent button from going outside screen
    if (buttonTop < 0) {
      // Button is going off the top edge
      newY = -(screenSize.height - margin.bottom - buttonSize);
    } else if (buttonTop + buttonSize > screenSize.height) {
      // Button is going off the bottom edge
      newY = 0;
    }

    // Update position if constraints were applied
    if (newX != currentX || newY != currentY) {
      _position = Offset(newX, newY);
    }
  }
}