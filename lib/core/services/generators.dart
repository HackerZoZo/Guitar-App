import 'dart:math';
import '../models/chord.dart';
import '../models/strumming_pattern.dart';
import '../models/time_signature.dart';

class ChordGenerator {
  final Random _random = Random();

  List<Chord> generateSequence({
    required List<Chord> selectedChords,
    required int bars,
    Difficulty? difficulty,
  }) {
    if (selectedChords.isEmpty) return [];
    
    // Filter by difficulty if specified
    final pool = difficulty != null
        ? selectedChords.where((c) => c.difficulty == difficulty).toList()
        : selectedChords;
    
    if (pool.isEmpty) return List.filled(bars, selectedChords.first);
    
    return List.generate(bars, (_) => _pickWeightedChord(pool, difficulty));
  }

  Chord _pickWeightedChord(List<Chord> pool, Difficulty? difficulty) {
    // Weight chords based on difficulty preference
    final weights = pool.map((chord) {
      int weight = 3; // Base weight
      
      if (difficulty == Difficulty.beginner) {
        if (chord.isOpen) weight = 5;
        if (chord.isBarre) weight = 1;
      } else if (difficulty == Difficulty.intermediate) {
        if (chord.isBarre) {
          weight = 2;
        } else {
          weight = 3;
        }
      } else if (difficulty == Difficulty.advanced) {
        weight = 3; // Equal weight
      }
      
      return weight;
    }).toList();
    
    final totalWeight = weights.fold<int>(0, (sum, w) => sum + w);
    var randomValue = _random.nextInt(totalWeight);
    
    for (var i = 0; i < pool.length; i++) {
      randomValue -= weights[i];
      if (randomValue < 0) return pool[i];
    }
    
    return pool.first;
  }
}

/// Musical Strumming Pattern Generator
/// 
/// Generates guitar strumming patterns that feel like real songs, not random noise.
/// Each pattern respects time signature, difficulty level, and musical theory.
/// 
/// Core Principles:
/// - Strong beats (especially beat 1) are emphasized
/// - Patterns flow naturally with alternating down/up strokes
/// - Syncopation and complexity increase with difficulty
/// - Time signature influences pattern structure and feel
class StrummingPatternGenerator {
  final Random _random = Random();

  /// Generate a musically coherent strumming pattern
  /// 
  /// [difficulty] - Complexity level (beginner to song-level)
  /// [timeSignature] - Time signature that governs rhythm and feel
  /// [variationNumber] - Optional variation for diversity (1-4)

  /// Generate a musically coherent strumming pattern
  /// 
  /// [difficulty] - Complexity level (beginner to song-level)
  /// [timeSignature] - Time signature that governs rhythm and feel
  /// [variationNumber] - Optional variation for diversity (1-4)
  StrummingPattern generate({
    required Difficulty difficulty,
    TimeSignature timeSignature = TimeSignature.time4_4,
    int variationNumber = 1,
  }) {
    switch (difficulty) {
      case Difficulty.beginner:
        return _generateBeginner(timeSignature, variationNumber);
      case Difficulty.intermediate:
        return _generateIntermediate(timeSignature, variationNumber);
      case Difficulty.advanced:
        return _generateAdvanced(timeSignature, variationNumber);
    }
  }

  // ========================================================================
  // LEVEL 1: BEGINNER - Simple, strong beats only
  // ========================================================================
  
  /// Generate beginner-friendly patterns
  /// - Only Down (D) and Up (U) strokes
  /// - Simple subdivision (8th notes)
  /// - Strong beat emphasis
  /// - No syncopation
  StrummingPattern _generateBeginner(TimeSignature timeSig, int variation) {
    final strokes = <Stroke>[];
    final gridSize = timeSig.totalSubdivisions;
    
    // Pattern library based on time signature feel
    if (timeSig == TimeSignature.time3_4) {
      // Waltz feel - D D D or D - D
      final patterns = [
        [StrokeType.down, StrokeType.down, StrokeType.down], // D D D
        [StrokeType.down, StrokeType.rest, StrokeType.down], // D - D
      ];
      final pattern = patterns[variation % patterns.length];
      
      for (var beat = 0; beat < timeSig.beats; beat++) {
        final startIdx = beat * timeSig.subdivision;
        strokes.add(Stroke(
          type: pattern[beat],
          position: startIdx,
          isAccented: beat == 0,
        ));
        // Fill rest of subdivision with rests
        for (var sub = 1; sub < timeSig.subdivision; sub++) {
          strokes.add(Stroke(type: StrokeType.rest, position: startIdx + sub));
        }
      }
    } else {
      // 4/4, 2/4, etc. - Standard patterns
      // Pattern: D - D - D - D - (all downbeats)
      //      or: D - D U - U D -
      final useUpstrokes = variation % 2 == 1;
      
      for (var i = 0; i < gridSize; i++) {
        final beat = i ~/ timeSig.subdivision;
        final subBeat = i % timeSig.subdivision;
        
        StrokeType type;
        bool isAccented = false;
        
        if (subBeat == 0) {
          // Downbeat - always down stroke
          type = StrokeType.down;
          isAccented = timeSig.isStrongBeat(beat);
        } else if (useUpstrokes && subBeat == timeSig.subdivision - 1) {
          // Last subdivision - upstroke if enabled
          type = beat % 2 == 1 ? StrokeType.up : StrokeType.rest;
        } else {
          type = StrokeType.rest;
        }
        
        strokes.add(Stroke(type: type, position: i, isAccented: isAccented));
      }
    }
    
    return StrummingPattern(
      strokes: strokes,
      difficulty: Difficulty.beginner,
      timeSignature: timeSig,
      variationNumber: variation,
    );
  }

