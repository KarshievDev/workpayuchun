import 'dart:async';
import 'package:flutter/material.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';

/// Global floating button widget for voice I/O functionality
/// Similar to Facebook Messenger's floating chat button
class GlobalVoiceFloatingButton extends StatefulWidget {
  /// Callback when the button is pressed
  final VoidCallback onPressed;

  /// Button position offset from right and bottom edges
  final EdgeInsets margin;

  /// Button size
  final double size;

  /// Icon to display
  final IconData icon;

  /// Background color of the button
  final Color? backgroundColor;

  /// Icon color
  final Color? iconColor;

  /// Whether the button should be draggable
  final bool isDraggable;

  /// Whether to show greeting on first app open
  final bool showGreeting;

  /// Optional callback when greeting should be shown
  /// If provided, this will be called instead of showing overlay
  final Function(String greeting, String statusSummary)? onGreeting;

  const GlobalVoiceFloatingButton({
    super.key,
    required this.onPressed,
    this.margin = const EdgeInsets.only(right: 16, bottom: 100),
    this.size = 56,
    this.icon = Icons.mic,
    this.backgroundColor,
    this.iconColor,
    this.isDraggable = true,
    this.showGreeting = false,
    this.onGreeting,
  });

  @override
  State<GlobalVoiceFloatingButton> createState() =>
      _GlobalVoiceFloatingButtonState();
}

