import 'package:flutter/material.dart';

class VoiceInputWidget extends StatefulWidget {
  final bool isRecording;
  final bool hasPermission;
  final bool isAutoMode;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;

  const VoiceInputWidget({
    super.key,
    required this.isRecording,
    required this.hasPermission,
    this.isAutoMode = false,
    required this.onStartRecording,
    required this.onStopRecording,
  });

  @override
  State<VoiceInputWidget> createState() => _VoiceInputWidgetState();
}

class _VoiceInputWidgetState extends State<VoiceInputWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(VoiceInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording != oldWidget.isRecording) {
      if (widget.isRecording) {
        _pulseController.repeat(reverse: true);
        _waveController.repeat();
      } else {
        _pulseController.stop();
        _waveController.stop();
        _pulseController.reset();
        _waveController.reset();
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.hasPermission
          ? (widget.isRecording ? widget.onStopRecording : widget.onStartRecording)
          : null,
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseController, _waveController]),
        builder: (context, child) {
          return Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getBackgroundColor(),
              boxShadow: widget.isRecording
                  ? [
                      BoxShadow(
                        color: const Color(0xFF4267B2).withValues(alpha: 0.3),
                        blurRadius: 20 * _pulseAnimation.value,
                        spreadRadius: 5 * _pulseAnimation.value,
                      ),
                    ]
                  : null,
            ),
            child: Stack(
              children: [
                // Animated waves (only when recording)
                if (widget.isRecording)
                  ...List.generate(3, (index) {
                    return Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _waveAnimation,
                        builder: (context, child) {
                          final delay = index * 0.2;
                          final animationValue = 
                              (_waveAnimation.value + delay) % 1.0;
                          
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(
                                  alpha: (1.0 - animationValue) * 0.5,
                                ),
                                width: 2,
                              ),
                            ),
                            transform: Matrix4.identity()
                              ..scale(1.0 + (animationValue * 0.5)),
                          );
                        },
                      ),
                    );
                  }),
                
                // Center icon
                Center(
                  child: Transform.scale(
                    scale: widget.isRecording ? _pulseAnimation.value : 1.0,
                    child: Icon(
                      _getIcon(),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                // Recording indicator dot
                if (widget.isRecording)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                // Auto mode indicator
                if (widget.isAutoMode && !widget.isRecording)
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Icon(
                        Icons.autorenew,
                        size: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!widget.hasPermission) {
      return Colors.grey.shade400;
    }
    
    if (widget.isRecording) {
      return const Color(0xFF4267B2); // Blue when recording
    }
    
    if (widget.isAutoMode) {
      return const Color(0xFF28A745); // Darker green for auto mode
    }
    
    return const Color(0xFF42B883); // Regular green for manual mode
  }

  IconData _getIcon() {
    if (!widget.hasPermission) {
      return Icons.mic_off;
    }
    return widget.isRecording ? Icons.stop : Icons.mic;
  }
}