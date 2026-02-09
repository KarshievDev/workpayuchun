import 'package:hive/hive.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 100)
class ChatMessage extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final bool isFromUser;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final MessageType type;

  @HiveField(5)
  final bool isProcessing;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromUser,
    required this.timestamp,
    this.type = MessageType.text,
    this.isProcessing = false,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    bool? isFromUser,
    DateTime? timestamp,
    MessageType? type,
    bool? isProcessing,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      isFromUser: isFromUser ?? this.isFromUser,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

@HiveType(typeId: 101)
enum MessageType {
  @HiveField(0)
  text,
  @HiveField(1)
  voice,
  @HiveField(2)
  aiResponse,
}
