import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../painters/speech_bubble_tail_painter.dart';

class SpeechBubbleWidget extends StatelessWidget {
  final bool isVisible;
  final String greeting;
  final String status;
  final Offset buttonPosition;
  final Size buttonSize;
  final Size screenSize;
  final EdgeInsets buttonMargin;

  const SpeechBubbleWidget({
    super.key,
    required this.isVisible,
    required this.greeting,
    required this.status,
    required this.buttonPosition,
    required this.buttonSize,
    required this.screenSize,
    required this.buttonMargin,
  });

  @override
  Widget build(BuildContext context) {
    try {
      // Get button's actual screen position
      final buttonLeft =
          screenSize.width - buttonMargin.right - buttonSize.width + buttonPosition.dx;
      final buttonTop =
          screenSize.height - buttonMargin.bottom - buttonSize.height + buttonPosition.dy;
      final buttonRight = buttonLeft + buttonSize.width;
      final buttonBottom = buttonTop + buttonSize.height;
      
      // Speech bubble dimensions - make them adaptive
      final bubbleMaxWidth = (screenSize.width * 0.8).clamp(200.0, 300.0);
      const bubbleMinHeight = 120.0;
      const bubbleMaxHeight = 220.0;

      // Safe margins from screen edges
      const safeMargin = 16.0;
      const minTopMargin = 50.0; // For status bar

      // Calculate preferred position (above and to the left of button)
      var bubbleLeft =
          buttonLeft - bubbleMaxWidth + 20; // Offset to align with button
      var bubbleTop = buttonTop - bubbleMinHeight - 20; // Gap above button

      // Horizontal bounds checking
      if (bubbleLeft < safeMargin) {
        bubbleLeft = safeMargin;
      } else if (bubbleLeft + bubbleMaxWidth > screenSize.width - safeMargin) {
        bubbleLeft = screenSize.width - bubbleMaxWidth - safeMargin;
      }

      // Vertical bounds checking - prioritize showing above button
      if (bubbleTop < minTopMargin) {
        // Not enough space above, show below button
        bubbleTop = buttonBottom + 10;

        // Check if there's enough space below
        if (bubbleTop + bubbleMinHeight > screenSize.height - safeMargin) {
          // Not enough space below either, show beside button
          bubbleTop = buttonTop;
          if (buttonLeft > screenSize.width / 2) {
            // Button is on right side, show bubble on left
            bubbleLeft = buttonLeft - bubbleMaxWidth - 10;
          } else {
            // Button is on left side, show bubble on right
            bubbleLeft = buttonRight + 10;
          }

          // Final safety check for horizontal positioning
          if (bubbleLeft < safeMargin) {
            bubbleLeft = safeMargin;
          } else if (bubbleLeft + bubbleMaxWidth >
              screenSize.width - safeMargin) {
            bubbleLeft = screenSize.width - bubbleMaxWidth - safeMargin;
          }
        }
      }

      // Final safety clamps to absolutely ensure we stay within bounds
      bubbleLeft = bubbleLeft.clamp(
        safeMargin,
        screenSize.width - bubbleMaxWidth - safeMargin,
      );
      bubbleTop = bubbleTop.clamp(
        minTopMargin,
        screenSize.height - bubbleMinHeight - safeMargin,
      );

      return Positioned(
        left: bubbleLeft,
        top: bubbleTop,
        child: AnimatedScale(
          scale: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.elasticOut,
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: bubbleMaxWidth,
                minWidth: 200,
                maxHeight: bubbleMaxHeight,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.95),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AI Header with icon
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: Lottie.asset(
                            'assets/lottie/ai_robot.json',
                            fit: BoxFit.contain,
                            repeat: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AI Assistant',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  // Greeting message with enhanced styling
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          color: Theme.of(context).colorScheme.onSurface,
                        ) ??
                        const TextStyle(),
                    child: Text(greeting),
                  ),

                  if (status.isNotEmpty) ...[
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ) ??
                            const TextStyle(),
                        child: Text(status),
                      ),
                    ),
                  ],

                  const SizedBox(height: 4),

                  // Speech bubble tail with enhanced design
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomPaint(
                      size: const Size(20, 10),
                      painter: SpeechBubbleTailPainter(
                        color: Theme.of(context).colorScheme.surface,
                        borderColor: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      return const SizedBox.shrink();
    }
  }
}