class _GlobalVoiceFloatingButtonState extends State<GlobalVoiceFloatingButton>
    with TickerProviderStateMixin {
  final VoiceButtonAnimationController _animationController =
      VoiceButtonAnimationController();
  final VoiceButtonPositionController _positionController =
      VoiceButtonPositionController();

  bool _showGreetingDialog = false;
  bool _showSpeechBubble = false;
  String _currentGreeting = '';
  String _currentStatus = '';

  /// Event bus for listening to home data updates
  EventBus get _eventBus => GetIt.instance.get<EventBus>();
  StreamSubscription<GlobalDataUpdateEvent>? _homeDataSubscription;
  StreamSubscription<VoiceGreetingTriggerEvent>? _greetingTriggerSubscription;

  @override
  void initState() {
    super.initState();

    _animationController.initialize(this);

    // Set up event bus listeners
    _setupEventListeners();

    // Show greeting dialog on first app open if enabled
    if (widget.showGreeting) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _waitForOverlayAndShowGreeting();
      });
    }
  }

  /// Set up event bus listeners
  void _setupEventListeners() {
    debugPrint('🤖 Setting up event bus listeners');

    // Listen for home data updates
    _homeDataSubscription = _eventBus.on<GlobalDataUpdateEvent>().listen((
      event,
    ) {
      debugPrint('🤖 Event bus listener triggered for HomeDataUpdateEvent');
      if (mounted) {
        debugPrint(
          '🤖 Received home data update: ${event.updateType} at ${event.timeStamp}',
        );
        _refreshGreetingIfVisible(event.homeData);
      } else {
        debugPrint('🤖 Widget not mounted, ignoring event');
      }
    });

    // Listen for voice greeting trigger events
    _greetingTriggerSubscription = _eventBus
        .on<VoiceGreetingTriggerEvent>()
        .listen((event) {
          debugPrint(
            '🤖 Event bus listener triggered for VoiceGreetingTriggerEvent',
          );
          if (mounted) {
            debugPrint('🤖 Voice greeting trigger received');
            if (event.customGreeting != null || event.customStatus != null) {
              _showCustomGreeting(event.customGreeting, event.customStatus);
            } else {
              _showGreetingMessage(forceShow: event.forceShow);
            }
          } else {
            debugPrint('🤖 Widget not mounted, ignoring event');
          }
        });

    debugPrint('🤖 Event bus listeners setup complete');
  }

  /// Refresh greeting if currently visible with updated data, or show if needed
  void _refreshGreetingIfVisible(Map<String, dynamic>? updatedData) {
    if (_showGreetingDialog || _showSpeechBubble) {
      /// Generate updated greeting with new data
      final greeting = GreetingService.generateGreeting(userData: updatedData);
      final statusSummary = GreetingService.generateStatusSummary(
        userData: updatedData,
      );

      setState(() {
        _currentGreeting = greeting;
        _currentStatus = statusSummary;
      });
    } else if (widget.showGreeting) {
      /// If showGreeting is enabled but not currently showing, show it with updated data
      _showGreetingMessage();
    }
  }

  /// Show custom greeting message
  void _showCustomGreeting(String? customGreeting, String? customStatus) {
    final greeting =
        customGreeting ??
        GreetingService.generateGreeting(
          userData: GlobalHomeBlocAccessor.instance.getHomeBlocDataAsMap(),
        );

    final statusSummary =
        customStatus ??
        GreetingService.generateStatusSummary(
          userData: GlobalHomeBlocAccessor.instance.getHomeBlocDataAsMap(),
        );

    if (widget.onGreeting != null) {
      widget.onGreeting!(greeting, statusSummary);
    } else {
      _showFallbackGreeting(greeting, statusSummary);
    }
  }

  /// Wait for overlay to be available and show greeting
  void _waitForOverlayAndShowGreeting() async {
    // Wait for overlay to be properly initialized
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      try {
        final overlay = Overlay.maybeOf(context);
        if (overlay != null) {
          debugPrint(
            '🤖 Overlay found, showing greeting after ${(i + 1) * 500}ms',
          );
          _showGreetingMessage();
          return;
        }
      } catch (e) {
        debugPrint('🤖 Overlay check failed: $e');
      }
    }

    // If overlay is still not available after 5 seconds, show fallback
    debugPrint('🤖 Using fallback greeting after 5 seconds');
    if (mounted) {
      _showGreetingMessage();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _homeDataSubscription?.cancel();
    _greetingTriggerSubscription?.cancel();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (!widget.isDraggable) return;
    setState(() {
      _positionController.setDragging(true);
    });
    _animationController.startDragAnimation();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isDraggable) return;
    setState(() {
      _positionController.onPanUpdate(details);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isDraggable) return;
    setState(() {
      _positionController.setDragging(false);
    });
    _animationController.endDragAnimation();

    // Snap to edges if needed
    _snapToEdge();
  }

  void _snapToEdge() {
    final screenSize = MediaQuery.of(context).size;
    final oldPosition = _positionController.position;

    _positionController.snapToEdge(
      screenSize: screenSize,
      margin: widget.margin,
      buttonSize: widget.size,
    );

    if (_positionController.position != oldPosition) {
      setState(() {});
    }
  }

  /// Show greeting message as a simple callback
  void _showGreetingMessage({bool forceShow = false}) {
    if (_showGreetingDialog && !forceShow) return;

    /// Get HomeBloc data if available
    final homeBlocData = GlobalHomeBlocAccessor.instance.getHomeBlocDataAsMap();

    final greeting = GreetingService.generateGreeting(userData: homeBlocData);

    final statusSummary = GreetingService.generateStatusSummary(
      userData: homeBlocData,
    );

    setState(() {
      _showGreetingDialog = true;
    });

    // Check if callback is provided first
    if (widget.onGreeting != null) {
      widget.onGreeting!(greeting, statusSummary);
      setState(() {
        _showGreetingDialog = false;
      });
      return;
    }

    // Try to find an overlay, if not available, use fallback
    try {
      final overlay = Overlay.maybeOf(context);
      if (overlay != null) {
        _showOverlayGreeting(greeting, statusSummary);
      } else {
        _showFallbackGreeting(greeting, statusSummary);
      }
    } catch (e) {
      // Fallback to simple debug print or callback
      _showFallbackGreeting(greeting, statusSummary);
    }
  }

  /// Show greeting using overlay when available
  void _showOverlayGreeting(String greeting, String statusSummary) {
    late OverlayEntry overlayEntry;

    void closeOverlay() {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
      if (mounted) {
        setState(() {
          _showGreetingDialog = false;
        });
      }
    }

    overlayEntry = OverlayEntry(
      builder:
          (context) => GreetingOverlayWidget(
            greeting: greeting,
            statusSummary: statusSummary,
            onClose: closeOverlay,
          ),
    );

    // Insert the overlay
    Overlay.of(context).insert(overlayEntry);

    // Auto-dismiss after 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
      if (_showGreetingDialog && overlayEntry.mounted) {
        closeOverlay();
      }
    });
  }

  /// Fallback greeting when overlay is not available - show as speech bubble
  void _showFallbackGreeting(String greeting, String statusSummary) {
    debugPrint('🤖 Showing fallback greeting as speech bubble');
    debugPrint('🤖 Setting button manager to always visible during greeting');

    // Ensure button stays visible during greeting
    GlobalVoiceButtonManager().setAlwaysVisible(true);

    setState(() {
      _currentGreeting = greeting;
      _currentStatus = statusSummary;
      _showSpeechBubble = true;
    });

    // Auto-hide speech bubble after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        debugPrint('🤖 Auto-hiding speech bubble after 5 seconds');
        GlobalVoiceButtonManager().setAlwaysVisible(
          false,
        ); // Reset normal visibility
        setState(() {
          _showSpeechBubble = false;
          _showGreetingDialog = false;
        });
      }
    });
  }

  /// Build speech bubble widget with safe positioning
  Widget _buildSpeechBubble(Size screenSize) {
    return SpeechBubbleWidget(
      isVisible: _showSpeechBubble,
      greeting: _currentGreeting,
      status: _currentStatus,
      buttonPosition: _positionController.position,
      buttonSize: Size(widget.size, widget.size),
      screenSize: screenSize,
      buttonMargin: widget.margin,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Speech bubble
        _buildSpeechBubble(screenSize),

        // Floating button
        DraggableVoiceButton(
          size: widget.size,
          margin: widget.margin,
          isDraggable: widget.isDraggable,
          isDragging: _positionController.isDragging,
          position: _positionController.position,
          screenSize: screenSize,
          scaleAnimation: _animationController.scaleAnimation,
          pulseAnimation: _animationController.pulseAnimation,
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          onTap: () {
            if (!_positionController.isDragging) {
              // Hide speech bubble if showing
              if (_showSpeechBubble) {
                setState(() {
                  _showSpeechBubble = false;
                });
              }
              _animationController.playTapAnimation();
              widget.onPressed();
            }
          },
          onLongPress: () {
            if (!_positionController.isDragging) {
              GlobalHomeBlocAccessor.instance.triggerHomeDataUpdate();
            }
          },
        ),
      ],
    );
  }
}

/// Overlay widget that manages the global floating button (deprecated - use Stack approach instead)
@Deprecated('Use GlobalVoiceFloatingButton directly in Stack instead')
class GlobalVoiceFloatingButtonOverlay {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  /// Show the global floating button
  static void show(
    BuildContext context, {
    required VoidCallback onPressed,
    EdgeInsets margin = const EdgeInsets.only(right: 16, bottom: 100),
    double size = 56,
    IconData icon = Icons.mic,
    Color? backgroundColor,
    Color? iconColor,
    bool isDraggable = true,
    Map<String, dynamic>? userData,
    bool showGreeting = false,
    Function(String greeting, String statusSummary)? onGreeting,
  }) {
    if (_isVisible) return;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => GlobalVoiceFloatingButton(
            onPressed: onPressed,
            margin: margin,
            size: size,
            icon: icon,
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            isDraggable: isDraggable,
            showGreeting: showGreeting,
            onGreeting: onGreeting,
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;
  }

  /// Hide the global floating button
  static void hide() {
    if (!_isVisible || _overlayEntry == null) return;

    _overlayEntry!.remove();
    _overlayEntry = null;
    _isVisible = false;
  }

  /// Check if the button is currently visible
  static bool get isVisible => _isVisible;
}
