import 'dart:math';
import '../models/chord.dart' show Chord, ChordCategory, Difficulty;
import '../models/practice_pattern.dart';
import '../models/time_signature.dart';
import '../data/chord_repository.dart';

/// Generates realistic, musically coherent practice patterns
/// Combines strumming patterns with chord progressions
class PracticePatternGenerator {
  final ChordRepository _chordRepo;
  final Random _random = Random();

  PracticePatternGenerator(this._chordRepo);

  /// Generate a new practice pattern based on configuration
  PracticePattern generate(PracticeConfig config) {
    // Select chords
    final chords = _selectChords(config);
    
    // Generate strumming pattern
    final strokes = _generateStrummingPattern(config);
    
    return PracticePattern(
      chords: chords,
      strokes: strokes,
      config: config,
      numBars: config.numBars,
    );
  }

  /// Select random chords based on categories
  List<String> _selectChords(PracticeConfig config) {
    List<Chord> availableChords = [];

    // Handle custom chords first
    if (config.customChords != null && config.customChords!.isNotEmpty) {
      return List.generate(
        config.numBars,
        (_) => config.customChords![_random.nextInt(config.customChords!.length)],
      );
    }

    // Build chord pool from selected categories
    if (config.chordCategories.contains(ChordCategory.major)) {
      availableChords.addAll(_chordRepo.getMajorChords());
    }
    if (config.chordCategories.contains(ChordCategory.minor)) {
      availableChords.addAll(_chordRepo.getMinorChords());
    }
    if (config.chordCategories.contains(ChordCategory.barre)) {
      availableChords.addAll(_chordRepo.getBarreChords());
    }
    if (config.chordCategories.contains(ChordCategory.seventh)) {
      availableChords.addAll(_chordRepo.getSeventhChords());
    }
    if (config.chordCategories.contains(ChordCategory.suspended)) {
      availableChords.addAll(_chordRepo.getSuspendedChords());
    }
    if (config.chordCategories.contains(ChordCategory.added)) {
      availableChords.addAll(_chordRepo.getAddedChords());
    }
    if (config.chordCategories.contains(ChordCategory.extended)) {
      availableChords.addAll(_chordRepo.getExtendedChords());
    }
    if (config.chordCategories.contains(ChordCategory.power)) {
      availableChords.addAll(_chordRepo.getPowerChords());
    }
    if (config.chordCategories.contains(ChordCategory.slash)) {
      availableChords.addAll(_chordRepo.getSlashChords());
    }
    if (config.chordCategories.contains(ChordCategory.diminished)) {
      availableChords.addAll(_chordRepo.getDiminishedChords());
    }
    if (config.chordCategories.contains(ChordCategory.augmented)) {
      availableChords.addAll(_chordRepo.getAugmentedChords());
    }

    // Filter by difficulty
    availableChords = availableChords.where((chord) {
      switch (config.difficulty) {
        case Difficulty.beginner:
          return chord.difficulty == Difficulty.beginner;
        case Difficulty.intermediate:
          return chord.difficulty == Difficulty.beginner || 
                 chord.difficulty == Difficulty.intermediate;
        case Difficulty.advanced:
          return true; // All chords
      }
    }).toList();

    if (availableChords.isEmpty) {
      // Fallback to basic chords
      availableChords = [
        _chordRepo.getChordByName('C')!,
        _chordRepo.getChordByName('G')!,
        _chordRepo.getChordByName('Am')!,
        _chordRepo.getChordByName('F')!,
      ];
    }

    // Select one chord per bar
    final selectedChords = <String>[];
    for (var i = 0; i < config.numBars; i++) {
      final chord = availableChords[_random.nextInt(availableChords.length)];
      selectedChords.add(chord.name);
    }

    return selectedChords;
  }

  /// Generate realistic strumming pattern
  List<PracticeStroke> _generateStrummingPattern(PracticeConfig config) {
    final strokes = <PracticeStroke>[];
    final strokesPerBar = _getStrokesPerBar(config.timeSignature);
    final totalStrokes = strokesPerBar * config.numBars;

    switch (config.difficulty) {
      case Difficulty.beginner:
        _generateBeginnerPattern(strokes, totalStrokes, strokesPerBar, config);
        break;
      case Difficulty.intermediate:
        _generateIntermediatePattern(strokes, totalStrokes, strokesPerBar, config);
        break;
      case Difficulty.advanced:
        _generateAdvancedPattern(strokes, totalStrokes, strokesPerBar, config);
        break;
    }

    return strokes;
  }

