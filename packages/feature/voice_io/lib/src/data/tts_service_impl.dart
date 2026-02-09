import 'dart:async';
import 'dart:developer';

import 'package:flutter_tts/flutter_tts.dart';

import '../domain/tts_service.dart';

/// Concrete implementation of TTSService using flutter_tts package
class TTSServiceImpl implements TTSService {
  final FlutterTts _tts = FlutterTts();

  bool _isInitialized = false;
  bool _isSpeaking = false;
  double _speechRate = 0.5;
  double _volume = 1.0;
  double _pitch = 1.0;
  String? _currentLanguage;

  // Callback functions
  void Function()? _onStart;
  void Function()? _onComplete;
  void Function(String)? _onError;

  @override
  Future<bool> initialize() async {
    try {
      log('TTSServiceImpl: Initializing text-to-speech service');

      if (_isInitialized) {
        log('TTSServiceImpl: Service already initialized');
        return true;
      }

      // Set up TTS handlers first
      _tts.setStartHandler(() {
        log('TTSServiceImpl: Speech started');
        _isSpeaking = true;
        _onStart?.call();
      });

      _tts.setCompletionHandler(() {
        log('TTSServiceImpl: Speech completed');
        _isSpeaking = false;
        _onComplete?.call();
        _clearCallbacks();
      });

      _tts.setCancelHandler(() {
        log('TTSServiceImpl: Speech canceled');
        _isSpeaking = false;
        _clearCallbacks();
      });

      _tts.setPauseHandler(() {
        log('TTSServiceImpl: Speech paused');
      });

      _tts.setContinueHandler(() {
        log('TTSServiceImpl: Speech resumed');
      });

      _tts.setErrorHandler((message) {
        log('TTSServiceImpl: TTS error: $message');
        _isSpeaking = false;
        String errorMessage = 'Text-to-speech error: $message';

        // Handle specific error codes
        if (message.toString().contains('-3')) {
          errorMessage =
              'TTS engine not ready. Please try again in a moment or check if TTS data is installed.';
        } else if (message.toString().contains('not bound to TTS engine')) {
          errorMessage = 'TTS engine connection failed. Initializing...';
        }

        _onError?.call(errorMessage);
        _clearCallbacks();
      });

      // Add longer delay to ensure TTS engine is fully initialized
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Wait for TTS engine to be ready with timeout
      bool engineReady = false;
      int attempts = 0;
      const maxAttempts = 10;

      while (!engineReady && attempts < maxAttempts) {
        try {
          // Check if TTS is available by trying to get languages
          final dynamic languageResult = await _tts.getLanguages.timeout(
            const Duration(seconds: 2),
            onTimeout: () => <String>[],
          );

          final List<String> languages =
              languageResult is List
                  ? languageResult.cast<String>()
                  : <String>[];

          if (languages.isNotEmpty) {
            engineReady = true;
            log(
              'TTSServiceImpl: TTS engine is ready with ${languages.length} languages',
            );
          } else {
            attempts++;
            log(
              'TTSServiceImpl: TTS engine not ready, attempt $attempts/$maxAttempts',
            );
            await Future<void>.delayed(const Duration(milliseconds: 200));
          }
        } catch (e) {
          attempts++;
          log(
            'TTSServiceImpl: TTS engine check failed, attempt $attempts/$maxAttempts: $e',
          );
          await Future<void>.delayed(const Duration(milliseconds: 200));
        }
      }

      if (!engineReady) {
        log('TTSServiceImpl: TTS engine not ready after $maxAttempts attempts');
        // Still try to initialize settings, TTS might work anyway
      }

      // Try to initialize plugin settings with error handling
      await _initializeSettings();

      _isInitialized = true;
      log('TTSServiceImpl: Service initialized successfully');
      return true;
    } catch (e) {
      log('TTSServiceImpl: Error initializing service: $e');
      return false;
    }
  }

