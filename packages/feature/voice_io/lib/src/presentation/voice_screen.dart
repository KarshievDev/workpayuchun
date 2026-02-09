import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../application/chat/chat_bloc.dart';
import '../application/chat/chat_event.dart';
import '../application/chat/chat_state.dart';
import '../data/repositories/chat_repository.dart';
import '../data/services/gemini_ai_service.dart';
import '../data/services/ai_service.dart';
import '../data/tts_service_impl.dart';
import 'widgets/chat_message_widget.dart';
import 'widgets/voice_app_bar.dart';
import 'widgets/permissions_banner.dart';
import 'widgets/chat_empty_state.dart';
import 'widgets/typing_indicator.dart';
import 'widgets/chat_input_area.dart';

/// Factory typedef for VoiceScreen
typedef VoiceScreenFactory = Widget Function();

/// AI Chat with Voice I/O screen
class VoiceScreen extends StatelessWidget {
  const VoiceScreen({super.key});

  /// Factory method for creating VoiceScreen with proper DI
  static Widget factory() {
    return BlocProvider<ChatBloc>(
      create: (context) {
        final chatRepository = ChatRepositoryImpl();
        final aiService = GeminiAIService();
        final speechToText = SpeechToText();
        final ttsService = TTSServiceImpl();

        return ChatBloc(
          chatRepository,
          aiService as AIService,
          speechToText,
          ttsService,
        )..add(const ChatInitializeEvent());
      },
      child: const VoiceScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      appBar: VoiceAppBar(),
      body: ChatView(),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Track previous AI responding state to detect when AI finishes
  bool _wasAIResponding = false;

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        // Auto-scroll to bottom when new messages arrive
        if (state.messages.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        }

        // Clear text field when AI finishes responding
        if (_wasAIResponding && !state.isAIResponding) {
          _textController.clear();
        }

        // Update tracking variable
        _wasAIResponding = state.isAIResponding;

        // Auto-populate text field with voice transcription (only if not manually typing)
        if (state.currentTranscription != null &&
            state.voiceStatus == VoiceRecordingStatus.recording &&
            _textController.text != state.currentTranscription) {
          _textController.text = state.currentTranscription!;
        }

        // Clear text field when voice transcription is cleared (voice message was sent)
        if (state.currentTranscription == null &&
            state.voiceStatus == VoiceRecordingStatus.idle &&
            _textController.text.isNotEmpty &&
            !state.isAIResponding) {
          // Only clear if the text matches what was transcribed (to avoid clearing manual input)
          _textController.clear();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            // Permission request banner
            if (!state.hasPermissions) const PermissionsBanner(),

            // Chat messages
            Expanded(
              child:
                  state.status == ChatStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : state.messages.isEmpty
                      ? ChatEmptyState(onPromptSelected: _sendMessage)
                      : _buildMessagesList(state),
            ),

            // Input area
            ChatInputArea(
              textController: _textController,
              onSendMessage: _sendMessage,
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessagesList(ChatState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      itemCount: state.messages.length + (state.isAIResponding ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.messages.length && state.isAIResponding) {
          return const TypingIndicator();
        }

        final message = state.messages[index];
        return ChatMessageWidget(message: message, isAnimating: false);
      },
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      context.read<ChatBloc>().add(
        ChatSendTextMessageEvent(text.trim(), isFromVoice: false),
      );
      _textController.clear();
    }
  }
}
