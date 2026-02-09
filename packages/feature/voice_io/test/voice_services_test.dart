import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_io/voice_io.dart';

void main() {
  group('Voice Services Instantiation', () {
    setUpAll(() {
      // Initialize Flutter binding for tests
      WidgetsFlutterBinding.ensureInitialized();
    });

    test('STTServiceImpl can be instantiated', () {
      expect(() => STTServiceImpl(), returnsNormally);
    });

    test('TTSServiceImpl can be instantiated', () {
      expect(() => TTSServiceImpl(), returnsNormally);
    });

    test('VoiceServiceInitializer can be instantiated', () {
      expect(() => VoiceServiceInitializer(), returnsNormally);
    });

    test('VoiceBloc can be instantiated', () {
      final sttService = STTServiceImpl();
      final ttsService = TTSServiceImpl();
      
      expect(
        () => VoiceBloc(sttService: sttService, ttsService: ttsService),
        returnsNormally,
      );
    });
  });
}