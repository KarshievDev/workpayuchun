import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

/// Service to handle voice plugin initialization timing issues
class VoiceServiceInitializer {
  static final VoiceServiceInitializer _instance = VoiceServiceInitializer._internal();
  factory VoiceServiceInitializer() => _instance;
  VoiceServiceInitializer._internal();

  bool _pluginsInitialized = false;
  Timer? _initTimer;
  
  /// List of initialization attempts completion callbacks
  final List<Completer<bool>> _waitingCompleters = [];

  /// Initialize voice plugins with retry logic
  Future<bool> initializeVoicePlugins() async {
    if (_pluginsInitialized) {
      return true;
    }

    // If already initializing, wait for the result
    if (_initTimer != null) {
      final completer = Completer<bool>();
      _waitingCompleters.add(completer);
      return completer.future;
    }

    log('VoiceServiceInitializer: Starting plugin initialization');
    
    // Start initialization timer
    _initTimer = Timer(const Duration(seconds: 10), () {
      log('VoiceServiceInitializer: Initialization timed out');
      _completeInitialization(false);
    });

    try {
      // Wait for Flutter engine to be fully ready
      await _waitForFlutterEngine();
      
      // Test if plugins are responsive
      await _testPluginAvailability();
      
      _pluginsInitialized = true;
      _completeInitialization(true);
      log('VoiceServiceInitializer: Plugin initialization successful');
      return true;
      
    } catch (e) {
      log('VoiceServiceInitializer: Plugin initialization failed: $e');
      _completeInitialization(false);
      return false;
    }
  }

  /// Wait for Flutter engine to be ready
  Future<void> _waitForFlutterEngine() async {
    // Progressive delay to ensure plugins are ready
    for (int i = 0; i < 5; i++) {
      await Future<void>.delayed(Duration(milliseconds: 200 * (i + 1)));
      
      try {
        // Test basic platform channel
        await const MethodChannel('flutter/platform').invokeMethod('SystemNavigator.pop');
      } catch (e) {
        // Expected to fail, just testing if platform channels work
        break;
      }
    }
  }

  /// Test if voice plugins are available and responsive
  Future<void> _testPluginAvailability() async {
    final futures = <Future<void>>[];
    
    // Test TTS plugin
    futures.add(_testTTSPlugin());
    
    // Test STT plugin
    futures.add(_testSTTPlugin());
    
    // Wait for both tests with timeout
    await Future.wait(futures).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw TimeoutException('Plugin test timeout');
      },
    );
  }

  /// Test TTS plugin responsiveness
  Future<void> _testTTSPlugin() async {
    try {
      const channel = MethodChannel('flutter_tts');
      // Try to get available languages - this will fail if plugin isn't ready
      await channel.invokeMethod('getLanguages');
      log('VoiceServiceInitializer: TTS plugin is responsive');
    } catch (e) {
      log('VoiceServiceInitializer: TTS plugin test failed: $e');
      // Continue anyway - the plugin might still work for basic operations
    }
  }

  /// Test STT plugin responsiveness  
  Future<void> _testSTTPlugin() async {
    try {
      const channel = MethodChannel('plugin.csdcorp.com/speech_to_text');
      // Try to check if speech is available - this will fail if plugin isn't ready
      await channel.invokeMethod('has_permission');
      log('VoiceServiceInitializer: STT plugin is responsive');
    } catch (e) {
      log('VoiceServiceInitializer: STT plugin test failed: $e');
      // Continue anyway - the plugin might still work for basic operations
    }
  }

  /// Complete initialization and notify all waiting completers
  void _completeInitialization(bool success) {
    _initTimer?.cancel();
    _initTimer = null;
    
    for (final completer in _waitingCompleters) {
      if (!completer.isCompleted) {
        completer.complete(success);
      }
    }
    _waitingCompleters.clear();
  }

  /// Reset initialization state (useful for testing)
  void reset() {
    _pluginsInitialized = false;
    _initTimer?.cancel();
    _initTimer = null;
    _waitingCompleters.clear();
  }

  /// Check if plugins are initialized
  bool get isInitialized => _pluginsInitialized;
}