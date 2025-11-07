# Build & Test Instructions for Synapse Monitor

## Prerequisites

### Required Software
1. **Flutter SDK** (version 3.0.0 or higher)
   ```bash
   flutter --version
   ```
   If not installed: https://docs.flutter.dev/get-started/install

2. **Dart SDK** (comes with Flutter)
   ```bash
   dart --version
   ```

3. **Git** (for version control)
   ```bash
   git --version
   ```

### IDE (Choose one)
- **VS Code** with Flutter extension
- **Android Studio** with Flutter plugin
- **IntelliJ IDEA** with Flutter plugin

### Platform-Specific Requirements

#### For Android Development
- Android Studio
- Android SDK (API level 21+)
- Android Emulator or physical device

#### For iOS Development (macOS only)
- Xcode (latest version)
- CocoaPods
- iOS Simulator or physical device

#### For Web Development
- Chrome browser

## Initial Setup

### 1. Clone & Navigate
```bash
git clone https://github.com/kluth/synapse-monitor-mobile.git
cd synapse-monitor-mobile
```

### 2. Install Dependencies
```bash
flutter pub get
```

This will install all packages defined in `pubspec.yaml`.

### 3. Verify Flutter Installation
```bash
flutter doctor
```

Fix any issues reported by `flutter doctor` before proceeding.

### 4. Configure Environment
The `.env` file is already created with development defaults. You can modify it if needed:
```bash
# Edit .env file
nano .env
```

## Building the Project

### Generate Code (Required)
Since we use code generation for Freezed, JSON serialization, and Riverpod, you need to generate code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Note**: You may see warnings about missing models since we haven't implemented the data layer yet. This is expected.

### Build for Different Platforms

#### Android
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# App bundle (for Play Store)
flutter build appbundle --release
```

#### iOS (macOS only)
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release
```

#### Web
```bash
# Debug build
flutter build web

# Release build
flutter build web --release
```

#### Desktop (Linux/macOS/Windows)
```bash
# Linux
flutter build linux

# macOS
flutter build macos

# Windows
flutter build windows
```

## Running the Project

### Run on Connected Device/Emulator
```bash
# List available devices
flutter devices

# Run on default device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run in release mode
flutter run --release
```

### Platform-Specific Run Commands

#### Android Emulator
```bash
# List emulators
emulator -list-avds

# Start emulator
emulator -avd <avd_name>

# Run app
flutter run
```

#### iOS Simulator (macOS)
```bash
# List simulators
xcrun simctl list devices

# Open simulator
open -a Simulator

# Run app
flutter run
```

#### Web
```bash
# Run on Chrome
flutter run -d chrome

# Run on specific port
flutter run -d web-server --web-port=8080
```

## Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/unit/core/network/dio_client_test.dart
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### View Coverage Report
```bash
# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open in browser (Linux/macOS)
open coverage/html/index.html
```

### Run Widget Tests
```bash
flutter test test/widget/
```

### Run Integration Tests
```bash
# On device/emulator
flutter test integration_test/
```

## Code Quality Checks

### Analyze Code
```bash
flutter analyze
```

This checks for:
- Linting errors
- Code style issues
- Potential bugs
- Best practice violations

### Format Code
```bash
# Check formatting
dart format --set-exit-if-changed .

# Format all files
dart format .

# Format specific file
dart format lib/main.dart
```

## Development Workflow

### Watch Mode for Code Generation
When developing, keep this running to auto-generate code:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Hot Reload During Development
When running the app:
- Press `r` for hot reload
- Press `R` for hot restart
- Press `q` to quit

### Debug in IDE

#### VS Code
1. Open project in VS Code
2. Press `F5` or click "Run and Debug"
3. Select target device
4. Set breakpoints by clicking left of line numbers

#### Android Studio
1. Open project in Android Studio
2. Click the green play button
3. Select target device
4. Use debugger panel for breakpoints

## Troubleshooting

### "Package not found" errors
```bash
flutter clean
flutter pub get
```

### Code generation issues
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Platform-specific issues

#### Android
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### iOS
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

### Cache issues
```bash
flutter pub cache repair
```

## Current Project Status

### ✅ Implemented (Ready to Build)
1. **Core Infrastructure**
   - Network layer (Dio HTTP + WebSocket)
   - Theme system (Light/Dark)
   - Utilities (Logger, Formatters, Validators)
   - Core widgets (Loading, Error, Empty states)

2. **Domain Layer**
   - 15 entities with business logic
   - 4 repository interfaces
   - 19 use cases

3. **Entry Point**
   - main.dart with placeholder screen
   - Dependency injection setup
   - Environment configuration

### 🚧 Not Yet Implemented (Will cause warnings)
1. **Data Layer**
   - Models (Freezed classes)
   - Data sources (API clients)
   - Repository implementations

2. **Presentation Layer**
   - Riverpod providers
   - Screens
   - Feature-specific widgets

3. **Tests**
   - Unit tests
   - Widget tests
   - Integration tests

### Expected Warnings
When you run `flutter pub run build_runner build`, you'll see:
- No code to generate (no Freezed models yet)
- No JSON serialization targets

**This is normal!** The domain layer is complete and testable. The data and presentation layers are next.

## Build Verification

To verify the build works:

```bash
# 1. Clean everything
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Try to build (this will work even without data layer)
flutter run -d chrome
```

You should see the placeholder screen with the Synapse Monitor logo and status checklist.

## Next Steps for Development

1. Implement data layer (models, data sources, repositories)
2. Implement presentation layer (providers, screens, widgets)
3. Write tests following TDD
4. Connect to actual Synapse Framework backend
5. Deploy to app stores

## Need Help?

- Check Flutter docs: https://docs.flutter.dev
- Check issues: https://github.com/kluth/synapse-monitor-mobile/issues
- Review CONTRIBUTING.md for development guidelines
- Review ARCHITECTURE.md for system design

---

**Last Updated**: 2025-11-07
**Project Status**: Phase 3 Complete (Domain Layer)
