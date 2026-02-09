# Voice I/O Package 🎤🔊

A comprehensive Flutter package for Speech-to-Text (STT) and Text-to-Speech (TTS) functionality with clean architecture and BLoC state management.

## Features

### 🎤 Speech-to-Text (STT)
- **Real-time Transcription** - Live partial and final transcripts
- **Permission Management** - Automatic microphone permission handling
- **Multi-language Support** - Supports multiple speech recognition locales
- **Voice Activity Detection** - Auto-stop on silence with configurable timeout
- **Error Handling** - Comprehensive error reporting and recovery

### 🔊 Text-to-Speech (TTS)
- **Natural Speech** - High-quality text-to-speech synthesis
- **Voice Customization** - Adjustable rate, pitch, and volume
- **Multi-language Support** - Support for multiple TTS languages and voices
- **Queue Management** - Support for queued or interrupted speech
- **Playback Control** - Play, pause, stop, and resume functionality

### 🏗️ Architecture
- **Clean Architecture** - Separation of domain, data, and application layers
- **BLoC State Management** - Reactive state management with flutter_bloc
- **Dependency Injection** - Modular dependency injection setup
- **Testable Design** - Abstract interfaces for easy testing and mocking

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  voice_io:
    path: packages/feature/voice_io
```

## Usage

### 1. Initialize Dependencies

```dart
import 'package:voice_io/voice_io.dart';

// Register voice I/O dependencies
VoiceIOInjection.registerDependencies();
```

### 2. Basic Usage with Dependency Injection

The package follows the project's standard dependency injection pattern:

```dart
import 'package:flutter/material.dart';
import 'package:voice_io/voice_io.dart';
import 'package:core/core.dart';

// Use the factory method to create the screen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: instance.get<VoiceScreenFactory>()(),
    );
  }
}

// Or create your own screen with VoiceBloc
class CustomVoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VoiceBloc>(
      create: (context) => instance.get<VoiceBlocFactory>()()
        ..add(const VoiceInitializeEvent()),
      child: const CustomVoiceView(),
    );
  }
}

