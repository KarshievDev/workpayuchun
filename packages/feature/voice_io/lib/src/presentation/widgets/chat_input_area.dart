import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_io/voice_io.dart';
import 'voice_transcription_preview.dart';
import 'chat_text_input.dart';
import 'send_button.dart';

/// Composite input area widget containing all input controls
class ChatInputArea extends StatelessWidget {
  const ChatInputArea({
    super.key,
    required this.textController,
    required this.onSendMessage,
  });

  final TextEditingController textController;
  final ValueChanged<String> onSendMessage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE4E6EA), width: 1)),
          ),
          child: Column(
            children: [
              // Auto voice mode toggle
              if (state.hasPermissions) _AutoVoiceModeToggle(state: state),

              // Voice transcription preview
              VoiceTranscriptionPreview(
                transcription: state.currentTranscription ?? '',
              ),

              // Input controls row
              _InputControlsRow(
                textController: textController,
                onSendMessage: onSendMessage,
                state: state,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Input controls row containing voice, text input, and send button
class _InputControlsRow extends StatelessWidget {
  const _InputControlsRow({
    required this.textController,
    required this.onSendMessage,
    required this.state,
  });

  final TextEditingController textController;
  final ValueChanged<String> onSendMessage;
  final ChatState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Voice input widget
        VoiceInputWidget(
          isRecording: state.voiceStatus == VoiceRecordingStatus.recording,
          hasPermission: state.hasPermissions,
          isAutoMode: state.isAutoVoiceMode,
          onStartRecording: () {
            context.read<ChatBloc>().add(const ChatStartVoiceRecordingEvent());
          },
          onStopRecording: () {
            context.read<ChatBloc>().add(const ChatStopVoiceRecordingEvent());
          },
        ),

        const SizedBox(width: 12),

        // Text input
        ChatTextInput(controller: textController, onSubmitted: onSendMessage),

        const SizedBox(width: 12),

        // Send button
        SendButton(onTap: () => onSendMessage(textController.text)),
      ],
    );
  }
}

/// Auto voice mode toggle widget
class _AutoVoiceModeToggle extends StatelessWidget {
  const _AutoVoiceModeToggle({required this.state});

  final ChatState state;

  @override
  Widget build(BuildContext context) {
    if (state.isAISpeaking ||
        state.voiceStatus == VoiceRecordingStatus.recording) {
      return const SizedBox.shrink(); // Hide during active voice interactions
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                state.isAutoVoiceMode ? Icons.mic : Icons.mic_off,
                size: 16,
                color: state.isAutoVoiceMode ? Colors.green : Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                'Auto Voice Mode',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Switch(
            value: state.isAutoVoiceMode,
            onChanged: (_) {
              context.read<ChatBloc>().add(
                const ChatToggleAutoVoiceModeEvent(),
              );
            },
            activeColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
