import 'package:equatable/equatable.dart';
import 'chord.dart';

/// Represents a single groove session
class Groove extends Equatable {
  final List<Chord> chords;
  final String strummingPattern;
  final int playCount;
  final bool isPlaying;

  const Groove({
    required this.chords,
    required this.strummingPattern,
    this.playCount = 0,
    this.isPlaying = false,
  });

  /// Format groove for display
  /// Returns: "Chord1  Chord2  Chord3\nDDUD    DDUD    DDUD"
  String get formattedDisplay {
    final chordLine = chords.map((c) => c.name).join('    ');
    final patternLine =
        List.filled(chords.length, strummingPattern).join('    ');
    return '$chordLine\n$patternLine';
  }

  Groove copyWith({
    List<Chord>? chords,
    String? strummingPattern,
    int? playCount,
    bool? isPlaying,
  }) {
    return Groove(
      chords: chords ?? this.chords,
      strummingPattern: strummingPattern ?? this.strummingPattern,
      playCount: playCount ?? this.playCount,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [chords, strummingPattern, playCount, isPlaying];
}
