import 'package:equatable/equatable.dart';

enum ChordType {
  major,
  minor,
  barre,
  seventh,
}

enum Difficulty {
  beginner,
  intermediate,
  advanced,
}

class Chord extends Equatable {
  final String name;
  final ChordType type;
  final Difficulty difficulty;
  final List<int> frets; // -1 = muted, 0 = open
  final List<int> fingers; // 0 = no finger, 1-4 = finger numbers
  final int baseFret;
  final bool isOpen;
  final bool isBarre;

  const Chord({
    required this.name,
    required this.type,
    required this.difficulty,
    required this.frets,
    required this.fingers,
    this.baseFret = 1,
    this.isOpen = true,
    this.isBarre = false,
  });

  @override
  List<Object?> get props => [name, type, frets];
}
