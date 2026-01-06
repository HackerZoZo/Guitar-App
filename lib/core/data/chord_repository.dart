import '../models/chord.dart';

/// Complete acoustic guitar chord repository
/// Includes all commonly playable acoustic guitar chords
class ChordRepository {
  static const List<Chord> allChords = [
    // ═══════════════════════════════════════════════════════════════
    // OPEN MAJOR CHORDS (Beginner)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'C',
      type: ChordType.major,
      category: ChordCategory.major,
      difficulty: Difficulty.beginner,
      frets: [-1, 3, 2, 0, 1, 0],
      fingers: [0, 3, 2, 0, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'D',
      type: ChordType.major,
      category: ChordCategory.major,
      difficulty: Difficulty.beginner,
      frets: [-1, -1, 0, 2, 3, 2],
      fingers: [0, 0, 0, 1, 3, 2],
      isOpen: true,
    ),
    Chord(
      name: 'E',
      type: ChordType.major,
      category: ChordCategory.major,
      difficulty: Difficulty.beginner,
      frets: [0, 2, 2, 1, 0, 0],
      fingers: [0, 2, 3, 1, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'G',
      type: ChordType.major,
      category: ChordCategory.major,
      difficulty: Difficulty.beginner,
      frets: [3, 2, 0, 0, 0, 3],
      fingers: [3, 2, 0, 0, 0, 4],
      isOpen: true,
    ),
    Chord(
      name: 'A',
      type: ChordType.major,
      category: ChordCategory.major,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 2, 2, 2, 0],
      fingers: [0, 0, 1, 2, 3, 0],
      isOpen: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // OPEN MINOR CHORDS (Beginner)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Am',
      type: ChordType.minor,
      category: ChordCategory.minor,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 2, 2, 1, 0],
      fingers: [0, 0, 2, 3, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Em',
      type: ChordType.minor,
      category: ChordCategory.minor,
      difficulty: Difficulty.beginner,
      frets: [0, 2, 2, 0, 0, 0],
      fingers: [0, 2, 3, 0, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Dm',
      type: ChordType.minor,
      category: ChordCategory.minor,
      difficulty: Difficulty.beginner,
      frets: [-1, -1, 0, 2, 3, 1],
      fingers: [0, 0, 0, 2, 3, 1],
      isOpen: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // BARRE MAJOR CHORDS - E Shape (Intermediate)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'F',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [1, 3, 3, 2, 1, 1],
      fingers: [1, 3, 4, 2, 1, 1],
      baseFret: 1,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'F#',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [2, 4, 4, 3, 2, 2],
      fingers: [1, 3, 4, 2, 1, 1],
      baseFret: 2,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Gb',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [2, 4, 4, 3, 2, 2],
      fingers: [1, 3, 4, 2, 1, 1],
      baseFret: 2,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Ab',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [4, 6, 6, 5, 4, 4],
      fingers: [1, 3, 4, 2, 1, 1],
      baseFret: 4,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Bb',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [1, 1, 3, 3, 3, 1],
      fingers: [1, 1, 2, 3, 4, 1],
      baseFret: 1,
      isOpen: false,
      isBarre: true,
    ),

    // BARRE MAJOR CHORDS - A Shape (Intermediate)
    Chord(
      name: 'B',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [-1, 2, 4, 4, 4, 2],
      fingers: [0, 1, 3, 3, 3, 1],
      baseFret: 2,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'C#',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [-1, 4, 6, 6, 6, 4],
      fingers: [0, 1, 3, 3, 3, 1],
      baseFret: 4,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Db',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [-1, 4, 6, 6, 6, 4],
      fingers: [0, 1, 3, 3, 3, 1],
      baseFret: 4,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Eb',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [-1, 6, 8, 8, 8, 6],
      fingers: [0, 1, 3, 3, 3, 1],
      baseFret: 6,
      isOpen: false,
      isBarre: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // BARRE MINOR CHORDS - Em Shape (Intermediate)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Fm',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [1, 3, 3, 1, 1, 1],
      fingers: [1, 3, 4, 1, 1, 1],
      baseFret: 1,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'F#m',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [2, 4, 4, 2, 2, 2],
      fingers: [1, 3, 4, 1, 1, 1],
      baseFret: 2,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Gm',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [3, 5, 5, 3, 3, 3],
      fingers: [1, 3, 4, 1, 1, 1],
      baseFret: 3,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'G#m',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [4, 6, 6, 4, 4, 4],
      fingers: [1, 3, 4, 1, 1, 1],
      baseFret: 4,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Abm',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [4, 6, 6, 4, 4, 4],
      fingers: [1, 3, 4, 1, 1, 1],
      baseFret: 4,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Bbm',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [1, 1, 3, 3, 2, 1],
      fingers: [1, 1, 3, 4, 2, 1],
      baseFret: 1,
      isOpen: false,
      isBarre: true,
    ),

    // BARRE MINOR CHORDS - Am Shape (Intermediate)
    Chord(
      name: 'Bm',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [-1, 2, 4, 4, 3, 2],
      fingers: [0, 1, 3, 4, 2, 1],
      baseFret: 2,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Cm',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [-1, 3, 5, 5, 4, 3],
      fingers: [0, 1, 3, 4, 2, 1],
      baseFret: 3,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'C#m',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [-1, 4, 6, 6, 5, 4],
      fingers: [0, 1, 3, 4, 2, 1],
      baseFret: 4,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Ebm',
      type: ChordType.barre,
      category: ChordCategory.barre,
      difficulty: Difficulty.intermediate,
      frets: [-1, 6, 8, 8, 7, 6],
      fingers: [0, 1, 3, 4, 2, 1],
      baseFret: 6,
      isOpen: false,
      isBarre: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // DOMINANT 7 CHORDS (Beginner/Intermediate)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'A7',
      type: ChordType.seventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 2, 0, 2, 0],
      fingers: [0, 0, 2, 0, 3, 0],
      isOpen: true,
    ),
    Chord(
      name: 'B7',
      type: ChordType.seventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.beginner,
      frets: [-1, 2, 1, 2, 0, 2],
      fingers: [0, 2, 1, 3, 0, 4],
      isOpen: true,
    ),
    Chord(
      name: 'C7',
      type: ChordType.seventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.beginner,
      frets: [-1, 3, 2, 3, 1, 0],
      fingers: [0, 3, 2, 4, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'D7',
      type: ChordType.seventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.beginner,
      frets: [-1, -1, 0, 2, 1, 2],
      fingers: [0, 0, 0, 2, 1, 3],
      isOpen: true,
    ),
    Chord(
      name: 'E7',
      type: ChordType.seventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.beginner,
      frets: [0, 2, 0, 1, 0, 0],
      fingers: [0, 2, 0, 1, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'G7',
      type: ChordType.seventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.beginner,
      frets: [3, 2, 0, 0, 0, 1],
      fingers: [3, 2, 0, 0, 0, 1],
      isOpen: true,
    ),
    Chord(
      name: 'F7',
      type: ChordType.seventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [1, 3, 1, 2, 1, 1],
      fingers: [1, 3, 1, 2, 1, 1],
      baseFret: 1,
      isOpen: false,
      isBarre: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // MAJOR 7 CHORDS (Intermediate)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Amaj7',
      type: ChordType.majorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [-1, 0, 2, 1, 2, 0],
      fingers: [0, 0, 2, 1, 3, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Cmaj7',
      type: ChordType.majorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [-1, 3, 2, 0, 0, 0],
      fingers: [0, 3, 2, 0, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Dmaj7',
      type: ChordType.majorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [-1, -1, 0, 2, 2, 2],
      fingers: [0, 0, 0, 1, 2, 3],
      isOpen: true,
    ),
    Chord(
      name: 'Emaj7',
      type: ChordType.majorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [0, 2, 1, 1, 0, 0],
      fingers: [0, 3, 1, 2, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Fmaj7',
      type: ChordType.majorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [-1, -1, 3, 2, 1, 0],
      fingers: [0, 0, 3, 2, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Gmaj7',
      type: ChordType.majorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [3, 2, 0, 0, 0, 2],
      fingers: [3, 2, 0, 0, 0, 1],
      isOpen: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // MINOR 7 CHORDS (Intermediate)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Am7',
      type: ChordType.minorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [-1, 0, 2, 0, 1, 0],
      fingers: [0, 0, 2, 0, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Bm7',
      type: ChordType.minorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [-1, 2, 0, 2, 0, 2],
      fingers: [0, 1, 0, 2, 0, 3],
      isOpen: true,
    ),
    Chord(
      name: 'Dm7',
      type: ChordType.minorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [-1, -1, 0, 2, 1, 1],
      fingers: [0, 0, 0, 2, 1, 1],
      isOpen: true,
    ),
    Chord(
      name: 'Em7',
      type: ChordType.minorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [0, 2, 0, 0, 0, 0],
      fingers: [0, 1, 0, 0, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Fm7',
      type: ChordType.minorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [1, 3, 1, 1, 1, 1],
      fingers: [1, 3, 1, 1, 1, 1],
      baseFret: 1,
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'Gm7',
      type: ChordType.minorSeventh,
      category: ChordCategory.seventh,
      difficulty: Difficulty.intermediate,
      frets: [3, 5, 3, 3, 3, 3],
      fingers: [1, 3, 1, 1, 1, 1],
      baseFret: 3,
      isOpen: false,
      isBarre: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // SUSPENDED 2 CHORDS (Intermediate)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Asus2',
      type: ChordType.sus2,
      category: ChordCategory.suspended,
      difficulty: Difficulty.intermediate,
      frets: [-1, 0, 2, 2, 0, 0],
      fingers: [0, 0, 1, 2, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Dsus2',
      type: ChordType.sus2,
      category: ChordCategory.suspended,
      difficulty: Difficulty.intermediate,
      frets: [-1, -1, 0, 2, 3, 0],
      fingers: [0, 0, 0, 1, 2, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Esus2',
      type: ChordType.sus2,
      category: ChordCategory.suspended,
      difficulty: Difficulty.intermediate,
      frets: [0, 2, 4, 4, 0, 0],
      fingers: [0, 1, 3, 4, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Gsus2',
      type: ChordType.sus2,
      category: ChordCategory.suspended,
      difficulty: Difficulty.intermediate,
      frets: [3, 0, 0, 0, 3, 3],
      fingers: [1, 0, 0, 0, 2, 3],
      isOpen: true,
    ),
    Chord(
      name: 'Csus2',
      type: ChordType.sus2,
      category: ChordCategory.suspended,
      difficulty: Difficulty.intermediate,
      frets: [-1, 3, 0, 0, 3, 3],
      fingers: [0, 1, 0, 0, 3, 4],
      isOpen: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // SUSPENDED 4 CHORDS (Beginner/Intermediate)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Asus4',
      type: ChordType.sus4,
      category: ChordCategory.suspended,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 2, 2, 3, 0],
      fingers: [0, 0, 1, 2, 3, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Dsus4',
      type: ChordType.sus4,
      category: ChordCategory.suspended,
      difficulty: Difficulty.beginner,
      frets: [-1, -1, 0, 2, 3, 3],
      fingers: [0, 0, 0, 1, 2, 3],
      isOpen: true,
    ),
    Chord(
      name: 'Esus4',
      type: ChordType.sus4,
      category: ChordCategory.suspended,
      difficulty: Difficulty.beginner,
      frets: [0, 2, 2, 2, 0, 0],
      fingers: [0, 1, 2, 3, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Gsus4',
      type: ChordType.sus4,
      category: ChordCategory.suspended,
      difficulty: Difficulty.intermediate,
      frets: [3, 3, 0, 0, 1, 3],
      fingers: [2, 3, 0, 0, 1, 4],
      isOpen: true,
    ),
    Chord(
      name: 'Csus4',
      type: ChordType.sus4,
      category: ChordCategory.suspended,
      difficulty: Difficulty.intermediate,
      frets: [-1, 3, 3, 0, 1, 1],
      fingers: [0, 3, 4, 0, 1, 1],
      isOpen: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // ADD9 CHORDS (Advanced)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Cadd9',
      type: ChordType.add9,
      category: ChordCategory.added,
      difficulty: Difficulty.advanced,
      frets: [-1, 3, 2, 0, 3, 0],
      fingers: [0, 2, 1, 0, 3, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Dadd9',
      type: ChordType.add9,
      category: ChordCategory.added,
      difficulty: Difficulty.advanced,
      frets: [-1, -1, 0, 2, 3, 0],
      fingers: [0, 0, 0, 1, 2, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Eadd9',
      type: ChordType.add9,
      category: ChordCategory.added,
      difficulty: Difficulty.advanced,
      frets: [0, 2, 2, 1, 0, 2],
      fingers: [0, 2, 3, 1, 0, 4],
      isOpen: true,
    ),
    Chord(
      name: 'Gadd9',
      type: ChordType.add9,
      category: ChordCategory.added,
      difficulty: Difficulty.advanced,
      frets: [3, 2, 0, 2, 0, 3],
      fingers: [3, 2, 0, 1, 0, 4],
      isOpen: true,
    ),
    Chord(
      name: 'Aadd9',
      type: ChordType.add9,
      category: ChordCategory.added,
      difficulty: Difficulty.advanced,
      frets: [-1, 0, 2, 2, 2, 2],
      fingers: [0, 0, 1, 2, 3, 4],
      isOpen: true,
    ),
    Chord(
      name: 'Fadd9',
      type: ChordType.add9,
      category: ChordCategory.added,
      difficulty: Difficulty.advanced,
      frets: [-1, -1, 3, 2, 1, 3],
      fingers: [0, 0, 3, 2, 1, 4],
      isOpen: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // 9 CHORDS - Extended (Advanced)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'A9',
      type: ChordType.ninth,
      category: ChordCategory.extended,
      difficulty: Difficulty.advanced,
      frets: [-1, 0, 2, 4, 2, 3],
      fingers: [0, 0, 1, 3, 1, 2],
      isOpen: true,
    ),
    Chord(
      name: 'C9',
      type: ChordType.ninth,
      category: ChordCategory.extended,
      difficulty: Difficulty.advanced,
      frets: [-1, 3, 2, 3, 3, 3],
      fingers: [0, 2, 1, 3, 3, 3],
      baseFret: 1,
      isOpen: false,
    ),
    Chord(
      name: 'D9',
      type: ChordType.ninth,
      category: ChordCategory.extended,
      difficulty: Difficulty.advanced,
      frets: [-1, -1, 0, 2, 1, 0],
      fingers: [0, 0, 0, 2, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'E9',
      type: ChordType.ninth,
      category: ChordCategory.extended,
      difficulty: Difficulty.advanced,
      frets: [0, 2, 0, 1, 0, 2],
      fingers: [0, 2, 0, 1, 0, 3],
      isOpen: true,
    ),
    Chord(
      name: 'G9',
      type: ChordType.ninth,
      category: ChordCategory.extended,
      difficulty: Difficulty.advanced,
      frets: [3, 2, 0, 2, 0, 1],
      fingers: [4, 2, 0, 3, 0, 1],
      isOpen: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // POWER CHORDS (Beginner)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'A5',
      type: ChordType.power,
      category: ChordCategory.power,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 2, 2, -1, -1],
      fingers: [0, 0, 1, 3, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'B5',
      type: ChordType.power,
      category: ChordCategory.power,
      difficulty: Difficulty.intermediate,
      frets: [-1, 2, 4, 4, -1, -1],
      fingers: [0, 1, 3, 4, 0, 0],
      baseFret: 2,
      isOpen: false,
    ),
    Chord(
      name: 'C5',
      type: ChordType.power,
      category: ChordCategory.power,
      difficulty: Difficulty.intermediate,
      frets: [-1, 3, 5, 5, -1, -1],
      fingers: [0, 1, 3, 4, 0, 0],
      baseFret: 3,
      isOpen: false,
    ),
    Chord(
      name: 'D5',
      type: ChordType.power,
      category: ChordCategory.power,
      difficulty: Difficulty.beginner,
      frets: [-1, -1, 0, 2, 3, -1],
      fingers: [0, 0, 0, 1, 3, 0],
      isOpen: true,
    ),
    Chord(
      name: 'E5',
      type: ChordType.power,
      category: ChordCategory.power,
      difficulty: Difficulty.beginner,
      frets: [0, 2, 2, -1, -1, -1],
      fingers: [0, 1, 3, 0, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'F5',
      type: ChordType.power,
      category: ChordCategory.power,
      difficulty: Difficulty.intermediate,
      frets: [1, 3, 3, -1, -1, -1],
      fingers: [1, 3, 4, 0, 0, 0],
      baseFret: 1,
      isOpen: false,
    ),
    Chord(
      name: 'G5',
      type: ChordType.power,
      category: ChordCategory.power,
      difficulty: Difficulty.beginner,
      frets: [3, 5, 5, -1, -1, -1],
      fingers: [1, 3, 4, 0, 0, 0],
      baseFret: 3,
      isOpen: false,
    ),

    // ═══════════════════════════════════════════════════════════════
    // SLASH CHORDS (Intermediate/Advanced)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'C/G',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.intermediate,
      frets: [3, 3, 2, 0, 1, 0],
      fingers: [3, 4, 2, 0, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'D/F#',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.intermediate,
      frets: [2, 0, 0, 2, 3, 2],
      fingers: [1, 0, 0, 2, 4, 3],
      isOpen: true,
    ),
    Chord(
      name: 'G/B',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.intermediate,
      frets: [-1, 2, 0, 0, 0, 3],
      fingers: [0, 1, 0, 0, 0, 3],
      isOpen: true,
    ),
    Chord(
      name: 'Am/G',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.intermediate,
      frets: [3, 0, 2, 2, 1, 0],
      fingers: [4, 0, 3, 2, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Am/E',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.intermediate,
      frets: [0, 0, 2, 2, 1, 0],
      fingers: [0, 0, 2, 3, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Em/D',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.intermediate,
      frets: [-1, -1, 0, 0, 0, 0],
      fingers: [0, 0, 0, 0, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'F/C',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.advanced,
      frets: [-1, 3, 3, 2, 1, 1],
      fingers: [0, 3, 4, 2, 1, 1],
      isOpen: false,
      isBarre: true,
    ),
    Chord(
      name: 'G/D',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.intermediate,
      frets: [-1, -1, 0, 0, 0, 3],
      fingers: [0, 0, 0, 0, 0, 3],
      isOpen: true,
    ),
    Chord(
      name: 'A/E',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.beginner,
      frets: [0, 0, 2, 2, 2, 0],
      fingers: [0, 0, 1, 2, 3, 0],
      isOpen: true,
    ),
    Chord(
      name: 'D/A',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.beginner,
      frets: [-1, 0, 0, 2, 3, 2],
      fingers: [0, 0, 0, 1, 3, 2],
      isOpen: true,
    ),
    Chord(
      name: 'C/E',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.intermediate,
      frets: [0, 3, 2, 0, 1, 0],
      fingers: [0, 3, 2, 0, 1, 0],
      isOpen: true,
    ),
    Chord(
      name: 'E/G#',
      type: ChordType.slash,
      category: ChordCategory.slash,
      difficulty: Difficulty.advanced,
      frets: [4, 2, 2, 1, 0, 0],
      fingers: [4, 2, 3, 1, 0, 0],
      isOpen: true,
    ),

    // ═══════════════════════════════════════════════════════════════
    // DIMINISHED CHORDS (Advanced)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Adim',
      type: ChordType.diminished,
      category: ChordCategory.diminished,
      difficulty: Difficulty.advanced,
      frets: [-1, 0, 1, 2, 1, -1],
      fingers: [0, 0, 1, 3, 2, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Bdim',
      type: ChordType.diminished,
      category: ChordCategory.diminished,
      difficulty: Difficulty.advanced,
      frets: [-1, 2, 3, 4, 3, -1],
      fingers: [0, 1, 2, 4, 3, 0],
      baseFret: 2,
      isOpen: false,
    ),
    Chord(
      name: 'Cdim',
      type: ChordType.diminished,
      category: ChordCategory.diminished,
      difficulty: Difficulty.advanced,
      frets: [-1, 3, 4, 5, 4, -1],
      fingers: [0, 1, 2, 4, 3, 0],
      baseFret: 3,
      isOpen: false,
    ),
    Chord(
      name: 'Ddim',
      type: ChordType.diminished,
      category: ChordCategory.diminished,
      difficulty: Difficulty.advanced,
      frets: [-1, -1, 0, 1, 0, 1],
      fingers: [0, 0, 0, 1, 0, 2],
      isOpen: true,
    ),
    Chord(
      name: 'Edim',
      type: ChordType.diminished,
      category: ChordCategory.diminished,
      difficulty: Difficulty.advanced,
      frets: [0, 1, 2, 0, -1, -1],
      fingers: [0, 1, 2, 0, 0, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Fdim',
      type: ChordType.diminished,
      category: ChordCategory.diminished,
      difficulty: Difficulty.advanced,
      frets: [-1, -1, 3, 4, 3, 4],
      fingers: [0, 0, 1, 3, 2, 4],
      baseFret: 1,
      isOpen: false,
    ),
    Chord(
      name: 'Gdim',
      type: ChordType.diminished,
      category: ChordCategory.diminished,
      difficulty: Difficulty.advanced,
      frets: [3, 4, 5, 3, -1, -1],
      fingers: [1, 2, 4, 1, 0, 0],
      baseFret: 3,
      isOpen: false,
    ),

    // ═══════════════════════════════════════════════════════════════
    // AUGMENTED CHORDS (Advanced)
    // ═══════════════════════════════════════════════════════════════
    Chord(
      name: 'Aaug',
      type: ChordType.augmented,
      category: ChordCategory.augmented,
      difficulty: Difficulty.advanced,
      frets: [-1, 0, 3, 2, 2, 1],
      fingers: [0, 0, 4, 2, 3, 1],
      isOpen: true,
    ),
    Chord(
      name: 'Caug',
      type: ChordType.augmented,
      category: ChordCategory.augmented,
      difficulty: Difficulty.advanced,
      frets: [-1, 3, 2, 1, 1, 0],
      fingers: [0, 4, 3, 1, 2, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Daug',
      type: ChordType.augmented,
      category: ChordCategory.augmented,
      difficulty: Difficulty.advanced,
      frets: [-1, -1, 0, 3, 3, 2],
      fingers: [0, 0, 0, 2, 3, 1],
      isOpen: true,
    ),
    Chord(
      name: 'Eaug',
      type: ChordType.augmented,
      category: ChordCategory.augmented,
      difficulty: Difficulty.advanced,
      frets: [0, 3, 2, 1, 1, 0],
      fingers: [0, 4, 3, 1, 2, 0],
      isOpen: true,
    ),
    Chord(
      name: 'Faug',
      type: ChordType.augmented,
      category: ChordCategory.augmented,
      difficulty: Difficulty.advanced,
      frets: [-1, -1, 3, 2, 2, 1],
      fingers: [0, 0, 4, 2, 3, 1],
      isOpen: false,
    ),
    Chord(
      name: 'Gaug',
      type: ChordType.augmented,
      category: ChordCategory.augmented,
      difficulty: Difficulty.advanced,
      frets: [3, 2, 1, 0, 0, 3],
      fingers: [3, 2, 1, 0, 0, 4],
      isOpen: true,
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // QUERY METHODS
  // ═══════════════════════════════════════════════════════════════

  List<Chord> getChordsByType(ChordType type) {
    return allChords.where((chord) => chord.type == type).toList();
  }

  List<Chord> getChordsByCategory(ChordCategory category) {
    return allChords.where((chord) => chord.category == category).toList();
  }

  List<Chord> getChordsByCategories(Set<ChordCategory> categories) {
    if (categories.isEmpty) return [];
    return allChords
        .where((chord) => categories.contains(chord.category))
        .toList();
  }

  List<Chord> getChordsByDifficulty(Difficulty difficulty) {
    return allChords.where((chord) => chord.difficulty == difficulty).toList();
  }

  List<Chord> getChordsByDifficultyAndBelow(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.beginner:
        return getChordsByDifficulty(Difficulty.beginner);
      case Difficulty.intermediate:
        return allChords
            .where((chord) =>
                chord.difficulty == Difficulty.beginner ||
                chord.difficulty == Difficulty.intermediate)
            .toList();
      case Difficulty.advanced:
        return allChords;
    }
  }

  List<Chord> getMajorChords() => getChordsByCategory(ChordCategory.major);
  List<Chord> getMinorChords() => getChordsByCategory(ChordCategory.minor);
  List<Chord> getBarreChords() => allChords.where((c) => c.isBarre).toList();
  List<Chord> getBeginnerChords() => getChordsByDifficulty(Difficulty.beginner);
  List<Chord> getSeventhChords() => getChordsByCategory(ChordCategory.seventh);
  List<Chord> getSuspendedChords() =>
      getChordsByCategory(ChordCategory.suspended);
  List<Chord> getAddedChords() => getChordsByCategory(ChordCategory.added);
  List<Chord> getExtendedChords() =>
      getChordsByCategory(ChordCategory.extended);
  List<Chord> getSlashChords() => getChordsByCategory(ChordCategory.slash);
  List<Chord> getPowerChords() => getChordsByCategory(ChordCategory.power);
  List<Chord> getDiminishedChords() =>
      getChordsByCategory(ChordCategory.diminished);
  List<Chord> getAugmentedChords() =>
      getChordsByCategory(ChordCategory.augmented);

  Chord? getChordByName(String name) {
    try {
      return allChords.firstWhere((chord) => chord.name == name);
    } catch (e) {
      return null;
    }
  }

  /// Get chords filtered by difficulty level for chord trainer
  /// Beginner: open chords only
  /// Intermediate: open + basic barre + 7 chords
  /// Advanced: full acoustic chord set
  List<Chord> getChordsForTrainerDifficulty(Difficulty? difficulty) {
    if (difficulty == null) return allChords;
    return getChordsByDifficultyAndBelow(difficulty);
  }
}
