# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter-based Human Resource Management (HRM) application called StrawberryHRM. The app provides comprehensive HR functionalities including attendance tracking, leave management, payroll, employee management, and various reporting features.

## Development Commands

### Flutter Commands
- `flutter clean` - Clean build artifacts
- `flutter pub get` - Get dependencies
- `flutter analyze` - Run static analysis
- `flutter test` - Run unit tests
- `flutter build appbundle --release` - Build Android app bundle
- `flutter build ipa --release` - Build iOS app

### Package Management Scripts
- `./scripts/flutter_pub_get.sh` - Get dependencies for all packages
- `./scripts/flutter_clean.sh` - Clean all Flutter projects in packages
- `./scripts/flutter_pub_get_feature.sh` - Get dependencies for feature packages
- `./scripts/flutter_clean_feature.sh` - Clean feature packages

Note: Scripts use `fvm flutter` commands, indicating Flutter Version Management (FVM) is used.

### CI/CD
The project uses Codemagic for CI/CD with workflows defined in `codemagic.yaml`:
- Android workflow builds AAB and deploys to Google Play
- iOS workflow builds IPA and deploys to App Store Connect

## Architecture

### Modular Package Structure
The app follows a clean, modular architecture with packages organized by layer:

#### Core Packages (`packages/`)
- **`core/`** - Shared utilities, constants, models, and widgets
- **`domain/`** - Business logic and use cases
- **`hrm_framework/`** - Framework utilities and services

#### Data Layer (`packages/data/`)
- **`authentication_repository/`** - Authentication services
- **`meta_club_api/`** - Main API service layer
- **`user_repository/`** - User data management
- **`dio_service/`** - HTTP client service

#### Feature Packages (`packages/feature/`)
- **`chat/`** - Chat functionality
- **`location_track/`** - GPS tracking and location services
- **`notification/`** - Push notification handling
- **`qr_attendance/`** - QR code attendance scanning
- **`selfie_attendance/`** - Facial recognition attendance
- **`offline_attendance/`** - Offline attendance storage
- **`offline_location/`** - Offline location tracking

### Main App Structure (`lib/`)
- **`presentation/`** - UI screens organized by feature (attendance, leave, payroll, etc.)
- **`res/`** - Shared resources (widgets, utilities, styling)
- **`routes/`** - Navigation configuration
- **`injection/`** - Dependency injection setup

### State Management
- Uses **BLoC pattern** with flutter_bloc and hydrated_bloc for state persistence
- Individual BLoCs for each feature with separate event/state files

### Key Features
- **Attendance Management** - Multiple check-in methods (GPS, QR code, selfie)
- **Leave Management** - Leave requests, approvals, and reporting
- **Employee Management** - Profiles, phonebook, team management
- **Reporting** - Attendance, leave, and performance reports
- **Document Management** - Document requests and approvals
- **Travel Management** - Travel planning and expense tracking
- **Task Management** - Task assignment and tracking
- **Payroll** - Salary and deduction management

### Firebase Integration
- **Firebase Core** - App initialization
- **Firebase Analytics** - User analytics
- **Firebase Crashlytics** - Crash reporting
- **Firebase Messaging** - Push notifications
- **Firebase Performance** - Performance monitoring
- **Firestore** - Cloud database

### Localization
- Supports English (en-US), Bengali (bn-BN), and Arabic (ar-AR)
- Uses easy_localization package
- Translation files in `assets/translations/`

## Development Guidelines

### Testing
- Unit tests located in `test/` directory
- Uses mocktail for mocking
- bloc_test for BLoC testing
- Run tests with `flutter test`

### Code Analysis
- Uses flutter_lints for Dart/Flutter best practices
- Configuration in `analysis_options.yaml`
- Run analysis with `flutter analyze`

### Platform Support
- **Android** - Full support with Google Services integration
- **iOS** - Full support with CocoaPods dependencies
- **Web** - Basic support
- **macOS/Linux/Windows** - Limited desktop support

### Build Configuration
- Uses build_runner for code generation
- flutter_launcher_icons for app icon generation
- flutter_native_splash for splash screens
- Version management through pubspec.yaml (currently v2.1.1+25)

## Important Files
- `main.dart` - App entry point with Firebase and localization setup
- `pubspec.yaml` - Dependencies and app configuration
- `codemagic.yaml` - CI/CD pipeline configuration
- `analysis_options.yaml` - Code analysis rules