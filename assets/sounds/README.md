# Audio Assets for Guitar Practice App

This directory should contain the metronome sound files.

## Required Files:

1. **click.mp3** - Regular metronome click sound
2. **accent.mp3** - Accented beat sound (slightly louder/different)

## How to Add Audio Files:

Since this is a text-based generation, you'll need to add actual audio files manually:

### Option 1: Generate Simple Audio Files (Recommended for Testing)
Use any audio editing software like Audacity to create:
- A short click sound (50-100ms)
- A slightly louder/different click for accents

### Option 2: Use Online Resources
Download metronome sounds from:
- FreeSound.org
- ZapSplat.com
- Or record your own clicks

### Option 3: Generate Programmatically
You can generate simple click sounds using code:

```dart
// In the MetronomeEngine, if assets fail to load,
// the app will fall back to HapticFeedback
```

## File Specifications:
- Format: MP3 (or WAV)
- Sample Rate: 44100 Hz
- Bit Depth: 16-bit
- Duration: 50-200ms
- File Size: < 50KB each

## Installation:
1. Create this directory: `assets/sounds/`
2. Add `click.mp3` and `accent.mp3`
3. Ensure pubspec.yaml includes: `assets/sounds/`
4. Run `flutter pub get`

## Fallback Behavior:
If audio files are not found, the app will use haptic feedback (vibration) as a fallback.
