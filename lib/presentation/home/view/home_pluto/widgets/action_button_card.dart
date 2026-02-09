import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:core/core.dart';

class ActionButtonCard extends StatefulWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Size imageSize;
  final bool isCheckedIn;

  const ActionButtonCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isCheckedIn,
    this.imageSize = const Size(45.0, 45.0),
  });

  @override
  State<ActionButtonCard> createState() => _ActionButtonCardState();
}

class _ActionButtonCardState extends State<ActionButtonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onTap();
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final scale = _pressed ? 0.96 : 1.0;
    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 120),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _handleTap,
              onHighlightChanged: (v) => setState(() => _pressed = v),
              borderRadius: BorderRadius.circular(16),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:
                        widget.isCheckedIn
                            ? [
                              Branding.colors.iconAccent.withAlpha(200),
                              Branding.colors.iconAccent.withAlpha(70),
                            ]
                            : [
                              Branding.colors.primaryDark.withAlpha(200),
                              Branding.colors.primaryLight.withAlpha(70),
                            ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withAlpha(100)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.subtitle,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox.fromSize(
                          size: widget.imageSize,
                          child: Center(child: widget.icon),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: FadeTransition(
                          opacity: _controller,
                          child: Lottie.asset(
                            'assets/images/thumb_up.json',
                            controller: _controller,
                            fit: BoxFit.cover,
                            onLoaded: (composition) {
                              _controller.duration = composition.duration;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
