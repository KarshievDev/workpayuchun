import 'package:equatable/equatable.dart';

/// Enumeration of voice input states
enum VoiceInputStatus {
  initial,      // Not started
  initializing, // Setting up services
  ready,        // Ready to listen
  listening,    // Currently listening
  processing,   // Processing speech
  completed,    // Successfully completed
  error,        // Error occurred
}

/// Enumeration of voice output states
enum VoiceOutputStatus {
  initial,  // Not started
  ready,    // Ready to speak
  speaking, // Currently speaking
  paused,   // Speech paused
  completed, // Speech completed
  error,    // Error occurred
}

/// Immutable state for voice input operations
class VoiceInputState extends Equatable {
  final VoiceInputStatus status;
  final String partialTranscript;
  final String finalTranscript;
  final String? errorMessage;
  final double? confidenceLevel;
  final bool hasPermission;
  final String? currentLocale;
  
  const VoiceInputState({
    this.status = VoiceInputStatus.initial,
    this.partialTranscript = '',
    this.finalTranscript = '',
    this.errorMessage,
    this.confidenceLevel,
    this.hasPermission = false,
    this.currentLocale,
  });
  
  VoiceInputState copyWith({
    VoiceInputStatus? status,
    String? partialTranscript,
    String? finalTranscript,
    String? errorMessage,
    double? confidenceLevel,
    bool? hasPermission,
    String? currentLocale,
  }) {
    return VoiceInputState(
      status: status ?? this.status,
      partialTranscript: partialTranscript ?? this.partialTranscript,
      finalTranscript: finalTranscript ?? this.finalTranscript,
      errorMessage: errorMessage ?? this.errorMessage,
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
      hasPermission: hasPermission ?? this.hasPermission,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }
  
  /// Clear error and reset to ready state
  VoiceInputState clearError() {
    return copyWith(
      status: VoiceInputStatus.ready,
      errorMessage: null,
    );
  }
  
  /// Reset transcripts while maintaining other state
  VoiceInputState clearTranscripts() {
    return copyWith(
      partialTranscript: '',
      finalTranscript: '',
    );
  }
  
  @override
  List<Object?> get props => [
    status,
    partialTranscript,
    finalTranscript,
    errorMessage,
    confidenceLevel,
    hasPermission,
    currentLocale,
  ];
}

/// Immutable state for voice output operations
class VoiceOutputState extends Equatable {
  final VoiceOutputStatus status;
  final String currentText;
  final String? errorMessage;
  final double speechRate;
  final double volume;
  final double pitch;
  final String? currentLanguage;
  final String? currentVoice;
  
  const VoiceOutputState({
    this.status = VoiceOutputStatus.initial,
    this.currentText = '',
    this.errorMessage,
    this.speechRate = 0.5,
    this.volume = 1.0,
    this.pitch = 1.0,
    this.currentLanguage,
    this.currentVoice,
  });
  
  VoiceOutputState copyWith({
    VoiceOutputStatus? status,
    String? currentText,
    String? errorMessage,
    double? speechRate,
    double? volume,
    double? pitch,
    String? currentLanguage,
    String? currentVoice,
  }) {
    return VoiceOutputState(
      status: status ?? this.status,
      currentText: currentText ?? this.currentText,
      errorMessage: errorMessage ?? this.errorMessage,
      speechRate: speechRate ?? this.speechRate,
      volume: volume ?? this.volume,
      pitch: pitch ?? this.pitch,
      currentLanguage: currentLanguage ?? this.currentLanguage,
      currentVoice: currentVoice ?? this.currentVoice,
    );
  }
  
  /// Clear error and reset to ready state
  VoiceOutputState clearError() {
    return copyWith(
      status: VoiceOutputStatus.ready,
      errorMessage: null,
    );
  }
  
  @override
  List<Object?> get props => [
    status,
    currentText,
    errorMessage,
    speechRate,
    volume,
    pitch,
    currentLanguage,
    currentVoice,
  ];
}

/// Combined voice state for both input and output
class VoiceState extends Equatable {
  final VoiceInputState input;
  final VoiceOutputState output;
  final bool isInitialized;
  
  const VoiceState({
    this.input = const VoiceInputState(),
    this.output = const VoiceOutputState(),
    this.isInitialized = false,
  });
  
  VoiceState copyWith({
    VoiceInputState? input,
    VoiceOutputState? output,
    bool? isInitialized,
  }) {
    return VoiceState(
      input: input ?? this.input,
      output: output ?? this.output,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
  
  @override
  List<Object?> get props => [input, output, isInitialized];
}