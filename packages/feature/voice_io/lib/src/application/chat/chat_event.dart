import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatInitializeEvent extends ChatEvent {
  const ChatInitializeEvent();
}

class ChatSendTextMessageEvent extends ChatEvent {
  final String message;
  final bool isFromVoice;

  const ChatSendTextMessageEvent(this.message, {this.isFromVoice = false});

  @override
  List<Object> get props => [message, isFromVoice];
}

class ChatStartVoiceRecordingEvent extends ChatEvent {
  const ChatStartVoiceRecordingEvent();
}

class ChatStopVoiceRecordingEvent extends ChatEvent {
  const ChatStopVoiceRecordingEvent();
}

class ChatVoiceTranscriptionEvent extends ChatEvent {
  final String transcription;
  final bool isFinal;

  const ChatVoiceTranscriptionEvent(this.transcription, {this.isFinal = false});

  @override
  List<Object> get props => [transcription, isFinal];
}

class ChatClearMessagesEvent extends ChatEvent {
  const ChatClearMessagesEvent();
}

class ChatLoadMessagesEvent extends ChatEvent {
  const ChatLoadMessagesEvent();
}

class ChatToggleTypingModeEvent extends ChatEvent {
  const ChatToggleTypingModeEvent();
}

class ChatRequestPermissionsEvent extends ChatEvent {
  const ChatRequestPermissionsEvent();
}

class ChatAutoStartNextVoiceRecordingEvent extends ChatEvent {
  const ChatAutoStartNextVoiceRecordingEvent();
}

class ChatToggleAutoVoiceModeEvent extends ChatEvent {
  const ChatToggleAutoVoiceModeEvent();
}

class ChatUpdateAISpeakingStatusEvent extends ChatEvent {
  final bool isSpeaking;
  
  const ChatUpdateAISpeakingStatusEvent(this.isSpeaking);

  @override
  List<Object> get props => [isSpeaking];
}