import 'package:core/src/routes/src/route.dart';
import 'package:flutter/material.dart';

/// Manager class for controlling the global voice floating button visibility
class GlobalVoiceButtonManager extends NavigatorObserver {
  static final GlobalVoiceButtonManager _instance =
      GlobalVoiceButtonManager._internal();

  factory GlobalVoiceButtonManager() => _instance;

  GlobalVoiceButtonManager._internal();

  // ValueNotifier to track button visibility
  final ValueNotifier<bool> isButtonVisible = ValueNotifier<bool>(true);

  // Routes where the button should be hidden
  final Set<String> _hiddenRoutes = {
    Routes.voiceIO,
    Routes.login,
    Routes.onboarding,
  };

  // Add a minimum show duration to prevent rapid hiding/showing during navigation
  DateTime? _lastShowTime;
  static const Duration _minimumShowDuration = Duration(milliseconds: 1000);

  // Safety mechanism - when true, button will always stay visible
  bool _forceAlwaysVisible = false;

  /// Add a route where the button should be hidden
  void addHiddenRoute(String route) {
    _hiddenRoutes.add(route);
    _updateVisibility();
  }

  /// Remove a route from hidden routes
  void removeHiddenRoute(String route) {
    _hiddenRoutes.remove(route);
    _updateVisibility();
  }

  String? _currentRoute;

  void _updateVisibility() {
    debugPrint(
      '🤖 _updateVisibility called - Current Route: $_currentRoute, Hidden Routes: $_hiddenRoutes',
    );
    debugPrint('🤖 Force always visible: $_forceAlwaysVisible');

    // SAFETY: If force always visible is enabled, always show
    if (_forceAlwaysVisible) {
      if (!isButtonVisible.value) {
        debugPrint('🤖 Force showing due to _forceAlwaysVisible flag');
        isButtonVisible.value = true;
      }
      return;
    }

    final shouldShow =
        _currentRoute == null || !_hiddenRoutes.contains(_currentRoute);

    debugPrint(
      '🤖 Should show: $shouldShow, Current visibility: ${isButtonVisible.value}',
    );

    // Prevent rapid hiding/showing during navigation
    if (shouldShow && !isButtonVisible.value) {
      _lastShowTime = DateTime.now();
      debugPrint('🤖 Setting last show time: $_lastShowTime');
    }

    // If trying to hide but minimum duration hasn't passed, keep showing
    if (!shouldShow && _lastShowTime != null) {
      final elapsed = DateTime.now().difference(_lastShowTime!);
      if (elapsed < _minimumShowDuration) {
        final remainingMs =
            _minimumShowDuration.inMilliseconds - elapsed.inMilliseconds;
        debugPrint(
          '🤖 Delaying hide for ${remainingMs}ms (elapsed: ${elapsed.inMilliseconds}ms)',
        );
        Future.delayed(_minimumShowDuration - elapsed, () {
          debugPrint(
            '🤖 Delayed hide callback - Current route: $_currentRoute, Hidden routes: $_hiddenRoutes',
          );
          // FIXED: Check the current route state when the delay completes
          final currentShouldShow =
              _currentRoute == null || !_hiddenRoutes.contains(_currentRoute);
          if (currentShouldShow) {
            debugPrint(
              '🤖 Skipping delayed hide - route changed to allowed route',
            );
            return;
          }
          _updateVisibility();
        });
        return;
      }
    }

    if (isButtonVisible.value != shouldShow) {
      debugPrint(
        '🤖 Voice Button Visibility CHANGED: $shouldShow (Route: $_currentRoute, Hidden: $_hiddenRoutes)',
      );
      isButtonVisible.value = shouldShow;
    } else {
      debugPrint('🤖 Voice Button Visibility unchanged: $shouldShow');
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint(
      '🤖 NAVIGATION: didPush - From: ${previousRoute?.settings.name} → To: ${route.settings.name}',
    );
    _currentRoute = route.settings.name;
    _updateVisibility();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint(
      '🤖 NAVIGATION: didPop - From: ${route.settings.name} → To: ${previousRoute?.settings.name}',
    );
    _currentRoute = previousRoute?.settings.name;
    _updateVisibility();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint(
      '🤖 NAVIGATION: didReplace - From: ${oldRoute?.settings.name} → To: ${newRoute?.settings.name}',
    );
    _currentRoute = newRoute?.settings.name;
    _updateVisibility();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint(
      '🤖 NAVIGATION: didRemove - Removed: ${route.settings.name} → Current: ${previousRoute?.settings.name}',
    );
    _currentRoute = previousRoute?.settings.name;
    _updateVisibility();
  }

  /// Force the button to stay visible (useful during data loading)
  void forceVisible() {
    debugPrint('🤖 Force showing voice button');
    isButtonVisible.value = true;
    _lastShowTime = DateTime.now();
  }

  /// Reset visibility to normal state
  void resetVisibility() {
    debugPrint('🤖 Resetting voice button visibility');
    _updateVisibility();
  }

  /// Enable always visible mode (button will never hide)
  void setAlwaysVisible(bool alwaysVisible) {
    debugPrint('🤖 Setting always visible mode: $alwaysVisible');
    _forceAlwaysVisible = alwaysVisible;
    _updateVisibility();
  }

  /// Get current always visible state
  bool get isAlwaysVisible => _forceAlwaysVisible;
}
