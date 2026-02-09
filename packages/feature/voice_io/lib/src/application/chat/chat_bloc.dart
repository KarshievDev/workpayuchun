import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/models/chat_message.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/services/ai_service.dart';
import '../../data/services/gemini_ai_service.dart';
import '../../domain/tts_service.dart';
import 'chat_event.dart';
import 'chat_state.dart';

typedef ChatBlocFactory = ChatBloc Function();

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  final AIService _aiService;
  final SpeechToText _speechToText;
  final TTSService _ttsService;
  StreamSubscription<List<ChatMessage>>? _messagesSubscription;

  ChatBloc(
    this._chatRepository,
    this._aiService,
    this._speechToText,
    this._ttsService,
  ) : super(const ChatState()) {
    on<ChatInitializeEvent>(_onInitialize);
    on<ChatSendTextMessageEvent>(_onSendTextMessage);
    on<ChatStartVoiceRecordingEvent>(_onStartVoiceRecording);
    on<ChatStopVoiceRecordingEvent>(_onStopVoiceRecording);
    on<ChatVoiceTranscriptionEvent>(_onVoiceTranscription);
    on<ChatClearMessagesEvent>(_onClearMessages);
    on<ChatLoadMessagesEvent>(_onLoadMessages);
    on<ChatToggleTypingModeEvent>(_onToggleTypingMode);
    on<ChatRequestPermissionsEvent>(_onRequestPermissions);
    on<ChatAutoStartNextVoiceRecordingEvent>(_onAutoStartNextVoiceRecording);
    on<ChatToggleAutoVoiceModeEvent>(_onToggleAutoVoiceMode);
    on<ChatUpdateAISpeakingStatusEvent>(_onUpdateAISpeakingStatus);
  }

  Future<void> _onInitialize(
    ChatInitializeEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ChatStatus.loading));
      
      await _chatRepository.initializeHive();
      
      final hasPermission = await _checkMicrophonePermission();
      
      if (hasPermission) {
        await _speechToText.initialize();
      }
      
      // Initialize TTS service
      await _ttsService.initialize();

      // Initialize AI service if it's GeminiAIService
      if (_aiService is GeminiAIService) {
        await _aiService.initialize();
      }

      _messagesSubscription = _chatRepository.watchMessages().listen(
        (messages) {
          add(const ChatLoadMessagesEvent());
        },
      );

      final messages = await _chatRepository.getAllMessages();
      
      emit(state.copyWith(
        status: ChatStatus.loaded,
        messages: messages,
        hasPermissions: hasPermission,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChatStatus.error,
        errorMessage: 'Failed to initialize chat: $e',
      ));
    }
  }

  Future<void> _onSendTextMessage(
    ChatSendTextMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (event.message.trim().isEmpty) return;

    try {
      final userMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: event.message,
        isFromUser: true,
        timestamp: DateTime.now(),
        type: event.isFromVoice ? MessageType.voice : MessageType.text,
      );

      await _chatRepository.saveMessage(userMessage);

      // Update messages list immediately to show user message
      final updatedUserMessages = await _chatRepository.getAllMessages();
      emit(state.copyWith(
        messages: updatedUserMessages,
        isAIResponding: true,
      ));

      final aiResponse = await _aiService.generateResponse(event.message);
      
      final aiMessage = ChatMessage(
        id: '${DateTime.now().millisecondsSinceEpoch}_ai',
        text: aiResponse,
        isFromUser: false,
        timestamp: DateTime.now(),
        type: MessageType.aiResponse,
      );

      await _chatRepository.saveMessage(aiMessage);

      final updatedMessages = await _chatRepository.getAllMessages();
      
      emit(state.copyWith(
        messages: updatedMessages,
        isAIResponding: false,
      ));

      // Speak the AI response
      await _speakAIResponse(aiResponse);
    } catch (e) {
      emit(state.copyWith(
        isAIResponding: false,
        errorMessage: 'Failed to send message: $e',
      ));
    }
  }

  Future<void> _speakAIResponse(String text) async {
    try {
      if (text.isNotEmpty && _ttsService.isAvailable) {
        add(const ChatUpdateAISpeakingStatusEvent(true));
        
        await _ttsService.speak(
          text,
          onStart: () {
            // TTS started
          },
          onComplete: () {
            add(const ChatUpdateAISpeakingStatusEvent(false));
            
            // Always try to auto-start - let the handler decide
            add(const ChatAutoStartNextVoiceRecordingEvent());
          },
          onError: (error) {
            add(const ChatUpdateAISpeakingStatusEvent(false));
            log('TTS Error: $error');
            
            // Try to auto-start even if TTS failed
            add(const ChatAutoStartNextVoiceRecordingEvent());
          },
        );
      } else {
        // If TTS is not available, try to auto-start immediately
        add(const ChatAutoStartNextVoiceRecordingEvent());
      }
    } catch (e) {
      add(const ChatUpdateAISpeakingStatusEvent(false));
      log('Failed to speak AI response: $e');
      
      // Try to auto-start even if there was an exception
      add(const ChatAutoStartNextVoiceRecordingEvent());
    }
  }

  Future<void> _onStartVoiceRecording(
    ChatStartVoiceRecordingEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (!state.hasPermissions) {
      emit(state.copyWith(
        errorMessage: 'Microphone permission required for voice recording',
      ));
      return;
    }

    try {
      emit(state.copyWith(voiceStatus: VoiceRecordingStatus.recording));

      final available = await _speechToText.initialize();
      if (!available) {
        emit(state.copyWith(
          voiceStatus: VoiceRecordingStatus.error,
          errorMessage: 'Speech recognition not available',
        ));
        return;
      }

      await _speechToText.listen(
        onResult: (result) {
          add(ChatVoiceTranscriptionEvent(
            result.recognizedWords,
            isFinal: result.finalResult,
          ));
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: Duration(seconds: state.isAutoVoiceMode ? 1 : 3),
        listenOptions: SpeechListenOptions(
          partialResults: true,
          cancelOnError: false,
          listenMode: ListenMode.confirmation,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        voiceStatus: VoiceRecordingStatus.error,
        errorMessage: 'Failed to start voice recording: $e',
      ));
    }
  }

  Future<void> _onStopVoiceRecording(
    ChatStopVoiceRecordingEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _speechToText.stop();
      
      // Wait a moment for any final transcription
      await Future<void>.delayed(const Duration(milliseconds: 500));
      
      // If we still have a transcription that wasn't sent automatically, send it now
      if (state.currentTranscription != null && 
          state.currentTranscription!.trim().isNotEmpty) {
        add(ChatSendTextMessageEvent(state.currentTranscription!.trim(), isFromVoice: true));
      }
      
      emit(state.copyWith(
        voiceStatus: VoiceRecordingStatus.idle,
        currentTranscription: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        voiceStatus: VoiceRecordingStatus.error,
        errorMessage: 'Failed to stop voice recording: $e',
      ));
    }
  }

  Future<void> _onVoiceTranscription(
    ChatVoiceTranscriptionEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(
      currentTranscription: event.transcription,
    ));
    
    // If this is a final transcription and we have content, send immediately
    if (event.isFinal && event.transcription.trim().isNotEmpty) {
      // Stop recording first
      await _speechToText.stop();
      emit(state.copyWith(voiceStatus: VoiceRecordingStatus.processing));
      
      // Send the message immediately
      add(ChatSendTextMessageEvent(event.transcription.trim(), isFromVoice: true));
      
      // Reset voice status and clear transcription
      emit(state.copyWith(
        voiceStatus: VoiceRecordingStatus.idle,
        currentTranscription: null,
      ));
    }
  }

  Future<void> _onClearMessages(
    ChatClearMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatRepository.clearAllMessages();
      emit(state.copyWith(messages: []));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to clear messages: $e',
      ));
    }
  }

  Future<void> _onLoadMessages(
    ChatLoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final messages = await _chatRepository.getAllMessages();
      emit(state.copyWith(messages: messages));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to load messages: $e',
      ));
    }
  }

  Future<void> _onToggleTypingMode(
    ChatToggleTypingModeEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isTypingMode: !state.isTypingMode));
  }

  Future<void> _onRequestPermissions(
    ChatRequestPermissionsEvent event,
    Emitter<ChatState> emit,
  ) async {
    final hasPermission = await _requestMicrophonePermission();
    emit(state.copyWith(hasPermissions: hasPermission));
    
    if (hasPermission) {
      await _speechToText.initialize();
    }
  }

  Future<void> _onAutoStartNextVoiceRecording(
    ChatAutoStartNextVoiceRecordingEvent event,
    Emitter<ChatState> emit,
  ) async {
    // Only start if in auto voice mode, has permissions, not currently recording
    if (!state.isAutoVoiceMode || 
        !state.hasPermissions || 
        state.voiceStatus == VoiceRecordingStatus.recording ||
        state.voiceStatus == VoiceRecordingStatus.processing ||
        state.isAISpeaking) {
      return;
    }

    // Small delay to ensure smooth transition
    await Future<void>.delayed(const Duration(milliseconds: 500));
    
    // Start recording automatically for next voice input
    add(const ChatStartVoiceRecordingEvent());
  }

  Future<void> _onToggleAutoVoiceMode(
    ChatToggleAutoVoiceModeEvent event,
    Emitter<ChatState> emit,
  ) async {
    final newAutoVoiceMode = !state.isAutoVoiceMode;
    emit(state.copyWith(isAutoVoiceMode: newAutoVoiceMode));
    
    // If enabling auto voice mode and ready, start first recording
    if (newAutoVoiceMode && 
        state.hasPermissions && 
        state.voiceStatus == VoiceRecordingStatus.idle &&
        !state.isAISpeaking) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      add(const ChatStartVoiceRecordingEvent());
    }
  }

  Future<void> _onUpdateAISpeakingStatus(
    ChatUpdateAISpeakingStatusEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isAISpeaking: event.isSpeaking));
  }

  Future<bool> _checkMicrophonePermission() async {
    final status = await Permission.microphone.status;
    return status == PermissionStatus.granted;
  }

  Future<bool> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}