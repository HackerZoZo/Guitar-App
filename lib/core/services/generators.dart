import 'dart:math';
import '../models/chord.dart';
import '../models/strumming_pattern.dart';

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

class StrummingPatternGenerator {
  final Random _random = Random();

  StrummingPattern generate({
    required Difficulty difficulty,
    int beatsPerBar = 4,
  }) {
    switch (difficulty) {
      case Difficulty.beginner:
        return _generateBeginner(beatsPerBar);
      case Difficulty.intermediate:
        return _generateIntermediate(beatsPerBar);
      case Difficulty.advanced:
        return _generateAdvanced(beatsPerBar);
    }
  }

  StrummingPattern _generateBeginner(int beatsPerBar) {
    // 8th note grid (2 strokes per beat)
    final patterns = [
      [StrokeType.down, StrokeType.down, StrokeType.down, StrokeType.down], // D D D D
      [StrokeType.down, StrokeType.rest, StrokeType.down, StrokeType.up], // D - D U
      [StrokeType.down, StrokeType.down, StrokeType.up, StrokeType.up], // D D U U
      [StrokeType.down, StrokeType.up, StrokeType.down, StrokeType.up], // D U D U
    ];
    
    final pattern = patterns[_random.nextInt(patterns.length)];
    final strokes = <Stroke>[];
    
    for (var i = 0; i < pattern.length * 2; i++) {
      final beatIndex = i ~/ 2;
      final isDownbeat = i % 2 == 0;
      
      if (isDownbeat) {
        strokes.add(Stroke(type: pattern[beatIndex], position: i));
      } else {
        strokes.add(Stroke(type: StrokeType.rest, position: i));
      }
    }
    
    return StrummingPattern(
      strokes: strokes,
      difficulty: Difficulty.beginner,
      beatsPerBar: beatsPerBar,
    );
  }

  StrummingPattern _generateIntermediate(int beatsPerBar) {
    // 8th note grid with syncopation
    final patterns = [
      [StrokeType.down, StrokeType.rest, StrokeType.down, StrokeType.up, StrokeType.rest, StrokeType.up], // D - D U - U
      [StrokeType.down, StrokeType.down, StrokeType.up, StrokeType.up, StrokeType.down, StrokeType.up], // D D U U D U
      [StrokeType.down, StrokeType.up, StrokeType.rest, StrokeType.up, StrokeType.down, StrokeType.up], // D U - U D U
      [StrokeType.down, StrokeType.rest, StrokeType.up, StrokeType.down, StrokeType.up, StrokeType.rest], // D - U D U -
    ];
    
    final pattern = patterns[_random.nextInt(patterns.length)];
    
    // Add occasional ghost notes
    final strokes = pattern.asMap().entries.map((entry) {
      var type = entry.value;
      if (_random.nextDouble() < 0.15) { // 15% chance of ghost note
        if (type == StrokeType.down) {
          type = StrokeType.ghostDown;
        } else if (type == StrokeType.up) {
          type = StrokeType.ghostUp;
        }
      }
      return Stroke(type: type, position: entry.key);
    }).toList();
    
    return StrummingPattern(
      strokes: strokes,
      difficulty: Difficulty.intermediate,
      beatsPerBar: beatsPerBar,
    );
  }

  StrummingPattern _generateAdvanced(int beatsPerBar) {
    // 16th note grid with complex patterns
    final gridSize = beatsPerBar * 4; // 16th notes
    final strokes = <Stroke>[];
    
    // Start with backbone accents on beats 1 and 3
    for (var i = 0; i < gridSize; i++) {
      final sixteenth = i % 4;
      
      StrokeType type;
      
      if (sixteenth == 0) {
        // Downbeat - always down stroke
        type = StrokeType.down;
      } else if (sixteenth == 2 && _random.nextDouble() < 0.7) {
        // "&" of the beat - often down
        type = StrokeType.down;
      } else {
        // Fill with alternating pattern
        final shouldPlay = _random.nextDouble() < 0.6;
        if (!shouldPlay) {
          type = StrokeType.rest;
        } else {
          final isUp = i % 2 == 1;
          type = isUp ? StrokeType.up : StrokeType.down;
          
          // Add ghost notes or mutes
          if (_random.nextDouble() < 0.2) {
            if (isUp) {
              type = StrokeType.ghostUp;
            } else {
              type = StrokeType.ghostDown;
            }
          } else if (_random.nextDouble() < 0.1) {
            type = StrokeType.mute;
          }
        }
      }
      
      strokes.add(Stroke(type: type, position: i));
    }
    
    // Ensure musicality - at least one stroke per beat
    for (var beat = 0; beat < beatsPerBar; beat++) {
      final beatStart = beat * 4;
      final beatEnd = beatStart + 4;
      final beatStrokes = strokes.sublist(beatStart, beatEnd);
      
      final hasStroke = beatStrokes.any((s) => 
        s.type != StrokeType.rest
      );
      
      if (!hasStroke) {
        strokes[beatStart] = Stroke(type: StrokeType.down, position: beatStart);
      }
    }
    
    return StrummingPattern(
      strokes: strokes,
      difficulty: Difficulty.advanced,
      beatsPerBar: beatsPerBar,
    );
  }
}