class VoiceView extends StatelessWidget {
  const VoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice I/O')),
      body: BlocBuilder<VoiceBloc, VoiceState>(
        builder: (context, state) {
          return Column(
            children: [
              // STT Section
              _buildSTTSection(context, state),
              const Divider(),
              // TTS Section
              _buildTTSSection(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSTTSection(BuildContext context, VoiceState state) {
    return Column(
      children: [
        const Text('Speech to Text', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        // Transcript display
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.input.partialTranscript.isNotEmpty)
                Text('Partial: ${state.input.partialTranscript}', 
                     style: const TextStyle(color: Colors.grey)),
              if (state.input.finalTranscript.isNotEmpty)
                Text('Final: ${state.input.finalTranscript}', 
                     style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: state.input.status == VoiceInputStatus.listening ? null : () {
                context.read<VoiceBloc>().add(const VoiceInputStartListeningEvent());
              },
              child: const Text('Start Listening'),
            ),
            ElevatedButton(
              onPressed: state.input.status != VoiceInputStatus.listening ? null : () {
                context.read<VoiceBloc>().add(const VoiceInputStopListeningEvent());
              },
              child: const Text('Stop'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<VoiceBloc>().add(const VoiceInputClearTranscriptsEvent());
              },
              child: const Text('Clear'),
            ),
          ],
        ),
        
        // Status indicator
        Text('Status: ${state.input.status.name}'),
        if (state.input.errorMessage != null)
          Text('Error: ${state.input.errorMessage}', 
               style: const TextStyle(color: Colors.red)),
      ],
    );
  }

  Widget _buildTTSSection(BuildContext context, VoiceState state) {
    final textController = TextEditingController();
    
    return Column(
      children: [
        const Text('Text to Speech', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        // Text input
        TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Text to speak',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        
        const SizedBox(height: 16),
        
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: state.output.status == VoiceOutputStatus.speaking ? null : () {
                final text = textController.text.trim();
                if (text.isNotEmpty) {
                  context.read<VoiceBloc>().add(VoiceOutputSpeakEvent(text));
                }
              },
              child: const Text('Speak'),
            ),
            ElevatedButton(
              onPressed: state.output.status != VoiceOutputStatus.speaking ? null : () {
                context.read<VoiceBloc>().add(const VoiceOutputPauseEvent());
              },
              child: const Text('Pause'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<VoiceBloc>().add(const VoiceOutputStopEvent());
              },
              child: const Text('Stop'),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Settings
        Row(
          children: [
            const Text('Speed: '),
            Expanded(
              child: Slider(
                value: state.output.speechRate,
                min: 0.1,
                max: 1.0,
                divisions: 9,
                label: state.output.speechRate.toStringAsFixed(1),
                onChanged: (value) {
                  context.read<VoiceBloc>().add(VoiceOutputSetSpeechRateEvent(value));
                },
              ),
            ),
          ],
        ),
        
        // Status indicator
        Text('Status: ${state.output.status.name}'),
        if (state.output.errorMessage != null)
          Text('Error: ${state.output.errorMessage}', 
               style: const TextStyle(color: Colors.red)),
      ],
    );
  }
}
```

### 3. Advanced Usage

#### Custom Configuration
```dart
// Initialize with specific locale
context.read<VoiceBloc>().add(const VoiceInitializeEvent(localeId: 'en_US'));

// Set custom pause duration for STT
context.read<VoiceBloc>().add(
  const VoiceInputStartListeningEvent(pauseFor: Duration(seconds: 2))
);

// Configure TTS settings
context.read<VoiceBloc>()
  ..add(const VoiceOutputSetSpeechRateEvent(0.7))
  ..add(const VoiceOutputSetVolumeEvent(0.8))
  ..add(const VoiceOutputSetPitchEvent(1.2))
  ..add(const VoiceOutputSetLanguageEvent('en-US'));
```

#### Permission Handling
```dart
// Check and request permissions
if (!state.input.hasPermission) {
  context.read<VoiceBloc>().add(const VoiceInputRequestPermissionEvent());
}
```

#### Error Handling
```dart
BlocListener<VoiceBloc, VoiceState>(
  listener: (context, state) {
    if (state.input.status == VoiceInputStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.input.errorMessage ?? 'Unknown error')),
      );
    }
  },
  child: YourWidget(),
)
```

## Supported Languages

### STT Languages
The package supports all languages provided by the underlying speech recognition service. Common languages include:
- English (en_US, en_GB, en_AU)
- Bengali (bn_BD, bn_IN)
- Arabic (ar_SA, ar_EG, ar_AE)
- Spanish (es_ES, es_MX)
- French (fr_FR, fr_CA)
- German (de_DE)
- Hindi (hi_IN)
- And many more...

### TTS Languages
TTS language support depends on the platform and installed voices:
- English: en-US, en-GB, en-AU
- Bengali: bn-BD, bn-IN
- Arabic: ar-SA, ar-EG
- Spanish: es-ES, es-MX
- French: fr-FR, fr-CA
- German: de-DE
- Hindi: hi-IN

## Platform Support

| Platform | STT | TTS | Notes |
|----------|-----|-----|-------|
| Android  | ✅   | ✅   | Full support |
| iOS      | ✅   | ✅   | Full support |
| Web      | ⚠️   | ✅   | Limited STT support |
| Desktop  | ❌   | ✅   | TTS only |

## Permissions

### Android
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs access to microphone for speech recognition</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>This app needs access to speech recognition for voice input</string>
```

## Testing

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voice_io/voice_io.dart';

class MockSTTService extends Mock implements STTService {}
class MockTTSService extends Mock implements TTSService {}

void main() {
  group('VoiceBloc', () {
    late VoiceBloc voiceBloc;
    late MockSTTService mockSTTService;
    late MockTTSService mockTTSService;

    setUp(() {
      mockSTTService = MockSTTService();
      mockTTSService = MockTTSService();
      voiceBloc = VoiceBloc(
        sttService: mockSTTService,
        ttsService: mockTTSService,
      );
    });

    tearDown(() {
      voiceBloc.close();
    });

    test('initial state is VoiceState with default values', () {
      expect(voiceBloc.state, const VoiceState());
    });

    blocTest<VoiceBloc, VoiceState>(
      'emits initialized state when VoiceInitializeEvent is added',
      build: () {
        when(() => mockSTTService.initialize()).thenAnswer((_) async => true);
        when(() => mockSTTService.hasPermission()).thenAnswer((_) async => true);
        when(() => mockTTSService.initialize()).thenAnswer((_) async => true);
        return voiceBloc;
      },
      act: (bloc) => bloc.add(const VoiceInitializeEvent()),
      expect: () => [
        isA<VoiceState>()
            .having((s) => s.isInitialized, 'isInitialized', true)
            .having((s) => s.input.status, 'input.status', VoiceInputStatus.ready)
            .having((s) => s.output.status, 'output.status', VoiceOutputStatus.ready),
      ],
    );
  });
}
```

## Architecture

```
lib/
├── src/
│   ├── domain/              # Business logic layer
│   │   ├── stt_service.dart         # STT abstract interface
│   │   ├── tts_service.dart         # TTS abstract interface
│   │   ├── speech_locale.dart       # Speech locale model
│   │   └── voice_state.dart         # Immutable state models
│   ├── data/                # Data implementation layer
│   │   ├── stt_service_impl.dart    # STT concrete implementation
│   │   └── tts_service_impl.dart    # TTS concrete implementation
│   ├── application/         # Application layer
│   │   ├── voice_bloc.dart          # Voice BLoC
│   │   └── voice_event.dart         # Voice events
│   └── voice_io_injection.dart      # Dependency injection
└── voice_io.dart           # Public API exports
```

## Contributing

This package follows the project's coding standards and architecture patterns. Please ensure all changes include appropriate tests and documentation.

## License

This package is part of the StrawberryHRM project. All rights reserved.