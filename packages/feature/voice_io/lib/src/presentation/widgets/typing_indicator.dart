import 'package:flutter/material.dart';

/// Typing indicator widget shown when AI is responding
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const _AIAvatar(),
          const SizedBox(width: 12),
          _TypingBubble(),
        ],
      ),
    );
  }
}

/// AI avatar for typing indicator
class _AIAvatar extends StatelessWidget {
  const _AIAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 16,
      backgroundColor: Color(0xFF4267B2),
      child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
    );
  }
}

/// Animated typing bubble with dots
class _TypingBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AnimatedDot(index: 0),
          SizedBox(width: 4),
          _AnimatedDot(index: 1),
          SizedBox(width: 4),
          _AnimatedDot(index: 2),
        ],
      ),
    );
  }
}

/// Individual animated dot in typing indicator
class _AnimatedDot extends StatelessWidget {
  const _AnimatedDot({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600 + (index * 200)),
      curve: Curves.easeInOut,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        shape: BoxShape.circle,
      ),
    );
  }
}