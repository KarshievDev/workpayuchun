import 'package:equatable/equatable.dart';
import '../../data/models/chat_message.dart';

enum ChatStatus { initial, loading, loaded, error }

enum VoiceRecordingStatus { idle, recording, processing, completed, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ChatMessage> messages;
  final VoiceRecordingStatus voiceStatus;
  final bool isTypingMode;
  final bool hasPermissions;
  final bool isAIResponding;
  final bool isAutoVoiceMode;
  final bool isAISpeaking;
  final String? errorMessage;
  final String? currentTranscription;

  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.voiceStatus = VoiceRecordingStatus.idle,
    this.isTypingMode = false,
    this.hasPermissions = false,
    this.isAIResponding = false,
    this.isAutoVoiceMode = false,
    this.isAISpeaking = false,
    this.errorMessage,
    this.currentTranscription,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessage>? messages,
    VoiceRecordingStatus? voiceStatus,
    bool? isTypingMode,
    bool? hasPermissions,
    bool? isAIResponding,
    bool? isAutoVoiceMode,
    bool? isAISpeaking,
    String? errorMessage,
    String? currentTranscription,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      voiceStatus: voiceStatus ?? this.voiceStatus,
      isTypingMode: isTypingMode ?? this.isTypingMode,
      hasPermissions: hasPermissions ?? this.hasPermissions,
      isAIResponding: isAIResponding ?? this.isAIResponding,
      isAutoVoiceMode: isAutoVoiceMode ?? this.isAutoVoiceMode,
      isAISpeaking: isAISpeaking ?? this.isAISpeaking,
      errorMessage: errorMessage,
      currentTranscription: currentTranscription,
    );
  }

  @override
  List<Object?> get props => [
    status,
    messages,
    voiceStatus,
    isTypingMode,
    hasPermissions,
    isAIResponding,
    isAutoVoiceMode,
    isAISpeaking,
    errorMessage,
    currentTranscription,
  ];
}
