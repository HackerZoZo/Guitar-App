import 'package:equatable/equatable.dart';
import 'chord.dart';
import 'time_signature.dart';

enum StrokeType {
  down,
  up,
  rest,
  ghostDown,
  ghostUp,
  mute,
}

class Stroke extends Equatable {
  final StrokeType type;
  final int position; // Position in the grid (0-based index)
  final bool isAccented; // Whether this stroke should be emphasized

  const Stroke({
    required this.type,
    required this.position,
    this.isAccented = false,
  });

  String get symbol {
    switch (type) {
      case StrokeType.down:
        return isAccented ? 'D!' : 'D';
      case StrokeType.up:
        return isAccented ? 'U!' : 'U';
      case StrokeType.rest:
        return '-';
      case StrokeType.ghostDown:
        return '(D)';
      case StrokeType.ghostUp:
        return '(U)';
      case StrokeType.mute:
        return 'X';
    }
  }

  @override
  List<Object?> get props => [type, position, isAccented];
}

/// Represents a complete strumming pattern for guitar
/// 
/// A strumming pattern defines exactly when and how to strum during each bar.
/// It's generated based on time signature and difficulty level to create
/// musically coherent, song-like rhythms.
class StrummingPattern extends Equatable {
  /// The sequence of strokes in this pattern
  final List<Stroke> strokes;

  /// Difficulty level this pattern was generated for
  final Difficulty difficulty;

  /// Time signature this pattern follows
  final TimeSignature timeSignature;

  /// Optional: A variation number (1, 2, 3...) for pattern diversity
  /// Allows generating multiple patterns with similar feel but slight differences
  final int variationNumber;

  const StrummingPattern({
    required this.strokes,
    required this.difficulty,
    required this.timeSignature,
    this.variationNumber = 1,
  });

  /// Legacy getter for backwards compatibility
  int get beatsPerBar => timeSignature.beats;

  /// Get display pattern as a string
  String get displayPattern => strokes.map((s) => s.symbol).join(' ');

  /// Get pattern grouped by beats for better visualization
  /// Example for 4/4: ["D - D U", "- U D -", "D U - U", "D - D U"]
  List<String> get displayByBeats {
    final beats = <String>[];
    final strokesPerBeat = timeSignature.subdivision;
    
    for (var beat = 0; beat < timeSignature.beats; beat++) {
      final startIdx = beat * strokesPerBeat;
      final endIdx = startIdx + strokesPerBeat;
      
      final beatStrokes = strokes
          .where((s) => s.position >= startIdx && s.position < endIdx)
          .map((s) => s.symbol)
          .join(' ');
      
      beats.add(beatStrokes.isEmpty ? '-' : beatStrokes);
    }
    
    return beats;
  }

  /// Get strokes for a specific beat (0-indexed)
  List<Stroke> getStrokesForBeat(int beatIndex) {
    final strokesPerBeat = timeSignature.subdivision;
    final startIdx = beatIndex * strokesPerBeat;
    final endIdx = startIdx + strokesPerBeat;
    
    return strokes.where((s) => s.position >= startIdx && s.position < endIdx).toList();
  }

  @override
  List<Object?> get props => [strokes, difficulty, timeSignature, variationNumber];
}
