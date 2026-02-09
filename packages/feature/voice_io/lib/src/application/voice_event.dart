import 'package:equatable/equatable.dart';

/// Base class for voice events
abstract class VoiceEvent extends Equatable {
  const VoiceEvent();
  
  @override
  List<Object?> get props => [];
}

// Voice Input Events

/// Initialize the voice input service
class VoiceInputInitializeEvent extends VoiceEvent {
  final String? localeId;
  
  const VoiceInputInitializeEvent({this.localeId});
  
  @override
  List<Object?> get props => [localeId];
}

/// Start listening for speech input
class VoiceInputStartListeningEvent extends VoiceEvent {
  final Duration? pauseFor;
  
  const VoiceInputStartListeningEvent({this.pauseFor});
  
  @override
  List<Object?> get props => [pauseFor];
}

/// Stop listening for speech input
class VoiceInputStopListeningEvent extends VoiceEvent {
  const VoiceInputStopListeningEvent();
}

/// Cancel current speech input
class VoiceInputCancelEvent extends VoiceEvent {
  const VoiceInputCancelEvent();
}

/// Partial transcript received
class VoiceInputPartialTranscriptEvent extends VoiceEvent {
  final String transcript;
  
  const VoiceInputPartialTranscriptEvent(this.transcript);
  
  @override
  List<Object> get props => [transcript];
}

/// Final transcript received
class VoiceInputFinalTranscriptEvent extends VoiceEvent {
  final String transcript;
  final double? confidence;
  
  const VoiceInputFinalTranscriptEvent(this.transcript, {this.confidence});
  
  @override
  List<Object?> get props => [transcript, confidence];
}

/// Speech input error occurred
class VoiceInputErrorEvent extends VoiceEvent {
  final String error;
  
  const VoiceInputErrorEvent(this.error);
  
  @override
  List<Object> get props => [error];
}

/// Clear speech input error
class VoiceInputClearErrorEvent extends VoiceEvent {
  const VoiceInputClearErrorEvent();
}

/// Clear speech transcripts
class VoiceInputClearTranscriptsEvent extends VoiceEvent {
  const VoiceInputClearTranscriptsEvent();
}

/// Request microphone permission
class VoiceInputRequestPermissionEvent extends VoiceEvent {
  const VoiceInputRequestPermissionEvent();
}

// Voice Output Events

/// Initialize the voice output service
class VoiceOutputInitializeEvent extends VoiceEvent {
  const VoiceOutputInitializeEvent();
}

/// Speak the given text
class VoiceOutputSpeakEvent extends VoiceEvent {
  final String text;
  final bool queueMode;
  
  const VoiceOutputSpeakEvent(this.text, {this.queueMode = false});
  
  @override
  List<Object> get props => [text, queueMode];
}

/// Stop current speech output
class VoiceOutputStopEvent extends VoiceEvent {
  const VoiceOutputStopEvent();
}

/// Pause current speech output
class VoiceOutputPauseEvent extends VoiceEvent {
  const VoiceOutputPauseEvent();
}

/// Resume paused speech output
class VoiceOutputResumeEvent extends VoiceEvent {
  const VoiceOutputResumeEvent();
}

/// Set speech rate
class VoiceOutputSetSpeechRateEvent extends VoiceEvent {
  final double rate;
  
  const VoiceOutputSetSpeechRateEvent(this.rate);
  
  @override
  List<Object> get props => [rate];
}

/// Set speech volume
class VoiceOutputSetVolumeEvent extends VoiceEvent {
  final double volume;
  
  const VoiceOutputSetVolumeEvent(this.volume);
  
  @override
  List<Object> get props => [volume];
}

/// Set speech pitch
class VoiceOutputSetPitchEvent extends VoiceEvent {
  final double pitch;
  
  const VoiceOutputSetPitchEvent(this.pitch);
  
  @override
  List<Object> get props => [pitch];
}

/// Set speech language
class VoiceOutputSetLanguageEvent extends VoiceEvent {
  final String languageCode;
  
  const VoiceOutputSetLanguageEvent(this.languageCode);
  
  @override
  List<Object> get props => [languageCode];
}

/// Set speech voice
class VoiceOutputSetVoiceEvent extends VoiceEvent {
  final String voiceName;
  
  const VoiceOutputSetVoiceEvent(this.voiceName);
  
  @override
  List<Object> get props => [voiceName];
}

/// Speech output started
class VoiceOutputStartedEvent extends VoiceEvent {
  const VoiceOutputStartedEvent();
}

/// Speech output completed
class VoiceOutputCompletedEvent extends VoiceEvent {
  const VoiceOutputCompletedEvent();
}

/// Speech output error occurred
class VoiceOutputErrorEvent extends VoiceEvent {
  final String error;
  
  const VoiceOutputErrorEvent(this.error);
  
  @override
  List<Object> get props => [error];
}

/// Clear speech output error
class VoiceOutputClearErrorEvent extends VoiceEvent {
  const VoiceOutputClearErrorEvent();
}

// Combined Events

/// Initialize both voice input and output services
class VoiceInitializeEvent extends VoiceEvent {
  final String? localeId;
  
  const VoiceInitializeEvent({this.localeId});
  
  @override
  List<Object?> get props => [localeId];
}

/// Dispose voice services
class VoiceDisposeEvent extends VoiceEvent {
  const VoiceDisposeEvent();
}