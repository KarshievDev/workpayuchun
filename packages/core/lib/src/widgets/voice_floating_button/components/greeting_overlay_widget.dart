import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GreetingOverlayWidget extends StatelessWidget {
  final String greeting;
  final String statusSummary;
  final VoidCallback onClose;

  const GreetingOverlayWidget({
    super.key,
    required this.greeting,
    required this.statusSummary,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      child: GestureDetector(
        onTap: onClose,
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent closing when tapping the dialog
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lottie animation
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Lottie.asset(
                      'assets/lottie/ai_robot.json',
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Greeting message
                  Text(
                    greeting,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),

                  // Status summary
                  Text(
                    statusSummary,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color
                          ?.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Close button
                  ElevatedButton(
                    onPressed: onClose,
                    child: const Text('Thanks!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}