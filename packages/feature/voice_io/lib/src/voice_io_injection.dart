import 'package:core/core.dart';

import 'application/voice_bloc.dart';
import 'data/stt_service_impl.dart';
import 'data/tts_service_impl.dart';
import 'domain/stt_service.dart';
import 'domain/tts_service.dart';

/// Dependency injection setup for voice_io package
class VoiceIOInjection {
  Future<void> initInjection() async {
    // Register STT service
    instance.registerLazySingleton<STTService>(
      () => STTServiceImpl(),
    );
    
    // Register TTS service  
    instance.registerLazySingleton<TTSService>(
      () => TTSServiceImpl(),
    );
    
    // Register Voice BLoC factory
    instance.registerFactory<VoiceBlocFactory>(
      () => () => VoiceBloc(
        sttService: instance(),
        ttsService: instance(),
      ),
    );
  }
}

/// Factory typedef for VoiceBloc
typedef VoiceBlocFactory = VoiceBloc Function();