  /// Initialize TTS settings with graceful error handling
  Future<void> _initializeSettings() async {
    try {
      // Test if plugin is available by trying a simple operation
      await _tts.getLanguages;
      log('TTSServiceImpl: Plugin is available, setting default values');

      // Set audio settings for better output
      try {
        // Set audio focus and stream type for Android
        await _tts.setSharedInstance(true);
        log('TTSServiceImpl: Shared instance configured');
      } catch (e) {
        log(
          'TTSServiceImpl: Warning - Could not configure shared instance: $e',
        );
      }

      // Ensure volume is set to maximum for better audio output
      try {
        await _tts.setVolume(1.0);
        _volume = 1.0;
        log('TTSServiceImpl: Volume set to maximum (1.0)');
      } catch (e) {
        log('TTSServiceImpl: Warning - Could not set volume: $e');
      }

      // Set default settings one by one with error handling
      try {
        await _tts.setSpeechRate(_speechRate);
        log('TTSServiceImpl: Speech rate set successfully');
      } catch (e) {
        log('TTSServiceImpl: Warning - Could not set speech rate: $e');
      }

      try {
        await _tts.setPitch(_pitch);
        log('TTSServiceImpl: Pitch set successfully');
      } catch (e) {
        log('TTSServiceImpl: Warning - Could not set pitch: $e');
      }

      // Try to set a default language
      try {
        final languages = await getLanguages();
        if (languages.isNotEmpty) {
          // Try to find English first, otherwise use first available
          final String preferredLang = languages.firstWhere(
            (lang) => lang.toLowerCase().contains('en'),
            orElse: () => languages.first,
          );

          _currentLanguage = preferredLang;
          await _tts.setLanguage(_currentLanguage!);
          log('TTSServiceImpl: Default language set to: $_currentLanguage');
        }
      } catch (e) {
        log('TTSServiceImpl: Warning - Could not set default language: $e');
      }

      // Check and log current TTS engine info
      try {
        final engines = await _tts.getEngines;
        log('TTSServiceImpl: Available TTS engines: $engines');

        // Get default engine
        final defaultEngine = await _tts.getDefaultEngine;
        log('TTSServiceImpl: Default TTS engine: $defaultEngine');

        // Get available voices for debugging
        final dynamic voicesResult = await _tts.getVoices;
        final List<dynamic>? voices =
            voicesResult is List ? voicesResult : null;
        log('TTSServiceImpl: Available voices: ${voices?.length ?? 0}');

        // Set a default voice if available
        if (voices != null && voices.isNotEmpty == true) {
          try {
            final firstVoice = voices.first;
            if (firstVoice is Map<String, dynamic>) {
              final voiceMap = Map<String, String>.from(
                firstVoice.map(
                  (key, value) => MapEntry(key.toString(), value.toString()),
                ),
              );
              await _tts.setVoice(voiceMap);
              log(
                'TTSServiceImpl: Default voice set: ${firstVoice['name'] ?? 'Unknown'}',
              );
            }
          } catch (voiceError) {
            log('TTSServiceImpl: Could not set default voice: $voiceError');
          }
        }
      } catch (e) {
        log('TTSServiceImpl: Could not get TTS engine info: $e');
      }
    } catch (e) {
      log(
        'TTSServiceImpl: Plugin not fully available yet, will initialize settings on first use: $e',
      );
    }
  }

  String _sanitizedString({required String text}) {
    final sanitizedText = text.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
    return sanitizedText;
  }

