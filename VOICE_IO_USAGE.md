# Voice I/O Usage Guide

The voice_io package has been successfully integrated into the StrawberryHRM app! Here's how to use it:

## Quick Start

### 1. Using the Pre-built Voice Screen

```dart
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:voice_io/voice_io.dart';

// Navigate to the voice demo screen
void openVoiceScreen(BuildContext context) {
  final voiceScreen = instance.get<VoiceScreenFactory>()();
  Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => voiceScreen)
  );
}
```

### 2. Creating a Custom Voice Integration

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:voice_io/voice_io.dart';

class MyCustomVoiceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VoiceBloc>(
      create: (context) => instance.get<VoiceBlocFactory>()()
        ..add(const VoiceInitializeEvent()),
      child: const VoiceContent(),
    );
  }
}

class VoiceContent extends StatelessWidget {
  const VoiceContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceBloc, VoiceState>(
      builder: (context, state) {
        return Column(
          children: [
            // Voice Input Section
            if (state.input.finalTranscript.isNotEmpty)
              Text('You said: ${state.input.finalTranscript}'),
            
            ElevatedButton(
              onPressed: state.input.hasPermission ? () {
                if (state.input.status == VoiceInputStatus.listening) {
                  context.read<VoiceBloc>().add(const VoiceInputStopListeningEvent());
                } else {
                  context.read<VoiceBloc>().add(const VoiceInputStartListeningEvent());
                }
              } : null,
              child: Text(
                state.input.status == VoiceInputStatus.listening ? 'Stop' : 'Start Listening'
              ),
            ),
            
            // Voice Output Section
            ElevatedButton(
              onPressed: () {
                context.read<VoiceBloc>().add(
                  const VoiceOutputSpeakEvent('Hello, this is a test message!')
                );
              },
              child: const Text('Speak Test Message'),
            ),
          ],
        );
      },
    );
  }
}
```

## Features Available

### Speech-to-Text (STT)
- ✅ Real-time speech recognition
- ✅ Partial and final transcripts
- ✅ Multi-language support
- ✅ Voice activity detection
- ✅ Automatic permission handling

### Text-to-Speech (TTS)
- ✅ High-quality speech synthesis
- ✅ Voice customization (rate, pitch, volume)
- ✅ Multi-language support
- ✅ Playback control (play, pause, stop)
- ✅ Voice selection

### Supported Languages
- English (en_US, en_GB, en_AU)
- Bengali (bn_BD, bn_IN)
- Arabic (ar_SA, ar_EG, ar_AE)
- And many more...

## Integration Examples

### 1. Voice Commands in Chat
```dart
// In chat feature
void _addVoiceInput() {
  final voiceBloc = instance.get<VoiceBlocFactory>()();
  voiceBloc.stream.listen((state) {
    if (state.input.finalTranscript.isNotEmpty) {
      _sendMessage(state.input.finalTranscript);
      voiceBloc.close();
    }
  });
  voiceBloc.add(const VoiceInputStartListeningEvent());
}
```

### 2. Accessibility with TTS
```dart
// Read notifications aloud
void _announceNotification(String message) {
  final voiceBloc = instance.get<VoiceBlocFactory>()();
  voiceBloc.add(VoiceOutputSpeakEvent(message));
}
```

### 3. Voice-Controlled Navigation
```dart
// Voice navigation commands
void _handleVoiceCommands(String transcript) {
  final lowerTranscript = transcript.toLowerCase();
  
  if (lowerTranscript.contains('go to home')) {
    Navigator.pushNamed(context, '/home');
  } else if (lowerTranscript.contains('open attendance')) {
    Navigator.pushNamed(context, '/attendance');
  } else if (lowerTranscript.contains('show reports')) {
    Navigator.pushNamed(context, '/reports');
  }
  
  // Provide voice feedback
  final voiceBloc = instance.get<VoiceBlocFactory>()();
  voiceBloc.add(VoiceOutputSpeakEvent('Navigating to $transcript'));
}
```

## Error Handling

```dart
BlocListener<VoiceBloc, VoiceState>(
  listener: (context, state) {
    // Handle STT errors
    if (state.input.status == VoiceInputStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.input.errorMessage ?? 'Speech error')),
      );
    }
    
    // Handle TTS errors
    if (state.output.status == VoiceOutputStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.output.errorMessage ?? 'Speech error')),
      );
    }
  },
  child: YourWidget(),
)
```

## Platform Setup

### Android Permissions
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS Permissions
Add to `ios/Runner/Info.plist`:
```xml
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access for voice recognition</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>This app needs speech recognition for voice commands</string>
```

## Advanced Configuration

### Custom Voice Settings
```dart
// Configure TTS settings
context.read<VoiceBloc>()
  ..add(const VoiceOutputSetSpeechRateEvent(0.8)) // Faster speech
  ..add(const VoiceOutputSetVolumeEvent(0.9))     // Higher volume
  ..add(const VoiceOutputSetPitchEvent(1.2))      // Higher pitch
  ..add(const VoiceOutputSetLanguageEvent('en-US')); // English US
```

### Custom STT Settings
```dart
// Start listening with custom timeout
context.read<VoiceBloc>().add(
  const VoiceInputStartListeningEvent(
    pauseFor: Duration(seconds: 5), // Wait 5 seconds of silence
  ),
);
```

The voice I/O functionality is now ready to enhance your HRM app with powerful voice interactions! 🎤🔊