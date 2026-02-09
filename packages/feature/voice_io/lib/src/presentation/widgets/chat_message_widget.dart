import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:voice_io/src/constants/time_formater.dart';
import '../../data/models/chat_message.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isAnimating;

  const ChatMessageWidget({
    super.key,
    required this.message,
    this.isAnimating = false,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isFromUser;
    final isVoiceMessage = message.type == MessageType.voice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // AI Avatar (only for non-user messages)
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF4267B2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Lottie.asset(
                'assets/lottie/ai_robot.json',
                fit: BoxFit.contain,
                repeat: true,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFF4267B2) : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message type indicator
                  if (isVoiceMessage)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.mic,
                            size: 14,
                            color:
                                isUser ? Colors.white70 : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Voice message',
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  isUser
                                      ? Colors.white70
                                      : Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Message text
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 16,
                      height: 1.3,
                    ),
                    child: MarkdownWidget(data: message.text, shrinkWrap: true),
                    // child: SelectableText(message.text),
                  ),

                  // Timestamp
                  const SizedBox(height: 4),
                  Text(
                    formatTimestamp(message.timestamp),
                    style: TextStyle(
                      fontSize: 11,
                      color: isUser ? Colors.white70 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // User Avatar (only for user messages)
          if (isUser) ...[
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, color: Colors.grey.shade600, size: 16),
            ),
          ],
        ],
      ),
    );
  }
}
