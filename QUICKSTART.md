# Quick Start Guide - Guitar Practice App

## Prerequisites Checklist

Before running the app, ensure you have:

- ✅ Flutter SDK 3.2.0 or higher
- ✅ Android Studio or VS Code with Flutter extensions
- ✅ Android device or emulator (API level 21+)
- ✅ PowerShell (for Windows)

## Step-by-Step Setup

### 1. Verify Flutter Installation

```powershell
flutter doctor
```

Expected output should show:
- ✓ Flutter SDK
- ✓ Android toolchain
- ✓ VS Code or Android Studio

### 2. Navigate to Project

```powershell
cd "s:\Guitar App"
```

### 3. Install Dependencies

```powershell
flutter pub get
```

This will download:
- flutter_riverpod (state management)
- audioplayers (audio playback)
- shared_preferences (local storage)
- google_fonts (typography)
- equatable (value comparison)

### 4. Verify Project Structure

```powershell
ls
```

You should see:
- lib/
- assets/
- pubspec.yaml
- README.md

### 5. Check for Errors

```powershell
flutter analyze
```

Should return: "No issues found!"

### 6. Run the App

**On a connected device:**
```powershell
flutter devices
flutter run
```

**On a specific device:**
```powershell
flutter run -d <device-id>
```

**In release mode (faster):**
```powershell
flutter run --release
```

## Common Issues & Solutions

### Issue: "Flutter not recognized"
**Solution:** Add Flutter to PATH environment variable

### Issue: "No devices found"
**Solution:** 
- Enable USB debugging on Android device
- Or start Android emulator from Android Studio

### Issue: "Gradle build failed"
**Solution:**
```powershell
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "Audio not playing"
**Solution:** 
- The app uses haptic feedback as fallback
- To add real audio, see `assets/sounds/README.md`

## Build APK for Distribution

### Debug APK (for testing)
```powershell
flutter build apk --debug
```

### Release APK (optimized)
```powershell
flutter build apk --release
```

APK location: `build/app/outputs/flutter-apk/app-release.apk`

### App Bundle (for Play Store)
```powershell
flutter build appbundle --release
```

## Hot Reload During Development

While app is running:
- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

## Testing Features

After launching the app:

1. **Test Metronome**
   - Tap "Metronome" on home screen
   - Set BPM to 80
   - Press "Start"
   - Should feel haptic vibration on each beat

2. **Test Chord Trainer**
   - Tap "Random Chord Trainer"
   - Select 3-4 chords (C, G, D, Am)
   - Set BPM to 60, Bars to 8
   - Press "Start Training"
   - Chords should change every 4 beats

3. **Test Strumming**
   - Tap "Strumming Patterns"
   - Select "Easy" difficulty
   - Press "Generate New Pattern"
   - Pattern should show D/U/- symbols

4. **Test Exercises**
   - Tap "Finger Exercises"
   - Select "Spider Exercise"
   - Read instructions
   - Press "Start Practice"

## Project Structure Overview

```
lib/
├── main.dart                    # App entry point
├── core/
│   ├── theme/                   # Colors, typography
│   ├── models/                  # Data models
│   ├── widgets/                 # Reusable UI components
│   ├── services/                # Business logic
│   ├── data/                    # Repositories
│   └── providers/               # State management
└── features/
    ├── home/                    # Home navigation
    ├── exercises/               # Finger exercises
    ├── chords/                  # Chord library
    ├── chord_trainer/           # Random chord trainer
    ├── strumming/               # Strumming patterns
    ├── metronome/               # Metronome
    └── settings/                # Settings
```

## Performance Tips

- Run in **release mode** for production testing
- Use **--profile** flag to check performance
- Avoid running with debugger for accurate timing

```powershell
flutter run --profile
```

## Next Steps

1. ✅ Run the app successfully
2. ✅ Test all features
3. ⚠️ Add audio files (optional, see assets/sounds/README.md)
4. ✅ Build release APK
5. ✅ Install on physical device
6. ✅ Practice guitar! 🎸

## Support

For Flutter issues: https://flutter.dev/docs
For app-specific questions: Check README.md

---

**Happy Coding & Happy Playing! 🎸**
