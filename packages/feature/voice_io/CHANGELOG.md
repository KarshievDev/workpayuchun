# Changelog

All notable changes to the voice_io package will be documented in this file.

## [1.0.0] - 2024-08-24

### Added
- Initial release of voice_io package
- Speech-to-Text (STT) functionality with speech_to_text package
- Text-to-Speech (TTS) functionality with flutter_tts package
- Clean architecture with domain, data, and application layers
- BLoC state management with comprehensive state handling
- Real-time speech transcription with partial and final results
- Voice activity detection with configurable silence timeout
- Multi-language support for both STT and TTS
- Permission management for microphone access
- Comprehensive error handling and recovery
- Dependency injection setup with modular architecture
- Voice customization (rate, pitch, volume, language, voice)
- Queue management for TTS playback
- Playback control (play, pause, stop, resume)
- Platform support for Android and iOS
- Comprehensive documentation and examples
- Unit tests with mocking support

### Features
- **STT Features:**
  - Real-time speech recognition
  - Partial and final transcript events
  - Multiple locale support
  - Voice activity detection
  - Microphone permission handling
  - Error recovery mechanisms

- **TTS Features:**
  - High-quality speech synthesis
  - Voice customization options
  - Multi-language support
  - Queue and interrupt modes
  - Playback control
  - Voice selection

- **Architecture:**
  - Clean architecture principles
  - BLoC state management
  - Dependency injection
  - Testable design
  - Modular package structure

### Technical Details
- Minimum Flutter version: 3.7.0
- Minimum Dart version: 3.7.0
- Supported platforms: Android, iOS (primary), Web (limited), Desktop (TTS only)
- Dependencies: flutter_bloc, speech_to_text, flutter_tts, permission_handler
- State management: Immutable states with Equatable
- Error handling: Comprehensive error states and recovery
- Permissions: Automatic permission request and status tracking

### Documentation
- Complete API documentation
- Usage examples and code samples
- Architecture overview
- Platform-specific setup instructions
- Testing guidelines
- Internationalization support