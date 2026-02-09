import 'package:flutter/material.dart';

/// Text input field for typing chat messages
class ChatTextInput extends StatelessWidget {
  const ChatTextInput({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Type a message...',
            hintStyle: TextStyle(color: Colors.black54),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          maxLines: 4,
          minLines: 1,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}