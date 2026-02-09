import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/voice_service_initializer.dart';
import '../domain/stt_service.dart';
import '../domain/tts_service.dart';
import '../domain/voice_state.dart';
import 'voice_event.dart';

/// BLoC for managing voice input and output operations
class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  final STTService _sttService;
  final TTSService _ttsService;
  
  VoiceBloc({
    required STTService sttService,
    required TTSService ttsService,
  }) : _sttService = sttService,
       _ttsService = ttsService,
       super(const VoiceState()) {
    
    // Combined events
    on<VoiceInitializeEvent>(_onVoiceInitialize);
    on<VoiceDisposeEvent>(_onVoiceDispose);
    
    // Voice Input events
    on<VoiceInputInitializeEvent>(_onVoiceInputInitialize);
    on<VoiceInputStartListeningEvent>(_onVoiceInputStartListening);
    on<VoiceInputStopListeningEvent>(_onVoiceInputStopListening);
    on<VoiceInputCancelEvent>(_onVoiceInputCancel);
    on<VoiceInputPartialTranscriptEvent>(_onVoiceInputPartialTranscript);
    on<VoiceInputFinalTranscriptEvent>(_onVoiceInputFinalTranscript);
    on<VoiceInputErrorEvent>(_onVoiceInputError);
    on<VoiceInputClearErrorEvent>(_onVoiceInputClearError);
    on<VoiceInputClearTranscriptsEvent>(_onVoiceInputClearTranscripts);
    on<VoiceInputRequestPermissionEvent>(_onVoiceInputRequestPermission);
    
    // Voice Output events
    on<VoiceOutputInitializeEvent>(_onVoiceOutputInitialize);
    on<VoiceOutputSpeakEvent>(_onVoiceOutputSpeak);
    on<VoiceOutputStopEvent>(_onVoiceOutputStop);
    on<VoiceOutputPauseEvent>(_onVoiceOutputPause);
    on<VoiceOutputResumeEvent>(_onVoiceOutputResume);
    on<VoiceOutputSetSpeechRateEvent>(_onVoiceOutputSetSpeechRate);
    on<VoiceOutputSetVolumeEvent>(_onVoiceOutputSetVolume);
    on<VoiceOutputSetPitchEvent>(_onVoiceOutputSetPitch);
    on<VoiceOutputSetLanguageEvent>(_onVoiceOutputSetLanguage);
    on<VoiceOutputSetVoiceEvent>(_onVoiceOutputSetVoice);
    on<VoiceOutputStartedEvent>(_onVoiceOutputStarted);
    on<VoiceOutputCompletedEvent>(_onVoiceOutputCompleted);
    on<VoiceOutputErrorEvent>(_onVoiceOutputError);
    on<VoiceOutputClearErrorEvent>(_onVoiceOutputClearError);
  }
  
  // Combined event handlers
  
  Future<void> _onVoiceInitialize(VoiceInitializeEvent event, Emitter<VoiceState> emit) async {
    try {
      log('VoiceBloc: Initializing voice services');
      
      // First initialize the voice plugins
      final pluginsReady = await VoiceServiceInitializer().initializeVoicePlugins();
      if (!pluginsReady) {
        log('VoiceBloc: Plugin initialization failed, continuing anyway');
        // Continue with service initialization - services will handle missing plugins
      }
      
      // Initialize STT service
      final sttInitialized = await _sttService.initialize(localeId: event.localeId);
      final hasPermission = sttInitialized ? await _sttService.hasPermission() : false;
      
      // Initialize TTS service
      final ttsInitialized = await _ttsService.initialize();
      
      emit(state.copyWith(
        input: state.input.copyWith(
          status: sttInitialized ? VoiceInputStatus.ready : VoiceInputStatus.error,
          errorMessage: sttInitialized ? null : 'Failed to initialize speech recognition',
          hasPermission: hasPermission,
          currentLocale: event.localeId,
        ),
        output: state.output.copyWith(
          status: ttsInitialized ? VoiceOutputStatus.ready : VoiceOutputStatus.error,
          errorMessage: ttsInitialized ? null : 'Failed to initialize text-to-speech',
        ),
        isInitialized: sttInitialized && ttsInitialized,
      ));
      
    } catch (e) {
      log('VoiceBloc: Error initializing voice services: $e');
      emit(state.copyWith(
        input: state.input.copyWith(
          status: VoiceInputStatus.error,
          errorMessage: 'Error initializing voice services: $e',
        ),
        output: state.output.copyWith(
          status: VoiceOutputStatus.error,
          errorMessage: 'Error initializing voice services: $e',
        ),
      ));
    }
  }
  
  Future<void> _onVoiceDispose(VoiceDisposeEvent event, Emitter<VoiceState> emit) async {
    try {
      log('VoiceBloc: Disposing voice services');
      
      await _sttService.dispose();
      await _ttsService.dispose();
      
      emit(const VoiceState());
      
    } catch (e) {
      log('VoiceBloc: Error disposing voice services: $e');
    }
  }
  
  // Voice Input event handlers
  
  Future<void> _onVoiceInputInitialize(VoiceInputInitializeEvent event, Emitter<VoiceState> emit) async {
    try {
      emit(state.copyWith(
        input: state.input.copyWith(status: VoiceInputStatus.initializing),
      ));
      
      final initialized = await _sttService.initialize(localeId: event.localeId);
      final hasPermission = initialized ? await _sttService.hasPermission() : false;
      
      emit(state.copyWith(
        input: state.input.copyWith(
          status: initialized ? VoiceInputStatus.ready : VoiceInputStatus.error,
          errorMessage: initialized ? null : 'Failed to initialize speech recognition',
          hasPermission: hasPermission,
          currentLocale: event.localeId,
        ),
      ));
      
    } catch (e) {
      emit(state.copyWith(
        input: state.input.copyWith(
          status: VoiceInputStatus.error,
          errorMessage: 'Error initializing speech recognition: $e',
        ),
      ));
    }
  }
  
  Future<void> _onVoiceInputStartListening(VoiceInputStartListeningEvent event, Emitter<VoiceState> emit) async {
    try {
      if (state.input.status == VoiceInputStatus.listening) {
        log('VoiceBloc: Already listening');
        return;
      }
      
      emit(state.copyWith(
        input: state.input.copyWith(
          status: VoiceInputStatus.listening,
          partialTranscript: '',
          finalTranscript: '',
          errorMessage: null,
        ),
      ));
      
      await _sttService.start(
        onPartial: (transcript) => add(VoiceInputPartialTranscriptEvent(transcript)),
        onFinal: (transcript) => add(VoiceInputFinalTranscriptEvent(transcript)),
        onError: (error) => add(VoiceInputErrorEvent(error)),
        pauseFor: event.pauseFor,
      );
      
    } catch (e) {
      add(VoiceInputErrorEvent('Error starting speech recognition: $e'));
    }
  }
  
  Future<void> _onVoiceInputStopListening(VoiceInputStopListeningEvent event, Emitter<VoiceState> emit) async {
    try {
      await _sttService.stop();
      
      emit(state.copyWith(
        input: state.input.copyWith(
          status: VoiceInputStatus.completed,
        ),
      ));
      
    } catch (e) {
      add(VoiceInputErrorEvent('Error stopping speech recognition: $e'));
    }
  }
  
  Future<void> _onVoiceInputCancel(VoiceInputCancelEvent event, Emitter<VoiceState> emit) async {
    try {
      await _sttService.cancel();
      
      emit(state.copyWith(
        input: state.input.copyWith(
          status: VoiceInputStatus.ready,
          partialTranscript: '',
          finalTranscript: '',
        ),
      ));
      
    } catch (e) {
      add(VoiceInputErrorEvent('Error canceling speech recognition: $e'));
    }
  }
  
  void _onVoiceInputPartialTranscript(VoiceInputPartialTranscriptEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      input: state.input.copyWith(
        status: VoiceInputStatus.processing,
        partialTranscript: event.transcript,
      ),
    ));
  }
  
  void _onVoiceInputFinalTranscript(VoiceInputFinalTranscriptEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      input: state.input.copyWith(
        status: VoiceInputStatus.completed,
        finalTranscript: event.transcript,
        partialTranscript: '',
        confidenceLevel: event.confidence,
      ),
    ));
  }
  
  void _onVoiceInputError(VoiceInputErrorEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      input: state.input.copyWith(
        status: VoiceInputStatus.error,
        errorMessage: event.error,
      ),
    ));
  }
  
  void _onVoiceInputClearError(VoiceInputClearErrorEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      input: state.input.clearError(),
    ));
  }
  
  void _onVoiceInputClearTranscripts(VoiceInputClearTranscriptsEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      input: state.input.clearTranscripts(),
    ));
  }
  
  Future<void> _onVoiceInputRequestPermission(VoiceInputRequestPermissionEvent event, Emitter<VoiceState> emit) async {
    try {
      final hasPermission = await _sttService.requestPermission();
      
      emit(state.copyWith(
        input: state.input.copyWith(
          hasPermission: hasPermission,
          errorMessage: hasPermission ? null : 'Microphone permission denied',
          status: hasPermission ? VoiceInputStatus.ready : VoiceInputStatus.error,
        ),
      ));
      
    } catch (e) {
      emit(state.copyWith(
        input: state.input.copyWith(
          status: VoiceInputStatus.error,
          errorMessage: 'Error requesting permission: $e',
        ),
      ));
    }
  }
  
  // Voice Output event handlers
  
  Future<void> _onVoiceOutputInitialize(VoiceOutputInitializeEvent event, Emitter<VoiceState> emit) async {
    try {
      final initialized = await _ttsService.initialize();
      
      emit(state.copyWith(
        output: state.output.copyWith(
          status: initialized ? VoiceOutputStatus.ready : VoiceOutputStatus.error,
          errorMessage: initialized ? null : 'Failed to initialize text-to-speech',
        ),
      ));
      
    } catch (e) {
      emit(state.copyWith(
        output: state.output.copyWith(
          status: VoiceOutputStatus.error,
          errorMessage: 'Error initializing text-to-speech: $e',
        ),
      ));
    }
  }
  
  Future<void> _onVoiceOutputSpeak(VoiceOutputSpeakEvent event, Emitter<VoiceState> emit) async {
    try {
      emit(state.copyWith(
        output: state.output.copyWith(
          currentText: event.text,
          errorMessage: null,
        ),
      ));
      
      await _ttsService.speak(
        event.text,
        queueMode: event.queueMode,
        onStart: () => add(const VoiceOutputStartedEvent()),
        onComplete: () => add(const VoiceOutputCompletedEvent()),
        onError: (error) => add(VoiceOutputErrorEvent(error)),
      );
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error speaking text: $e'));
    }
  }
  
  Future<void> _onVoiceOutputStop(VoiceOutputStopEvent event, Emitter<VoiceState> emit) async {
    try {
      await _ttsService.stop();
      
      emit(state.copyWith(
        output: state.output.copyWith(
          status: VoiceOutputStatus.ready,
          currentText: '',
        ),
      ));
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error stopping speech: $e'));
    }
  }
  
  Future<void> _onVoiceOutputPause(VoiceOutputPauseEvent event, Emitter<VoiceState> emit) async {
    try {
      await _ttsService.pause();
      
      emit(state.copyWith(
        output: state.output.copyWith(status: VoiceOutputStatus.paused),
      ));
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error pausing speech: $e'));
    }
  }
  
  Future<void> _onVoiceOutputResume(VoiceOutputResumeEvent event, Emitter<VoiceState> emit) async {
    try {
      await _ttsService.resume();
      
      emit(state.copyWith(
        output: state.output.copyWith(status: VoiceOutputStatus.speaking),
      ));
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error resuming speech: $e'));
    }
  }
  
  Future<void> _onVoiceOutputSetSpeechRate(VoiceOutputSetSpeechRateEvent event, Emitter<VoiceState> emit) async {
    try {
      await _ttsService.setSpeechRate(event.rate);
      
      emit(state.copyWith(
        output: state.output.copyWith(speechRate: event.rate),
      ));
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error setting speech rate: $e'));
    }
  }
  
  Future<void> _onVoiceOutputSetVolume(VoiceOutputSetVolumeEvent event, Emitter<VoiceState> emit) async {
    try {
      await _ttsService.setVolume(event.volume);
      
      emit(state.copyWith(
        output: state.output.copyWith(volume: event.volume),
      ));
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error setting volume: $e'));
    }
  }
  
  Future<void> _onVoiceOutputSetPitch(VoiceOutputSetPitchEvent event, Emitter<VoiceState> emit) async {
    try {
      await _ttsService.setPitch(event.pitch);
      
      emit(state.copyWith(
        output: state.output.copyWith(pitch: event.pitch),
      ));
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error setting pitch: $e'));
    }
  }
  
  Future<void> _onVoiceOutputSetLanguage(VoiceOutputSetLanguageEvent event, Emitter<VoiceState> emit) async {
    try {
      await _ttsService.setLanguage(event.languageCode);
      
      emit(state.copyWith(
        output: state.output.copyWith(currentLanguage: event.languageCode),
      ));
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error setting language: $e'));
    }
  }
  
  Future<void> _onVoiceOutputSetVoice(VoiceOutputSetVoiceEvent event, Emitter<VoiceState> emit) async {
    try {
      await _ttsService.setVoice(event.voiceName);
      
      emit(state.copyWith(
        output: state.output.copyWith(currentVoice: event.voiceName),
      ));
      
    } catch (e) {
      add(VoiceOutputErrorEvent('Error setting voice: $e'));
    }
  }
  
  void _onVoiceOutputStarted(VoiceOutputStartedEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      output: state.output.copyWith(status: VoiceOutputStatus.speaking),
    ));
  }
  
  void _onVoiceOutputCompleted(VoiceOutputCompletedEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      output: state.output.copyWith(
        status: VoiceOutputStatus.completed,
        currentText: '',
      ),
    ));
  }
  
  void _onVoiceOutputError(VoiceOutputErrorEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      output: state.output.copyWith(
        status: VoiceOutputStatus.error,
        errorMessage: event.error,
      ),
    ));
  }
  
  void _onVoiceOutputClearError(VoiceOutputClearErrorEvent event, Emitter<VoiceState> emit) {
    emit(state.copyWith(
      output: state.output.clearError(),
    ));
  }
  
  @override
  Future<void> close() async {
    await _sttService.dispose();
    await _ttsService.dispose();
    return super.close();
  }
}