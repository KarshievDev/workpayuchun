/// Abstract interface for Text-to-Speech functionality
abstract class TTSService {
  /// Initialize the TTS service
  /// Returns true if initialization was successful
  Future<bool> initialize();
  
  /// Speak the given text
  /// [text] - Text to be spoken
  /// [queueMode] - Whether to queue or interrupt current speech
  Future<void> speak(
    String text, {
    bool queueMode = false,
    void Function()? onStart,
    void Function()? onComplete,
    void Function(String error)? onError,
  });
  
  /// Stop current speech
  Future<void> stop();
  
  /// Pause current speech (if supported)
  Future<void> pause();
  
  /// Resume paused speech (if supported)
  Future<void> resume();
  
  /// Set speech rate (0.0 - 1.0, where 0.5 is normal)
  Future<void> setSpeechRate(double rate);
  
  /// Set speech volume (0.0 - 1.0)
  Future<void> setVolume(double volume);
  
  /// Set speech pitch (0.0 - 2.0, where 1.0 is normal)
  Future<void> setPitch(double pitch);
  
  /// Set language for speech
  /// [languageCode] - Language code (e.g., "en-US", "bn-BD", "ar-SA")
  Future<void> setLanguage(String languageCode);
  
  /// Get available languages
  Future<List<String>> getLanguages();
  
  /// Get available voices for current language
  Future<List<String>> getVoices();
  
  /// Set voice by name
  Future<void> setVoice(String voiceName);
  
  /// Whether TTS is currently speaking
  bool get isSpeaking;
  
  /// Whether TTS is available on this platform
  bool get isAvailable;
  
  /// Check if TTS engine is properly available and ready
  Future<bool> checkTTSAvailability();
  
  /// Get diagnostic information about TTS configuration
  Future<Map<String, dynamic>> getTTSDiagnostics();
  
  /// Current speech rate
  double get speechRate;
  
  /// Current volume
  double get volume;
  
  /// Current pitch
  double get pitch;
  
  /// Current language
  String? get currentLanguage;
  
  /// Dispose of resources
  Future<void> dispose();
}