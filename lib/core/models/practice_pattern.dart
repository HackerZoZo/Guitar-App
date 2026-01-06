import 'package:equatable/equatable.dart';
import 'chord.dart';
import 'time_signature.dart';

// Re-export ChordCategory from chord.dart for backward compatibility
export 'chord.dart' show ChordCategory;

/// Practice mode: how chords and patterns interact
enum PracticeMode {
  /// Same pattern, different chords each generation
  practice,

  /// Both pattern and chords change together
  jam,

  /// Same chords, different patterns
  grooveExploration,
}

/// Simple stroke for clean output (D, U, X only)
class PracticeStroke extends Equatable {
  final String symbol; // 'D', 'U', or 'X'
  final int position; // Position in pattern

  const PracticeStroke({
    required this.symbol,
    required this.position,
  });

  @override
  List<Object?> get props => [symbol, position];
}

/// Configuration for practice generation
class PracticeConfig extends Equatable {
  final Difficulty difficulty;
  final TimeSignature timeSignature;
  final int bpm;
  final int numBars; // 1, 2, or 4
  final PracticeMode mode;
  final Set<ChordCategory> chordCategories;
  final List<String>? customChords; // For custom mode

  const PracticeConfig({
    this.difficulty = Difficulty.beginner,
    this.timeSignature = TimeSignature.time4_4,
    this.bpm = 80,
    this.numBars = 1,
    this.mode = PracticeMode.jam,
    this.chordCategories = const {ChordCategory.major},
    this.customChords,
  });

  PracticeConfig copyWith({
    Difficulty? difficulty,
    TimeSignature? timeSignature,
    int? bpm,
    int? numBars,
    PracticeMode? mode,
    Set<ChordCategory>? chordCategories,
    List<String>? customChords,
  }) {
    return PracticeConfig(
      difficulty: difficulty ?? this.difficulty,
      timeSignature: timeSignature ?? this.timeSignature,
      bpm: bpm ?? this.bpm,
      numBars: numBars ?? this.numBars,
      mode: mode ?? this.mode,
      chordCategories: chordCategories ?? this.chordCategories,
      customChords: customChords ?? this.customChords,
    );
  }

  @override
  List<Object?> get props => [
        difficulty,
        timeSignature,
        bpm,
        numBars,
        mode,
        chordCategories,
        customChords,
      ];
}

/// A complete practice pattern with chords and strumming
class PracticePattern extends Equatable {
  final List<String> chords; // One chord per bar
  final List<PracticeStroke> strokes; // Full pattern
  final PracticeConfig config;
  final int numBars;

  const PracticePattern({
    required this.chords,
    required this.strokes,
    required this.config,
    required this.numBars,
  });

  /// Get strokes per bar
  int get strokesPerBar => strokes.length ~/ numBars;

  /// Get display format: chords on top, pattern below
  String getDisplay() {
    final strokesPerBar = this.strokesPerBar;
    final chordSpacing =
        strokesPerBar * 2; // Space for each stroke symbol + space

    // Build chord line
    final chordLine = chords.map((chord) {
      // Left-pad chord name to center it over the bar
      return chord.padRight(chordSpacing);
    }).join('');

    // Build pattern line
    final patternLine = strokes.map((s) => s.symbol).join(' ');

    return '$chordLine\n$patternLine';
  }

  /// Get strokes for a specific bar (0-indexed)
  List<PracticeStroke> getStrokesForBar(int barIndex) {
    final start = barIndex * strokesPerBar;
    final end = (barIndex + 1) * strokesPerBar;
    return strokes.sublist(start, end.clamp(0, strokes.length));
  }

  @override
  List<Object?> get props => [chords, strokes, config, numBars];
}
