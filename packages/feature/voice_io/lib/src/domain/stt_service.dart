import 'speech_locale.dart';

/// Abstract interface for Speech-to-Text functionality
abstract class STTService {
  /// Initialize the STT service with optional locale
  /// Returns true if initialization was successful
  Future<bool> initialize({String? localeId});
  
  /// Check if the app has microphone permission
  /// Returns true if permission is granted
  Future<bool> hasPermission();
  
  /// Request microphone permission if not already granted
  /// Returns true if permission is granted after request
  Future<bool> requestPermission();
  
  /// Start listening for speech input
  /// [onPartial] - Called with partial transcript updates
  /// [onFinal] - Called with final transcript after silence
  /// [pauseFor] - Duration of silence before auto-stopping (VAD-like behavior)
  Future<void> start({
    required void Function(String partial) onPartial,
    required void Function(String finalText) onFinal,
    void Function(String error)? onError,
    Duration? pauseFor,
  });
  
  /// Stop listening and finalize current transcript
  Future<void> stop();
  
  /// Cancel listening without finalizing transcript
  Future<void> cancel();
  
  /// Whether the service is currently listening
  bool get isListening;
  
  /// Whether the service is available on this platform
  bool get isAvailable;
  
  /// Get list of supported locales for speech recognition
  List<SpeechLocale> get supportedLocales;
  
  /// Current locale being used for recognition
  String? get currentLocale;
  
  /// Dispose of resources
  Future<void> dispose();
}