  // ========================================================================
  // LEVEL 2: INTERMEDIATE - Add groove and off-beats
  // ========================================================================
  
  /// Generate intermediate patterns
  /// - Introduce off-beat upstrokes
  /// - Simple syncopation
  /// - Musical flow
  StrummingPattern _generateIntermediate(TimeSignature timeSig, int variation) {
    final strokes = <Stroke>[];
    
    // Classic intermediate patterns for 4/4
    if (timeSig == TimeSignature.time4_4) {
      final patterns = [
        'D_DU_UDU', // D - D U - U D U (classic)
        'DUDUDUDU', // D U D U D U D U (alternating)
        'DU_UDU_U', // D U - U D U - U (syncopated)
        'D_DUDU__', // D - D U D U - -
      ];
      
      final patternStr = patterns[variation % patterns.length];
      _parsePatternString(patternStr, strokes, timeSig);
    } else if (timeSig == TimeSignature.time3_4) {
      // Waltz patterns with upstrokes
      final patterns = [
        'DU_DU_DU_', // D U - D U - D U -
        'D_DUD__U_', // D - D U D - - U -
      ];
      
      final patternStr = patterns[variation % patterns.length];
      _parsePatternString(patternStr, strokes, timeSig);
    } else if (timeSig == TimeSignature.time6_8) {
      // Compound meter - lilting feel
      final patterns = [
        'D__U__D__U__', // D - - U - - D - - U - -
        'DU_DU_DU_DU_', // More active
      ];
      
      final patternStr = patterns[variation % patterns.length];
      _parsePatternString(patternStr, strokes, timeSig);
    } else {
      // Fallback for other time signatures
      _generateGenericPattern(strokes, timeSig, 0.6, false);
    }
    
    return StrummingPattern(
      strokes: strokes,
      difficulty: Difficulty.intermediate,
      timeSignature: timeSig,
      variationNumber: variation,
    );
  }

  // ========================================================================
  // LEVEL 3-5: ADVANCED & SONG-LEVEL - Complex, musical patterns
  // ========================================================================
  
  /// Generate advanced patterns
  /// - Natural accents and dynamics
  /// - Beat skipping (silence)
  /// - Musical flow with ghost notes and mutes
  /// - Song-like phrasing
  StrummingPattern _generateAdvanced(TimeSignature timeSig, int variation) {
    final strokes = <Stroke>[];
    final gridSize = timeSig.totalSubdivisions;
    
    // Use weighted random generation for natural feel
    for (var i = 0; i < gridSize; i++) {
      final beat = i ~/ timeSig.subdivision;
      final subBeat = i % timeSig.subdivision;
      final weight = timeSig.getBeatWeight(i, timeSig.subdivision);
      
      StrokeType type;
      bool isAccented = false;
      
      // Strong beats ALWAYS get a stroke
      if (subBeat == 0 && timeSig.isStrongBeat(beat)) {
        type = StrokeType.down;
        isAccented = true;
      }
      // Medium beats usually get a stroke
      else if (subBeat == 0 && timeSig.isMediumBeat(beat)) {
        type = _random.nextDouble() < 0.85 ? StrokeType.down : StrokeType.rest;
      }
      // Other beats - weighted randomness
      else if (_random.nextDouble() < weight) {
        // Alternate down/up based on position
        final isUp = subBeat > 0 || i % 2 == 1;
        type = isUp ? StrokeType.up : StrokeType.down;
        
        // Add ghost notes (20% chance on upstrokes)
        if (_random.nextDouble() < 0.2 && isUp) {
          type = StrokeType.ghostUp;
        }
        // Add mutes (10% chance)
        else if (_random.nextDouble() < 0.1) {
          type = StrokeType.mute;
        }
      } else {
        type = StrokeType.rest;
      }
      
      strokes.add(Stroke(type: type, position: i, isAccented: isAccented));
    }
    
    // Ensure musicality - at least one stroke per beat
    _ensureMinimumStrokes(strokes, timeSig);
    
    // Smooth out impossible transitions (two ups in a row without down between)
    _enforceAlternation(strokes);
    
    return StrummingPattern(
      strokes: strokes,
      difficulty: Difficulty.advanced,
      timeSignature: timeSig,
      variationNumber: variation,
    );
  }

