import 'package:equatable/equatable.dart';

enum ChordType {
  major,
  minor,
  barre,
  seventh, // Dominant 7 (e.g., G7, A7)
  majorSeventh, // Major 7 (e.g., Cmaj7, Fmaj7)
  minorSeventh, // Minor 7 (e.g., Am7, Dm7)
  sus2, // Suspended 2
  sus4, // Suspended 4
  add9, // Added 9
  add11, // Added 11
  ninth, // 9 chords
  eleventh, // 11 chords
  power, // Power chords (5)
  slash, // Slash chords (e.g., C/G)
  diminished, // Diminished chords
  augmented, // Augmented chords
}

/// Chord category for filtering in the UI
enum ChordCategory {
  major,
  minor,
  barre,
  seventh, // 7, maj7, m7
  suspended, // sus2, sus4
  added, // add9, add11
  extended, // 9, 11
  slash, // slash chords
  power, // power chords
  diminished, // dim
  augmented, // aug
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
  final ChordCategory category;

  const Chord({
    required this.name,
    required this.type,
    required this.difficulty,
    required this.frets,
    required this.fingers,
    this.baseFret = 1,
    this.isOpen = true,
    this.isBarre = false,
    this.category = ChordCategory.major,
  });

  @override
  List<Object?> get props => [name, type, frets];
}
