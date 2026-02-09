import 'package:flutter/material.dart';

/// Data model for HR prompt suggestions
class HRPromptSuggestion {
  final String title;
  final String description;
  final String prompt;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const HRPromptSuggestion({
    required this.title,
    required this.description,
    required this.prompt,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });
}

/// Widget displaying HR-specific prompt suggestions for users
class HRPromptSuggestions extends StatelessWidget {
  final void Function(String) onPromptSelected;

  const HRPromptSuggestions({super.key, required this.onPromptSelected});

  static const List<HRPromptSuggestion> _suggestions = [
    HRPromptSuggestion(
      title: 'Leave Balance',
      description: 'Check remaining days',
      prompt: 'Show my current leave balance and remaining vacation days',
      icon: Icons.calendar_today_outlined,
      color: Color(0xFF4CAF50),
      backgroundColor: Color(0xFFE8F5E8),
    ),
    HRPromptSuggestion(
      title: 'Attendance Summary',
      description: 'This month\'s overview',
      prompt:
          'Give me my attendance summary for this month including total hours worked',
      icon: Icons.access_time_outlined,
      color: Color(0xFF2196F3),
      backgroundColor: Color(0xFFE3F2FD),
    ),
    HRPromptSuggestion(
      title: 'Pending Requests',
      description: 'Check approval status',
      prompt: 'Show all my pending leave requests and their approval status',
      icon: Icons.pending_actions_outlined,
      color: Color(0xFFFF9800),
      backgroundColor: Color(0xFFFFF3E0),
    ),
    HRPromptSuggestion(
      title: 'Upcoming Events',
      description: 'Meetings & holidays',
      prompt:
          'What are my upcoming meetings, appointments, and company holidays this month?',
      icon: Icons.event_outlined,
      color: Color(0xFF9C27B0),
      backgroundColor: Color(0xFFF3E5F5),
    ),
    HRPromptSuggestion(
      title: 'Monthly Report',
      description: 'Performance overview',
      prompt:
          'Generate my monthly performance summary including attendance, completed tasks, and achievements',
      icon: Icons.analytics_outlined,
      color: Color(0xFF607D8B),
      backgroundColor: Color(0xFFECEFF1),
    ),
    HRPromptSuggestion(
      title: 'Team Updates',
      description: 'Department news',
      prompt:
          'Show me recent announcements, team updates, and important HR notifications',
      icon: Icons.group_outlined,
      color: Color(0xFFE91E63),
      backgroundColor: Color(0xFFFCE4EC),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SuggestionsHeader(),
          const SizedBox(height: 16),
          _SuggestionsGrid(
            suggestions: _suggestions,
            onPromptSelected: onPromptSelected,
          ),
        ],
      ),
    );
  }
}

/// Header section for suggestions
class _SuggestionsHeader extends StatelessWidget {
  const _SuggestionsHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tap any suggestion to start a conversation',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}

/// Grid layout for suggestion cards
class _SuggestionsGrid extends StatelessWidget {
  final List<HRPromptSuggestion> suggestions;
  final void Function(String) onPromptSelected;

  const _SuggestionsGrid({
    required this.suggestions,
    required this.onPromptSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return _PromptSuggestionCard(
          suggestion: suggestions[index],
          onTap: () => onPromptSelected(suggestions[index].prompt),
        );
      },
    );
  }
}

/// Individual suggestion card widget
class _PromptSuggestionCard extends StatefulWidget {
  final HRPromptSuggestion suggestion;
  final VoidCallback onTap;

  const _PromptSuggestionCard({required this.suggestion, required this.onTap});

  @override
  State<_PromptSuggestionCard> createState() => _PromptSuggestionCardState();
}

class _PromptSuggestionCardState extends State<_PromptSuggestionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: widget.suggestion.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.suggestion.color.withValues(alpha: 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardIcon(
                      icon: widget.suggestion.icon,
                      color: widget.suggestion.color,
                    ),
                    const SizedBox(height: 12),
                    _CardTitle(title: widget.suggestion.title),
                    const SizedBox(height: 4),
                    _CardDescription(
                      description: widget.suggestion.description,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Icon section of the card
class _CardIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _CardIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }
}

/// Title section of the card
class _CardTitle extends StatelessWidget {
  final String title;

  const _CardTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Description section of the card
class _CardDescription extends StatelessWidget {
  final String description;

  const _CardDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(fontSize: 12, color: Colors.black54),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
