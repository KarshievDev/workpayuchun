import 'package:flutter/material.dart';

/// Widget to preview voice transcription text
class VoiceTranscriptionPreview extends StatelessWidget {
  const VoiceTranscriptionPreview({
    super.key,
    required this.transcription,
  });

  final String transcription;

  @override
  Widget build(BuildContext context) {
    if (transcription.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.mic, color: Colors.blue.shade600, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              transcription,
              style: TextStyle(
                color: Colors.blue.shade800,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          // Small indicator for auto-send
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.send, size: 10, color: Colors.green.shade700),
                const SizedBox(width: 2),
                Text(
                  'Auto',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}