# Guitar Practice App 🎸

A fully offline Android guitar practice application built with Flutter. Clean, minimal, and designed for daily practice with structured exercises, randomization, and rhythm training.

## Features ✨

### 1. **Finger Exercises**
- Spider exercise
- 1-2-3-4 chromatic patterns
- Finger stretching routines
- Speed building exercises
- BPM control with metronome integration
- Detailed instructions and benefits

### 2. **Chords Library**
- Organized by Major, Minor, and Barre chords
- Visual chord diagrams with finger positions
- Difficulty indicators (Beginner/Intermediate/Advanced)
- Practice mode with metronome
- 17+ essential chords included

### 3. **Random Chord Trainer** ⭐
- Select specific chords to practice
- Filter by difficulty level
- Adjustable tempo (40-220 BPM)
- Set number of bars (4-32)
- Real-time chord display with countdown
- Auto-progression synced to metronome

### 4. **Strumming Pattern Generator** ⭐
- Musical pattern generation (D, U, -, ghost notes, mutes)
- Three difficulty levels
- Time signature selection (4/4, 3/4, 6/8)
- Visual pattern display
- Beat highlighting during practice
- Generate new patterns on-the-fly

### 5. **Professional Metronome**
- BPM range: 40-220
- Visual beat indicators
- Accent on beat 1
- Multiple time signatures
- Quick tempo presets
- Global integration with all features

### 6. **Settings & Customization**
- Fully offline operation
- Dark mode by default
- Haptic feedback options
- App information and guides

## Tech Stack 🛠️

- **Framework**: Flutter 3.2+
- **State Management**: Riverpod
- **Audio**: audioplayers package
- **Storage**: shared_preferences (offline-first)
- **UI**: Material Design 3 with custom theme
- **Fonts**: Google Fonts (Manrope)

## Architecture 🏗️

```
lib/
├── core/
│   ├── data/           # Repositories (chords, exercises)
│   ├── models/         # Domain models (Chord, Exercise, Pattern)
│   ├── providers/      # Riverpod state providers
│   ├── services/       # Business logic (MetronomeEngine, Generators)
│   ├── theme/          # App theme, colors, typography
│   └── widgets/        # Reusable UI components
├── features/
│   ├── home/           # Home screen navigation
│   ├── exercises/      # Finger exercises feature
│   ├── chords/         # Chord library feature
│   ├── chord_trainer/  # Random chord trainer
│   ├── strumming/      # Strumming pattern generator
│   ├── metronome/      # Metronome feature
│   └── settings/       # Settings screen
└── main.dart
```

### Design Patterns
- **MVVM**: ViewModel pattern with Riverpod StateNotifiers
- **Repository Pattern**: Data abstraction layer
- **Provider Pattern**: Dependency injection via Riverpod
- **Clean Architecture**: Separation of concerns (data/domain/presentation)

## Installation & Setup 🚀

### Prerequisites
- Flutter SDK 3.2 or higher
- Android Studio / VS Code
- Android device or emulator

### Steps

1. **Clone or navigate to the project**
```bash
cd "s:\Guitar App"
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Add Audio Assets** (Important!)
Create metronome sound files:
- `assets/sounds/click.mp3` - Regular beat
- `assets/sounds/accent.mp3` - Accented beat

See `assets/sounds/README.md` for detailed instructions.

4. **Run the app**
```bash
flutter run
```

## Key Algorithms 🧮

### Random Chord Generator
```dart
// Weighted selection based on difficulty
// Ensures only selected chords appear
// Generates sequence of N bars
// Syncs with metronome beats
```

### Strumming Pattern Generator
```dart
// Grid-based generation (8th or 16th notes)
// Musicality rules:
//   - Accent on beats 1 & 3
//   - Alternating down/up strokes
//   - Syncopation based on difficulty
//   - Ghost notes and mutes for advanced
//   - Validates playability
```

### Metronome Engine
```dart
// Precise timing using Timer.periodic
// Beat stream for synchronization
// Accent handling on beat 1
// Audio playback with fallback to haptics
// BPM range: 40-220 with 5 BPM increments
```

## UI/UX Design Philosophy 🎨

### Color Palette
- **Background**: Deep charcoal (#0E1116)
- **Surface**: Dark gray (#1A1E24)
- **Primary**: Soft teal (#4DD0B5)
- **Text**: High contrast white/gray

### Typography
- **Font**: Manrope (clean, modern, readable)
- **Hierarchy**: Clear size differentiation
- **Readability**: 16-18sp body text

### Layout Principles
- **Thumb-friendly**: Bottom navigation priority
- **Large targets**: Minimum 44dp touch areas
- **Minimal clutter**: Focus on practice
- **Smooth animations**: Professional feel
- **Dark theme**: Reduced eye strain

## Usage Guide 📖

### For Beginners
1. Start with **Finger Exercises** → "1-2-3-4 Chromatic" at 60 BPM
2. Learn basic chords in **Chords** → "Major" tab
3. Use **Metronome** for timing practice
4. Try **Random Chord Trainer** with C, G, D at 60 BPM

### For Intermediate
1. **Spider Exercise** at 80-100 BPM
2. Practice **Barre Chords**
3. **Strumming Patterns** on Medium difficulty
4. **Chord Trainer** with mixed major/minor chords

### For Advanced
1. **Speed Builder** at 120+ BPM
2. Complex **Strumming Patterns** (Advanced)
3. Full chord library practice
4. Chord transitions at performance tempo

## Offline Capabilities 📴

✅ **100% Offline** - No internet required  
✅ All chord data stored locally  
✅ Exercises embedded in app  
✅ Audio assets bundled  
✅ No analytics or tracking  
✅ No external dependencies  

## Performance Optimizations ⚡

- Efficient audio playback with pre-loaded sounds
- Minimal state updates (immutable patterns)
- Lazy loading of chord diagrams
- Optimized custom painters for diagrams
- Stream-based metronome synchronization

## Future Enhancements 🔮

Potential features for future versions:
- [ ] Progress tracking and statistics
- [ ] Custom exercise creation
- [ ] Recording and playback
- [ ] More chord types (sus, add, dim)
- [ ] Scale practice mode
- [ ] Export/import practice routines

## Troubleshooting 🔧

### No metronome sound?
- Ensure audio files are in `assets/sounds/`
- Check `pubspec.yaml` includes assets
- App will fallback to haptic feedback

### App crashes on start?
- Run `flutter clean && flutter pub get`
- Ensure Flutter SDK is up to date

### Chord diagrams not showing?
- This is a rendering issue - check device compatibility
- Try on a different device/emulator

## Contributing 🤝

This is a production-ready template. Feel free to:
- Add more exercises
- Expand chord library
- Improve audio quality
- Enhance UI animations

## License 📄

This is a demonstration project for educational purposes.

## Credits 👏

Built with Flutter and designed for guitar enthusiasts who value:
- Focused practice
- Offline reliability
- Clean, distraction-free UI
- Musical accuracy

---

**Happy Practicing! 🎸🎶**

Practice daily, stay consistent, and watch your guitar skills soar!