  /// Get number of strokes per bar based on time signature
  int _getStrokesPerBar(TimeSignature timeSignature) {
    switch (timeSignature) {
      case TimeSignature.time2_4:
        return 4; // 2 beats x 2 eighth notes
      case TimeSignature.time3_4:
        return 6; // 3 beats x 2 eighth notes
      case TimeSignature.time4_4:
        return 8; // 4 beats x 2 eighth notes
      case TimeSignature.time5_4:
        return 10; // 5 beats x 2 eighth notes
      case TimeSignature.time6_8:
        return 6; // 6 eighth notes
      case TimeSignature.time7_8:
        return 7; // 7 eighth notes
      case TimeSignature.time12_8:
        return 12; // 12 eighth notes
    }
  }

  /// Beginner: Simple patterns, mostly downstrokes
  void _generateBeginnerPattern(
    List<PracticeStroke> strokes,
    int totalStrokes,
    int strokesPerBar,
    PracticeConfig config,
  ) {
    final patterns = [
      ['D', '-', 'D', '-', 'D', '-', 'D', '-'], // All downs (4/4)
      ['D', '-', 'D', 'U', 'D', '-', 'D', 'U'], // Simple down-up
      ['D', 'D', 'U', 'U', 'D', 'U', 'D', 'U'], // Common beginner
    ];

    // Pick a pattern and repeat it
    final basePattern = patterns[_random.nextInt(patterns.length)];
    
    for (var i = 0; i < totalStrokes; i++) {
      final symbol = basePattern[i % basePattern.length];
      if (symbol != '-') {
        strokes.add(PracticeStroke(symbol: symbol, position: i));
      }
    }
  }

  /// Intermediate: Syncopation, mutes, varied patterns
  void _generateIntermediatePattern(
    List<PracticeStroke> strokes,
    int totalStrokes,
    int strokesPerBar,
    PracticeConfig config,
  ) {
    var position = 0;
    var lastWasDown = false;

    while (position < totalStrokes) {
      final posInBar = position % strokesPerBar;
      final isOnBeat = posInBar % 2 == 0;
      final rand = _random.nextDouble();

      if (isOnBeat) {
        // Downbeat - usually down or mute
        if (rand < 0.7) {
          strokes.add(PracticeStroke(symbol: 'D', position: position));
          lastWasDown = true;
        } else if (rand < 0.85) {
          strokes.add(PracticeStroke(symbol: 'X', position: position));
          lastWasDown = false;
        }
        // else: rest
      } else {
        // Offbeat - usually up, sometimes mute or rest
        if (rand < 0.5 && lastWasDown) {
          strokes.add(PracticeStroke(symbol: 'U', position: position));
          lastWasDown = false;
        } else if (rand < 0.65) {
          strokes.add(PracticeStroke(symbol: 'X', position: position));
          lastWasDown = false;
        }
        // else: rest
      }

      position++;
    }
  }

  /// Advanced: Complex rhythms, lots of syncopation
  void _generateAdvancedPattern(
    List<PracticeStroke> strokes,
    int totalStrokes,
    int strokesPerBar,
    PracticeConfig config,
  ) {
    var position = 0;
    var lastWasDown = false;
    var muteCount = 0; // Prevent too many consecutive mutes

    while (position < totalStrokes) {
      final posInBar = position % strokesPerBar;
      final isOnBeat = posInBar % 2 == 0;
      final isStrongBeat = config.timeSignature.strongBeats.contains(posInBar ~/ 2);
      final rand = _random.nextDouble();

      if (isOnBeat) {
        if (isStrongBeat && rand < 0.8) {
          // Strong beats usually get downstrokes
          strokes.add(PracticeStroke(symbol: 'D', position: position));
          lastWasDown = true;
          muteCount = 0;
        } else if (rand < 0.5) {
          strokes.add(PracticeStroke(symbol: 'D', position: position));
          lastWasDown = true;
          muteCount = 0;
        } else if (rand < 0.7 && muteCount < 2) {
          strokes.add(PracticeStroke(symbol: 'X', position: position));
          muteCount++;
          lastWasDown = false;
        }
        // else: rest
      } else {
        // Offbeat - create syncopation
        if (rand < 0.4 && lastWasDown) {
          strokes.add(PracticeStroke(symbol: 'U', position: position));
          lastWasDown = false;
          muteCount = 0;
        } else if (rand < 0.6 && muteCount < 2) {
          strokes.add(PracticeStroke(symbol: 'X', position: position));
          muteCount++;
          lastWasDown = false;
        } else if (rand < 0.7 && !lastWasDown) {
          strokes.add(PracticeStroke(symbol: 'D', position: position));
          lastWasDown = true;
          muteCount = 0;
        }
        // else: rest
      }

      position++;
      
      // Reset mute counter periodically
      if (position % strokesPerBar == 0) {
        muteCount = 0;
      }
    }
  }
}
