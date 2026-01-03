import 'package:equatable/equatable.dart';
import 'chord.dart';

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
  final int position; // Position in the grid (0-15 for 16th notes)

  const Stroke({
    required this.type,
    required this.position,
  });

  String get symbol {
    switch (type) {
      case StrokeType.down:
        return 'D';
      case StrokeType.up:
        return 'U';
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
  List<Object?> get props => [type, position];
}

class StrummingPattern extends Equatable {
  final List<Stroke> strokes;
  final Difficulty difficulty;
  final int beatsPerBar;

  const StrummingPattern({
    required this.strokes,
    required this.difficulty,
    this.beatsPerBar = 4,
  });

  String get displayPattern => strokes.map((s) => s.symbol).join(' ');

  @override
  List<Object?> get props => [strokes, difficulty];
}