  @override
  Future<void> speak(
    String text, {
    bool queueMode = false,
    void Function()? onStart,
    void Function()? onComplete,
    void Function(String error)? onError,
  }) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) {
        onError?.call('Failed to initialize text-to-speech service');
        return;
      }
    }

    if (text.trim().isEmpty) {
      onError?.call('Text to speak is empty');
      return;
    }

    // Stop current speech if not in queue mode
    if (!queueMode && _isSpeaking) {
      await stop();
    }

    // Set callbacks first
    _onStart = onStart;
    _onComplete = onComplete;
    _onError = onError;

    // Try speaking with retry logic for error -3
    await _speakWithRetry(text, maxRetries: 3);
  }

  /// Speak with retry logic to handle TTS engine not ready errors
  Future<void> _speakWithRetry(String text, {int maxRetries = 3}) async {
    int attempts = 0;

    // First, validate audio configuration
    await _validateAudioConfiguration();

    while (attempts < maxRetries) {
      try {
        log(
          'TTSServiceImpl: Speaking text (attempt ${attempts + 1}/$maxRetries): "${text.substring(0, text.length > 50 ? 50 : text.length)}..."',
        );

        // Ensure settings are applied before speaking
        await _ensureSettingsApplied();

        // Try to speak
        await _tts.speak(_sanitizedString(text: text));

        // If we get here without exception, speaking was initiated successfully
        return;
      } catch (e) {
        attempts++;
        log(
          'TTSServiceImpl: Error speaking text (attempt $attempts/$maxRetries): $e',
        );

        if (e.toString().contains('-3') ||
            e.toString().contains('ERROR_NOT_INSTALLED_YET')) {
          // TTS engine not ready, wait and retry
          if (attempts < maxRetries) {
            log(
              'TTSServiceImpl: TTS engine not ready, retrying in 1 second...',
            );
            await Future<void>.delayed(const Duration(seconds: 1));

            // Try to reinitialize TTS engine
            try {
              await _reinitializeTTS();
            } catch (reinitError) {
              log('TTSServiceImpl: Failed to reinitialize TTS: $reinitError');
            }
          } else {
            _onError?.call(
              'TTS engine not available. Please check if text-to-speech data is installed on your device.',
            );
            _clearCallbacks();
            return;
          }
        } else {
          // Other error, don't retry
          _onError?.call('Failed to speak text: $e');
          _clearCallbacks();
          return;
        }
      }
    }

    // If we reach here, all retries failed
    _onError?.call(
      'Failed to speak after $maxRetries attempts. TTS engine may not be available.',
    );
    _clearCallbacks();
  }

  /// Validate and fix audio configuration for proper TTS output
  Future<void> _validateAudioConfiguration() async {
    try {
      log('TTSServiceImpl: Validating audio configuration...');

      // Ensure volume is at maximum
      if (_volume < 0.8) {
        log('TTSServiceImpl: Volume is low ($_volume), setting to maximum');
        await _tts.setVolume(1.0);
        _volume = 1.0;
      }

      // Ensure we have a language set
      if (_currentLanguage == null) {
        final dynamic langResult = await _tts.getLanguages.timeout(
          const Duration(seconds: 2),
        );
        final List<String> languages =
            langResult is List ? langResult.cast<String>() : <String>[];
        if (languages.isNotEmpty) {
          _currentLanguage = languages.first;
          await _tts.setLanguage(_currentLanguage!);
          log('TTSServiceImpl: Set fallback language: $_currentLanguage');
        }
      }

      // Check if we have voices available
      try {
        final dynamic voicesResult = await _tts.getVoices.timeout(
          const Duration(seconds: 2),
        );
        final List<dynamic>? voices =
            voicesResult is List ? voicesResult : null;
        if (voices == null || voices.isEmpty) {
          log(
            'TTSServiceImpl: WARNING - No voices available! This may cause silent TTS',
          );
        } else {
          log('TTSServiceImpl: ${voices.length} voices available');
        }
      } catch (e) {
        log('TTSServiceImpl: Could not check voices: $e');
      }

      // Test TTS with very short text to verify audio path
      try {
        log('TTSServiceImpl: Testing TTS audio path...');
        // We don't await this to avoid blocking, just trigger to test the audio path
        _tts.speak('').catchError((Object e) {
          log('TTSServiceImpl: TTS test failed: $e');
          return null;
        });

        // Small delay to let the test complete
        await Future<void>.delayed(const Duration(milliseconds: 100));
      } catch (e) {
        log('TTSServiceImpl: TTS audio path test failed: $e');
      }

      log('TTSServiceImpl: Audio configuration validation completed');
    } catch (e) {
      log('TTSServiceImpl: Error validating audio configuration: $e');
    }
  }

  /// Reinitialize TTS engine
  Future<void> _reinitializeTTS() async {
    log('TTSServiceImpl: Reinitializing TTS engine...');

    try {
      // Check TTS availability again
      final dynamic langResult = await _tts.getLanguages.timeout(
        const Duration(seconds: 3),
        onTimeout: () => <String>[],
      );

      final List<String> languages =
          langResult is List ? langResult.cast<String>() : <String>[];

      if (languages.isNotEmpty) {
        log('TTSServiceImpl: TTS engine reinitialized successfully');
        await _initializeSettings();
      } else {
        log(
          'TTSServiceImpl: TTS engine still not available after reinitialization',
        );
      }
    } catch (e) {
      log('TTSServiceImpl: Error during TTS reinitialization: $e');
    }
  }

  /// Ensure TTS settings are properly applied, retry if needed
  Future<void> _ensureSettingsApplied() async {
    try {
      // Try to apply current settings with individual error handling
      try {
        await _tts
            .setSpeechRate(_speechRate)
            .timeout(const Duration(seconds: 2));
      } catch (e) {
        log('TTSServiceImpl: Could not set speech rate: $e');
      }

      try {
        await _tts.setVolume(_volume).timeout(const Duration(seconds: 2));
      } catch (e) {
        log('TTSServiceImpl: Could not set volume: $e');
      }

      try {
        await _tts.setPitch(_pitch).timeout(const Duration(seconds: 2));
      } catch (e) {
        log('TTSServiceImpl: Could not set pitch: $e');
      }

      if (_currentLanguage != null) {
        try {
          await _tts
              .setLanguage(_currentLanguage!)
              .timeout(const Duration(seconds: 2));
        } catch (e) {
          log('TTSServiceImpl: Could not set language: $e');
          // Try to set a default language if current one fails
          try {
            final dynamic langResult = await _tts.getLanguages.timeout(
              const Duration(seconds: 2),
            );
            final List<String> languages =
                langResult is List ? langResult.cast<String>() : <String>[];
            if (languages.isNotEmpty) {
              final String defaultLang = languages.first;
              await _tts
                  .setLanguage(defaultLang)
                  .timeout(const Duration(seconds: 2));
              _currentLanguage = defaultLang;
              log('TTSServiceImpl: Fallback to default language: $defaultLang');
            }
          } catch (fallbackError) {
            log(
              'TTSServiceImpl: Could not set fallback language: $fallbackError',
            );
          }
        }
      } else {
        // Try to set a default language if none is set
        try {
          final dynamic langResult = await _tts.getLanguages.timeout(
            const Duration(seconds: 2),
          );
          final List<String> languages =
              langResult is List ? langResult.cast<String>() : <String>[];
          if (languages.isNotEmpty) {
            _currentLanguage = languages.first;
            await _tts
                .setLanguage(_currentLanguage!)
                .timeout(const Duration(seconds: 2));
            log('TTSServiceImpl: Set default language: $_currentLanguage');
          }
        } catch (e) {
          log('TTSServiceImpl: Could not get or set default language: $e');
        }
      }
    } catch (e) {
      // Settings couldn't be applied, but continue anyway
      log('TTSServiceImpl: Warning - Could not ensure settings applied: $e');
    }
  }

  @override
  Future<void> stop() async {
    if (!_isSpeaking) {
      log('TTSServiceImpl: Not currently speaking');
      return;
    }

    try {
      log('TTSServiceImpl: Stopping speech');
      await _tts.stop();
      _isSpeaking = false;
      _clearCallbacks();
    } catch (e) {
      log('TTSServiceImpl: Error stopping speech: $e');
    }
  }

  @override
  Future<void> pause() async {
    if (!_isSpeaking) {
      log('TTSServiceImpl: Not currently speaking, cannot pause');
      return;
    }

    try {
      log('TTSServiceImpl: Pausing speech');
      await _tts.pause();
    } catch (e) {
      log('TTSServiceImpl: Error pausing speech: $e');
    }
  }

  @override
  Future<void> resume() async {
    try {
      log('TTSServiceImpl: Resuming speech');
      await _tts.speak(''); // This continues paused speech
    } catch (e) {
      log('TTSServiceImpl: Error resuming speech: $e');
    }
  }

  @override
  Future<void> setSpeechRate(double rate) async {
    if (rate < 0.0 || rate > 1.0) {
      log(
        'TTSServiceImpl: Invalid speech rate: $rate. Must be between 0.0 and 1.0',
      );
      return;
    }

    try {
      _speechRate = rate;

      // If service is not initialized, just store the value for later
      if (!_isInitialized) {
        log(
          'TTSServiceImpl: Service not initialized, speech rate will be set on initialization',
        );
        return;
      }

      await _tts.setSpeechRate(rate);
      log('TTSServiceImpl: Speech rate set to: $rate');
    } catch (e) {
      log('TTSServiceImpl: Error setting speech rate: $e');
      // Don't throw the error, just log it
    }
  }

  @override
  Future<void> setVolume(double volume) async {
    if (volume < 0.0 || volume > 1.0) {
      log(
        'TTSServiceImpl: Invalid volume: $volume. Must be between 0.0 and 1.0',
      );
      return;
    }

    try {
      _volume = volume;
      await _tts.setVolume(volume);
      log('TTSServiceImpl: Volume set to: $volume');

      // Verify the volume was actually set
      try {
        // Small delay to let the setting apply
        await Future<void>.delayed(const Duration(milliseconds: 50));
        log('TTSServiceImpl: Volume setting applied successfully');
      } catch (e) {
        log('TTSServiceImpl: Volume verification failed: $e');
      }
    } catch (e) {
      log('TTSServiceImpl: Error setting volume: $e');
      // Try to force set volume again
      try {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await _tts.setVolume(volume);
        log('TTSServiceImpl: Volume force-set successful');
      } catch (retryError) {
        log('TTSServiceImpl: Volume force-set failed: $retryError');
      }
    }
  }

  @override
  Future<void> setPitch(double pitch) async {
    if (pitch < 0.0 || pitch > 2.0) {
      log('TTSServiceImpl: Invalid pitch: $pitch. Must be between 0.0 and 2.0');
      return;
    }

    try {
      _pitch = pitch;
      await _tts.setPitch(pitch);
      log('TTSServiceImpl: Pitch set to: $pitch');
    } catch (e) {
      log('TTSServiceImpl: Error setting pitch: $e');
    }
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    try {
      final result = await _tts.setLanguage(languageCode);
      if (result == 1) {
        _currentLanguage = languageCode;
        log('TTSServiceImpl: Language set to: $languageCode');
      } else {
        log('TTSServiceImpl: Failed to set language to: $languageCode');
      }
    } catch (e) {
      log('TTSServiceImpl: Error setting language: $e');
    }
  }

  @override
  Future<List<String>> getLanguages() async {
    try {
      final languages = await _tts.getLanguages;
      if (languages != null && languages is List) {
        final languageList = languages.cast<String>();
        log('TTSServiceImpl: Available languages: ${languageList.length}');
        return languageList;
      }
      return [];
    } catch (e) {
      log('TTSServiceImpl: Error getting languages: $e');
      return [];
    }
  }

  @override
  Future<List<String>> getVoices() async {
    try {
      final voices = await _tts.getVoices;
      if (voices != null && voices is List) {
        final voiceList = <String>[];
        for (final voice in voices) {
          if (voice is Map<String, dynamic>) {
            final name = voice['name']?.toString() ?? 'Unknown Voice';
            voiceList.add(name);
          } else {
            voiceList.add(voice.toString());
          }
        }
        log('TTSServiceImpl: Available voices: ${voiceList.length}');
        return voiceList;
      }
      return [];
    } catch (e) {
      log('TTSServiceImpl: Error getting voices: $e');
      return [];
    }
  }

  @override
  Future<void> setVoice(String voiceName) async {
    try {
      final voices = await _tts.getVoices;
      if (voices != null && voices is List) {
        for (final voice in voices) {
          if (voice is Map<String, dynamic> && voice['name'] == voiceName) {
            final voiceMap = Map<String, String>.from(
              voice.map(
                (key, value) => MapEntry(key.toString(), value.toString()),
              ),
            );
            await _tts.setVoice(voiceMap);
            log('TTSServiceImpl: Voice set to: $voiceName');
            return;
          }
        }
      }
      log('TTSServiceImpl: Voice not found: $voiceName');
    } catch (e) {
      log('TTSServiceImpl: Error setting voice: $e');
    }
  }

  @override
  bool get isSpeaking => _isSpeaking;

  @override
  bool get isAvailable => _isInitialized;

  /// Check if TTS engine is properly available and ready
  Future<bool> checkTTSAvailability() async {
    try {
      log('TTSServiceImpl: Checking TTS availability...');

      // Try to get languages with timeout
      final dynamic langResult = await _tts.getLanguages.timeout(
        const Duration(seconds: 3),
        onTimeout: () => <String>[],
      );

      final List<String> languages =
          langResult is List ? langResult.cast<String>() : <String>[];
      final bool available = languages.isNotEmpty;
      log(
        'TTSServiceImpl: TTS availability check result: $available (${languages.length} languages)',
      );

      return available;
    } catch (e) {
      log('TTSServiceImpl: TTS availability check failed: $e');
      return false;
    }
  }

  /// Get diagnostic information about TTS configuration
  Future<Map<String, dynamic>> getTTSDiagnostics() async {
    final diagnostics = <String, dynamic>{
      'isInitialized': _isInitialized,
      'isSpeaking': _isSpeaking,
      'volume': _volume,
      'speechRate': _speechRate,
      'pitch': _pitch,
      'currentLanguage': _currentLanguage,
    };

    try {
      // Get available languages
      final dynamic langResult = await _tts.getLanguages.timeout(
        const Duration(seconds: 3),
        onTimeout: () => <String>[],
      );
      final List<String> languages =
          langResult is List ? langResult.cast<String>() : <String>[];
      diagnostics['availableLanguages'] = languages;
      diagnostics['languageCount'] = languages.length;

      // Get available voices
      final dynamic voicesResult = await _tts.getVoices.timeout(
        const Duration(seconds: 3),
        onTimeout: () => null,
      );
      final List<dynamic>? voices = voicesResult is List ? voicesResult : null;
      diagnostics['voiceCount'] = voices?.length ?? 0;

      // Get TTS engines
      final engines = await _tts.getEngines.timeout(
        const Duration(seconds: 3),
        onTimeout: () => null,
      );
      diagnostics['availableEngines'] = engines;

      // Get default engine
      final defaultEngine = await _tts.getDefaultEngine.timeout(
        const Duration(seconds: 3),
        onTimeout: () => 'unknown',
      );
      diagnostics['defaultEngine'] = defaultEngine;

      // Test availability
      diagnostics['isAvailable'] = await checkTTSAvailability();
    } catch (e) {
      diagnostics['diagnosticError'] = e.toString();
      log('TTSServiceImpl: Error getting TTS diagnostics: $e');
    }

    return diagnostics;
  }

  @override
  double get speechRate => _speechRate;

  @override
  double get volume => _volume;

  @override
  double get pitch => _pitch;

  @override
  String? get currentLanguage => _currentLanguage;

  @override
  Future<void> dispose() async {
    log('TTSServiceImpl: Disposing service');
    await stop();
    _clearCallbacks();
    _isInitialized = false;
    _currentLanguage = null;
  }

  // Private methods

  void _clearCallbacks() {
    _onStart = null;
    _onComplete = null;
    _onError = null;
  }
}
