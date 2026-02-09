library voice_io;

// Domain exports
export 'src/domain/stt_service.dart';
export 'src/domain/tts_service.dart';
export 'src/domain/speech_locale.dart';
export 'src/domain/voice_state.dart';

// Application exports
export 'src/application/voice_bloc.dart';
export 'src/application/voice_event.dart';
export 'src/application/chat/chat_bloc.dart';
export 'src/application/chat/chat_event.dart';
export 'src/application/chat/chat_state.dart';

// Data exports (for testing and advanced usage)
export 'src/data/stt_service_impl.dart';
export 'src/data/tts_service_impl.dart';
export 'src/data/voice_service_initializer.dart';
export 'src/data/models/chat_message.dart';
export 'src/data/repositories/chat_repository.dart';
export 'src/data/services/ai_service.dart';

// Presentation exports
export 'src/presentation/voice_screen.dart';
export 'src/presentation/widgets/chat_message_widget.dart';
export 'src/presentation/widgets/voice_input_widget.dart';

// Dependency injection
export 'src/voice_io_injection.dart';