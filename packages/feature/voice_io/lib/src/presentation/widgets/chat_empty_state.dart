import 'package:flutter/material.dart';
import 'hr_prompt_suggestions.dart';

/// Empty state widget displayed when no chat messages exist
class ChatEmptyState extends StatelessWidget {
  final ValueChanged<String>? onPromptSelected;

  const ChatEmptyState({
    super.key,
    this.onPromptSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _EmptyStateHeader(),
          const SizedBox(height: 32),
          if (onPromptSelected != null)
            HRPromptSuggestions(
              onPromptSelected: onPromptSelected!,
            ),
        ],
      ),
    );
  }
}

/// Header section with icon, title and sub-title
class _EmptyStateHeader extends StatelessWidget {
  const _EmptyStateHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _EmptyStateIcon(),
        SizedBox(height: 24),
        _EmptyStateTitle(),
        SizedBox(height: 8),
        _EmptyStateSubtitle(),
      ],
    );
  }
}

/// Icon for empty state
class _EmptyStateIcon extends StatelessWidget {
  const _EmptyStateIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF4267B2),
      ),
      child: const Icon(
        Icons.chat_bubble_outline,
        size: 48,
        color: Colors.white,
      ),
    );
  }
}

/// Title text for empty state
class _EmptyStateTitle extends StatelessWidget {
  const _EmptyStateTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Start a conversation',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

/// Subtitle text for empty state
class _EmptyStateSubtitle extends StatelessWidget {
  const _EmptyStateSubtitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Send a message or use voice to chat with AI',
      style: TextStyle(fontSize: 14, color: Colors.black54),
      textAlign: TextAlign.center,
    );
  }
}