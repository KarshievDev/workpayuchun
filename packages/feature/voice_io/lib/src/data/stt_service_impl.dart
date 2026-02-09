import 'dart:async';
import 'dart:developer';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import '../domain/stt_service.dart';
import '../domain/speech_locale.dart';

/// Concrete implementation of STTService using speech_to_text package
class STTServiceImpl implements STTService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  
  bool _isInitialized = false;
  bool _isListening = false;
  String? _currentLocale;
  List<SpeechLocale> _supportedLocales = [];
  
  // Callback functions
  void Function(String)? _onPartial;
  void Function(String)? _onFinal;
  void Function(String)? _onError;
  
  Timer? _silenceTimer;
  Duration _pauseFor = const Duration(seconds: 3);
  
  @override
  Future<bool> initialize({String? localeId}) async {
    try {
      log('STTServiceImpl: Initializing speech-to-text service');
      
      if (_isInitialized) {
        log('STTServiceImpl: Service already initialized');
        return true;
      }
      
      // Add a delay to ensure plugins are ready
      await Future<void>.delayed(const Duration(milliseconds: 200));
      
      // Check if speech recognition is available with error handling
      bool available = false;
      try {
        available = await _speech.initialize(
          onStatus: _onStatusChanged,
          onError: _onSpeechError,
          debugLogging: true,
        );
      } catch (e) {
        log('STTServiceImpl: Plugin initialization failed: $e');
        // Try alternative initialization approach
        try {
          await Future<void>.delayed(const Duration(milliseconds: 500));
          available = await _speech.initialize(
            onStatus: _onStatusChanged,
            onError: _onSpeechError,
            debugLogging: false, // Disable debug logging on retry
          );
          log('STTServiceImpl: Plugin initialization succeeded on retry');
        } catch (retryError) {
          log('STTServiceImpl: Plugin initialization failed on retry: $retryError');
          return false;
        }
      }
      
      if (!available) {
        log('STTServiceImpl: Speech recognition not available on this device');
        return false;
      }
      
      // Get supported locales with error handling
      try {
        final locales = await _speech.locales();
        _supportedLocales = locales.map((locale) {
          return SpeechLocale(locale.localeId, locale.name);
        }).toList();
        log('STTServiceImpl: Found ${_supportedLocales.length} supported locales');
      } catch (e) {
        log('STTServiceImpl: Warning - Could not get supported locales: $e');
        // Continue with default locale
        _supportedLocales = [const SpeechLocale('en_US', 'English (US)')];
      }
      
      // Set current locale
      if (localeId != null) {
        _currentLocale = localeId;
      } else if (_supportedLocales.isNotEmpty) {
        _currentLocale = _supportedLocales.first.id;
      }
      
      _isInitialized = true;
      log('STTServiceImpl: Service initialized successfully with ${_supportedLocales.length} locales');
      return true;
      
    } catch (e) {
      log('STTServiceImpl: Error initializing service: $e');
      return false;
    }
  }
  
  @override
  Future<bool> hasPermission() async {
    final permission = await Permission.microphone.status;
    return permission == PermissionStatus.granted;
  }
  
  @override
  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }
  
  @override
  Future<void> start({
    required void Function(String partial) onPartial,
    required void Function(String finalText) onFinal,
    void Function(String error)? onError,
    Duration? pauseFor,
  }) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) {
        onError?.call('Failed to initialize speech recognition service');
        return;
      }
    }
    
    if (_isListening) {
      log('STTServiceImpl: Already listening, stopping previous session');
      await stop();
    }
    
    // Check permission
    if (!await hasPermission()) {
      if (!await requestPermission()) {
        onError?.call('Microphone permission denied');
        return;
      }
    }
    
    // Set callbacks
    _onPartial = onPartial;
    _onFinal = onFinal;
    _onError = onError;
    _pauseFor = pauseFor ?? _pauseFor;
    
    try {
      log('STTServiceImpl: Starting to listen with locale: $_currentLocale');
      
      // Attempt to start listening with error handling
      try {
        await _speech.listen(
          onResult: _onSpeechResult,
          listenFor: const Duration(minutes: 5), // Maximum listening duration
          pauseFor: _pauseFor,
          localeId: _currentLocale,
          listenOptions: stt.SpeechListenOptions(
            partialResults: true,
            listenMode: stt.ListenMode.confirmation,
            cancelOnError: false,
          ),
        );
      } catch (listenError) {
        log('STTServiceImpl: Listen method failed, trying with simpler options: $listenError');
        // Retry with simpler options
        await _speech.listen(
          onResult: _onSpeechResult,
          listenFor: const Duration(minutes: 2), // Shorter duration
          pauseFor: const Duration(seconds: 2), // Shorter pause
          localeId: _currentLocale,
        );
      }
      
      _isListening = true;
      log('STTServiceImpl: Started listening successfully');
      
    } catch (e) {
      log('STTServiceImpl: Error starting speech recognition: $e');
      _isListening = false;
      _onError?.call('Failed to start speech recognition. Please check microphone permissions and try again.');
    }
  }
  
  @override
  Future<void> stop() async {
    if (!_isListening) {
      log('STTServiceImpl: Not currently listening');
      return;
    }
    
    try {
      log('STTServiceImpl: Stopping speech recognition');
      await _speech.stop();
      _isListening = false;
      _clearCallbacks();
      _cancelSilenceTimer();
      
    } catch (e) {
      log('STTServiceImpl: Error stopping speech recognition: $e');
    }
  }
  
  @override
  Future<void> cancel() async {
    if (!_isListening) {
      log('STTServiceImpl: Not currently listening');
      return;
    }
    
    try {
      log('STTServiceImpl: Canceling speech recognition');
      await _speech.cancel();
      _isListening = false;
      _clearCallbacks();
      _cancelSilenceTimer();
      
    } catch (e) {
      log('STTServiceImpl: Error canceling speech recognition: $e');
    }
  }
  
  @override
  bool get isListening => _isListening;
  
  @override
  bool get isAvailable => _isInitialized && _speech.isAvailable;
  
  @override
  List<SpeechLocale> get supportedLocales => List.unmodifiable(_supportedLocales);
  
  @override
  String? get currentLocale => _currentLocale;
  
  @override
  Future<void> dispose() async {
    log('STTServiceImpl: Disposing service');
    await cancel();
    _clearCallbacks();
    _isInitialized = false;
    _supportedLocales.clear();
    _currentLocale = null;
  }
  
  // Private methods
  
  void _onSpeechResult(SpeechRecognitionResult result) {
    log('STTServiceImpl: Speech result - recognized: ${result.recognizedWords}, final: ${result.finalResult}');
    
    if (result.finalResult) {
      _onFinal?.call(result.recognizedWords);
      // Reset silence timer on final result
      _cancelSilenceTimer();
    } else {
      _onPartial?.call(result.recognizedWords);
      // Start/restart silence timer for partial results
      _startSilenceTimer();
    }
  }
  
  void _onStatusChanged(String status) {
    log('STTServiceImpl: Status changed to: $status');
    
    switch (status) {
      case 'listening':
        _isListening = true;
        break;
      case 'notListening':
        _isListening = false;
        _clearCallbacks();
        break;
      case 'done':
        _isListening = false;
        _clearCallbacks();
        break;
    }
  }
  
  void _onSpeechError(dynamic error) {
    log('STTServiceImpl: Speech error: $error');
    _isListening = false;
    _onError?.call('Speech recognition error: ${error.toString()}');
    _clearCallbacks();
  }
  
  void _startSilenceTimer() {
    _cancelSilenceTimer();
    _silenceTimer = Timer(_pauseFor, () {
      log('STTServiceImpl: Silence timeout, stopping listening');
      stop();
    });
  }
  
  void _cancelSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = null;
  }
  
  void _clearCallbacks() {
    _onPartial = null;
    _onFinal = null;
    _onError = null;
  }
}