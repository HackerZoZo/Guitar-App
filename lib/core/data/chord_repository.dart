import '../models/chord.dart';

class ChordRepository {
  static const List<Chord> allChords = [
    // Major Chords
    Chord(
      name: 'C',
      type: ChordType.major,
      difficulty: Difficulty.beginner,
      frets: [-1, 3, 2, 0, 1, 0],
      fingers: [0, 3, 2, 0, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'D',
      type: ChordType.major,
      difficulty: Difficulty.beginner,
      frets: [-1, -1, 0, 2, 3, 2],
      fingers: [0, 0, 0, 1, 3, 2],
      isOpen: true,
    ),
    Chord(
      name: 'E',
      type: ChordType.major,
      difficulty: Difficulty.beginner,
      frets: [0, 2, 2, 1, 0, 0],
      fingers: [0, 2, 3, 1, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'G',
      type: ChordType.major,
      difficulty: Difficulty.beginner,
      frets: [3, 2, 0, 0, 0, 3],
      fingers: [3, 2, 0, 0, 0, 4],
      isOpen: true,
    ),
    Chord(
      name: 'A',
      type: ChordType.major,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 2, 2, 2, 0],
      fingers: [0, 0, 1, 2, 3, 0],
      isOpen: true,
    ),
    
    // Minor Chords
    Chord(
      name: 'Am',
      type: ChordType.minor,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 2, 2, 1, 0],
      fingers: [0, 0, 2, 3, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Em',
      type: ChordType.minor,
      difficulty: Difficulty.beginner,
      frets: [0, 2, 2, 0, 0, 0],
      fingers: [0, 2, 3, 0, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Dm',
      type: ChordType.minor,
      difficulty: Difficulty.beginner,
      frets: [-1, -1, 0, 2, 3, 1],
      fingers: [0, 0, 0, 2, 3, 1],
      isOpen: true,
    ),
    
    // Intermediate Chords
    Chord(
      name: 'F',
      type: ChordType.major,
      difficulty: Difficulty.intermediate,
      frets: [1, 3, 3, 2, 1, 1],
      fingers: [1, 3, 4, 2, 1, 1],
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'B',
      type: ChordType.major,
      difficulty: Difficulty.intermediate,
      frets: [-1, 2, 4, 4, 4, 2],
      fingers: [0, 1, 3, 3, 3, 1],
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Bm',
      type: ChordType.minor,
      difficulty: Difficulty.intermediate,
      frets: [-1, 2, 4, 4, 3, 2],
      fingers: [0, 1, 3, 4, 2, 1],
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Cm',
      type: ChordType.minor,
      difficulty: Difficulty.intermediate,
      frets: [-1, 3, 5, 5, 4, 3],
      fingers: [0, 1, 3, 4, 2, 1],
      isOpen: false,
      isBarre: true,
      baseFret: 3,
    ),
    
    // Seventh Chords
    Chord(
      name: 'G7',
      type: ChordType.seventh,
      difficulty: Difficulty.beginner,
      frets: [3, 2, 0, 0, 0, 1],
      fingers: [3, 2, 0, 0, 0, 1],
      isOpen: true,
    ),
    Chord(
      name: 'C7',
      type: ChordType.seventh,
      difficulty: Difficulty.beginner,
      frets: [-1, 3, 2, 3, 1, 0],
      fingers: [0, 3, 2, 4, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'D7',
      type: ChordType.seventh,
      difficulty: Difficulty.beginner,
      frets: [-1, -1, 0, 2, 1, 2],
      fingers: [0, 0, 0, 2, 1, 3],
      isOpen: true,
    ),
    Chord(
      name: 'A7',
      type: ChordType.seventh,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 2, 0, 2, 0],
      fingers: [0, 0, 2, 0, 3, 0],
      isOpen: true,
    ),
    Chord(
      name: 'E7',
      type: ChordType.seventh,
      difficulty: Difficulty.beginner,
      frets: [0, 2, 0, 1, 0, 0],
      fingers: [0, 2, 0, 1, 0, 0],
      isOpen: true,
    ),
  ];

  List<Chord> getChordsByType(ChordType type) {
    return allChords.where((chord) => chord.type == type).toList();
  }

  List<Chord> getChordsByDifficulty(Difficulty difficulty) {
    return allChords.where((chord) => chord.difficulty == difficulty).toList();
  }

  List<Chord> getMajorChords() => getChordsByType(ChordType.major);
  List<Chord> getMinorChords() => getChordsByType(ChordType.minor);
  List<Chord> getBarreChords() => allChords.where((c) => c.isBarre).toList();
  List<Chord> getBeginnerChords() => getChordsByDifficulty(Difficulty.beginner);
}
