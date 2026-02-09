import 'package:hive_flutter/hive_flutter.dart';
import '../models/chat_message.dart';

abstract class ChatRepository {
  Future<void> initializeHive();

  Future<List<ChatMessage>> getAllMessages();

  Future<void> saveMessage(ChatMessage message);

  Future<void> updateMessage(ChatMessage message);

  Future<void> deleteMessage(String messageId);

  Future<void> clearAllMessages();

  Stream<List<ChatMessage>> watchMessages();
}

class ChatRepositoryImpl implements ChatRepository {
  static const String _chatBoxName = 'chat_messages';
  Box<ChatMessage>? _chatBox;

  @override
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    // Register adapters if not already registered
    if (!Hive.isAdapterRegistered(100)) {
      Hive.registerAdapter(ChatMessageAdapter());
    }
    if (!Hive.isAdapterRegistered(101)) {
      Hive.registerAdapter(MessageTypeAdapter());
    }

    // Verify adapters are registered
    assert(Hive.isAdapterRegistered(100), 'ChatMessageAdapter not registered');
    assert(Hive.isAdapterRegistered(101), 'MessageTypeAdapter not registered');

    _chatBox = await Hive.openBox<ChatMessage>(_chatBoxName);
  }

  @override
  Future<List<ChatMessage>> getAllMessages() async {
    if (_chatBox == null) await initializeHive();

    final messages = _chatBox!.values.toList();
    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return messages;
  }

  @override
  Future<void> saveMessage(ChatMessage message) async {
    if (_chatBox == null) await initializeHive();
    await _chatBox!.put(message.id, message);
  }

  @override
  Future<void> updateMessage(ChatMessage message) async {
    if (_chatBox == null) await initializeHive();
    await _chatBox!.put(message.id, message);
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    if (_chatBox == null) await initializeHive();
    await _chatBox!.delete(messageId);
  }

  @override
  Future<void> clearAllMessages() async {
    if (_chatBox == null) await initializeHive();
    await _chatBox!.clear();
  }

  @override
  Stream<List<ChatMessage>> watchMessages() async* {
    if (_chatBox == null) await initializeHive();

    yield* _chatBox!.watch().asyncMap((_) async {
      final messages = _chatBox!.values.toList();
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return messages;
    });
  }
}
