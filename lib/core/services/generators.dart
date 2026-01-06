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
    
    // Generate truly random beginner patterns based on weighted probabilities
    for (var i = 0; i < gridSize; i++) {
      final beat = i ~/ timeSig.subdivision;
      final subBeat = i % timeSig.subdivision;
      
      StrokeType type;
      bool isAccented = false;
      
      if (subBeat == 0) {
        // Downbeat - always down stroke
        type = StrokeType.down;
        isAccented = timeSig.isStrongBeat(beat);
      } else {
        // Off-beats - random decision based on difficulty
        final rand = _random.nextDouble();
        
        if (rand < 0.4) {
          // 40% chance of upstroke
          type = StrokeType.up;
        } else if (rand < 0.6 && subBeat == timeSig.subdivision - 1) {
          // 20% chance of upstroke on last subdivision
          type = StrokeType.up;
        } else {
          // 40% mute strokes for percussive texture
          type = StrokeType.mute;
        }
      }
      
      strokes.add(Stroke(type: type, position: i, isAccented: isAccented));
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
    final gridSize = timeSig.totalSubdivisions;
    
    // Generate truly random intermediate patterns with higher stroke density
    for (var i = 0; i < gridSize; i++) {
      final beat = i ~/ timeSig.subdivision;
      final subBeat = i % timeSig.subdivision;
      final weight = timeSig.getBeatWeight(i, timeSig.subdivision);
      
      StrokeType type;
      bool isAccented = false;
      
      // Strong beats always get strokes
      if (subBeat == 0 && timeSig.isStrongBeat(beat)) {
        type = StrokeType.down;
        isAccented = true;
      }
      // Medium beats usually get strokes
      else if (subBeat == 0 && timeSig.isMediumBeat(beat)) {
        type = _random.nextDouble() < 0.8 ? StrokeType.down : StrokeType.mute;
      }
      // Other downbeats
      else if (subBeat == 0) {
        type = _random.nextDouble() < 0.6 ? StrokeType.down : StrokeType.mute;
      }
      // Off-beats - use weighted randomness
      else {
        final rand = _random.nextDouble();
        
        if (rand < weight * 0.7) {
          // Higher chance for upstrokes on off-beats
          final isUp = subBeat > 0 || i % 2 == 1;
          type = isUp ? StrokeType.up : StrokeType.down;
        } else {
          type = StrokeType.mute;
        }
      }
      
      strokes.add(Stroke(type: type, position: i, isAccented: isAccented));
    }
    
    // Ensure minimum strokes
    _ensureMinimumStrokes(strokes, timeSig);
    
    // Enforce natural alternation
    _enforceAlternation(strokes);
    
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
  /// - Mute strokes for percussive texture
  /// - Musical flow with hand alternation
  /// - Song-like phrasing
  StrummingPattern _generateAdvanced(TimeSignature timeSig, int variation) {
    final strokes = <Stroke>[];
    final gridSize = timeSig.totalSubdivisions;
    
    // Use weighted random generation with higher complexity
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
        final rand = _random.nextDouble();
        if (rand < 0.85) {
          type = StrokeType.down;
        } else {
          type = StrokeType.mute;
        }
      }
      // Other beats - weighted randomness with more variety
      else if (_random.nextDouble() < weight * 0.85) {
        // Alternate down/up based on position
        final isUp = subBeat > 0 || i % 2 == 1;
        type = isUp ? StrokeType.up : StrokeType.down;
        
        // Add mute strokes (20% chance for percussive variety)
        if (_random.nextDouble() < 0.20) {
          type = StrokeType.mute;
        }
      } else {
        type = StrokeType.mute;
      }
      
      strokes.add(Stroke(type: type, position: i, isAccented: isAccented));
    }
    
    // Ensure musicality - at least one stroke per beat
    _ensureMinimumStrokes(strokes, timeSig);
    
    // Smooth out impossible transitions
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
  
  /// Ensure every beat has at least one stroke (no empty beats)
  void _ensureMinimumStrokes(List<Stroke> strokes, TimeSignature timeSig) {
    for (var beat = 0; beat < timeSig.beats; beat++) {
      final beatStart = beat * timeSig.subdivision;
      final beatEnd = beatStart + timeSig.subdivision;
      
      final hasStroke = strokes
          .where((s) => s.position >= beatStart && s.position < beatEnd)
          .any((s) => s.type != StrokeType.mute);
      
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
      
      if (current != StrokeType.mute) {
        // If two ups or two downs in a row, fix it
        if (lastStroke == StrokeType.up && current == StrokeType.up) {
          // Change to down
          strokes[i] = Stroke(
            type: StrokeType.down,
            position: strokes[i].position,
            isAccented: strokes[i].isAccented,
          );
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
