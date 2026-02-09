import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_io/voice_io.dart';

/// Banner widget to request microphone permissions
class PermissionsBanner extends StatelessWidget {
  const PermissionsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.orange.shade100,
      child: Row(
        children: [
          const Icon(Icons.mic_off, color: Colors.orange),
          const SizedBox(width: 12),
          const Expanded(
            child: _PermissionText(),
          ),
          _EnableButton(),
        ],
      ),
    );
  }
}

/// Permission request text content
class _PermissionText extends StatelessWidget {
  const _PermissionText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Microphone Access Required',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
        ),
        Text(
          'Enable microphone access to use voice messages',
          style: TextStyle(
            fontSize: 12,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

/// Enable permissions button
class _EnableButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<ChatBloc>().add(
          const ChatRequestPermissionsEvent(),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      child: const Text('Enable'),
    );
  }
}