  // ========================================================================
  // HELPER METHODS
  // ========================================================================
  
  /// Parse pattern string like "D_DU_UDU" into strokes
  /// D = Down, U = Up, _ = Rest
  void _parsePatternString(String pattern, List<Stroke> strokes, TimeSignature timeSig) {
    for (var i = 0; i < pattern.length; i++) {
      final char = pattern[i];
      
      StrokeType type;
      bool isAccented = false;
      
      switch (char) {
        case 'D':
          type = StrokeType.down;
          isAccented = i == 0; // Accent first beat
          break;
        case 'U':
          type = StrokeType.up;
          break;
        case '_':
        default:
          type = StrokeType.rest;
      }
      
      strokes.add(Stroke(type: type, position: i, isAccented: isAccented));
    }
  }

  /// Generate pattern with weighted randomness
  void _generateGenericPattern(
    List<Stroke> strokes,
    TimeSignature timeSig,
    double density,
    bool includeGhosts,
  ) {
    final gridSize = timeSig.totalSubdivisions;
    
    for (var i = 0; i < gridSize; i++) {
      final weight = timeSig.getBeatWeight(i, timeSig.subdivision);
      
      if (_random.nextDouble() < weight * density) {
        final isUp = i % 2 == 1;
        var type = isUp ? StrokeType.up : StrokeType.down;
        
        if (includeGhosts && isUp && _random.nextDouble() < 0.15) {
          type = StrokeType.ghostUp;
        }
        
        strokes.add(Stroke(type: type, position: i, isAccented: i == 0));
      } else {
        strokes.add(Stroke(type: StrokeType.rest, position: i));
      }
    }
  }

  /// Ensure every beat has at least one stroke (no empty beats)
  void _ensureMinimumStrokes(List<Stroke> strokes, TimeSignature timeSig) {
    for (var beat = 0; beat < timeSig.beats; beat++) {
      final beatStart = beat * timeSig.subdivision;
      final beatEnd = beatStart + timeSig.subdivision;
      
      final hasStroke = strokes
          .where((s) => s.position >= beatStart && s.position < beatEnd)
          .any((s) => s.type != StrokeType.rest);
      
      if (!hasStroke) {
        // Add a downstroke at the beat
        final idx = strokes.indexWhere((s) => s.position == beatStart);
        if (idx != -1) {
          strokes[idx] = Stroke(
            type: StrokeType.down,
            position: beatStart,
            isAccented: timeSig.isStrongBeat(beat),
          );
        }
      }
    }
  }

  /// Enforce alternating down/up pattern (avoid impossible hand movements)
  void _enforceAlternation(List<Stroke> strokes) {
    StrokeType? lastStroke;
    
    for (var i = 0; i < strokes.length; i++) {
      final current = strokes[i].type;
      
      if (current != StrokeType.rest && current != StrokeType.mute) {
        // If two ups or two downs in a row, fix it
        if (lastStroke == StrokeType.up && current == StrokeType.up) {
          // Change to down if not ghost
          if (current != StrokeType.ghostUp) {
            strokes[i] = Stroke(
              type: StrokeType.down,
              position: strokes[i].position,
              isAccented: strokes[i].isAccented,
            );
          }
        } else if (lastStroke == StrokeType.down && current == StrokeType.down) {
          // Allow consecutive downs on strong beats, otherwise change to up
          if (i > 0 && i - (strokes.indexWhere((s) => s == strokes[i - 1])) > 1) {
            // Convert to up if there's space
            strokes[i] = Stroke(
              type: StrokeType.up,
              position: strokes[i].position,
              isAccented: strokes[i].isAccented,
            );
          }
        }
        
        lastStroke = current;
      }
    }
  }
}
