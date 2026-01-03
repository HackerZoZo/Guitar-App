/// Musical time signature with comprehensive metadata
/// 
/// Each time signature has specific musical characteristics that affect
/// how strumming patterns are generated and how they feel when played.
enum TimeSignature {
  /// 2/4 - Two quarter notes per bar
  /// Feel: March-like, punchy, direct
  /// Common in: Polka, marches, punk rock
  time2_4(
    beats: 2,
    noteValue: 4,
    subdivision: 2, // 8th notes
    feel: 'March, punk, fast folk',
    strongBeats: [0], // Beat 1 is strong
    mediumBeats: [], // Beat 2 is weak
    accentPattern: [AccentStrength.strong, AccentStrength.weak],
  ),

  /// 3/4 - Three quarter notes per bar (Waltz)
  /// Feel: Flowing, romantic, lilting
  /// Common in: Waltzes, ballads, country
  time3_4(
    beats: 3,
    noteValue: 4,
    subdivision: 2, // 8th notes
    feel: 'Waltz, soft romantic',
    strongBeats: [0], // Beat 1
    mediumBeats: [], // Beats 2 & 3 are weak
    accentPattern: [AccentStrength.strong, AccentStrength.weak, AccentStrength.weak],
  ),

  /// 4/4 - Four quarter notes per bar (Common time)
  /// Feel: Balanced, groovy, universal
  /// Common in: Pop, rock, Bollywood, most modern music
  time4_4(
    beats: 4,
    noteValue: 4,
    subdivision: 2, // 8th notes
    feel: 'Most pop, rock, Bollywood',
    strongBeats: [0], // Beat 1 is strongest
    mediumBeats: [2], // Beat 3 is medium strong
    accentPattern: [
      AccentStrength.strong,
      AccentStrength.weak,
      AccentStrength.medium,
      AccentStrength.weak,
    ],
  ),

  /// 6/8 - Six eighth notes per bar (Compound duple)
  /// Feel: Rolling, lilting, emotional
  /// Common in: Irish jigs, ballads, gospel
  /// Grouped as: 1-2-3 4-5-6 (two groups of three)
  time6_8(
    beats: 6,
    noteValue: 8,
    subdivision: 3, // Triplet feel
    feel: 'Rolling, emotional',
    strongBeats: [0], // Beat 1
    mediumBeats: [3], // Beat 4
    accentPattern: [
      AccentStrength.strong, // 1
      AccentStrength.weak,   // 2
      AccentStrength.weak,   // 3
      AccentStrength.medium, // 4
      AccentStrength.weak,   // 5
      AccentStrength.weak,   // 6
    ],
  ),

  /// 12/8 - Twelve eighth notes per bar (Compound quadruple)
  /// Feel: Slow, bluesy, emotional
  /// Common in: Blues, soul, slow rock ballads
  /// Grouped as: 1-2-3 4-5-6 7-8-9 10-11-12 (four groups of three)
  time12_8(
    beats: 12,
    noteValue: 8,
    subdivision: 3, // Triplet feel
    feel: 'Blues, slow rock',
    strongBeats: [0], // Beat 1
    mediumBeats: [3, 6, 9], // Beats 4, 7, 10
    accentPattern: [
      AccentStrength.strong,  // 1
      AccentStrength.weak,    // 2
      AccentStrength.weak,    // 3
      AccentStrength.medium,  // 4
      AccentStrength.weak,    // 5
      AccentStrength.weak,    // 6
      AccentStrength.medium,  // 7
      AccentStrength.weak,    // 8
      AccentStrength.weak,    // 9
      AccentStrength.medium,  // 10
      AccentStrength.weak,    // 11
      AccentStrength.weak,    // 12
    ],
  ),

  /// 5/4 - Five quarter notes per bar (Asymmetrical)
  /// Feel: Unusual, progressive, cinematic
  /// Common in: Prog rock, jazz, experimental
  /// Typically grouped as: 3+2 or 2+3
  time5_4(
    beats: 5,
    noteValue: 4,
    subdivision: 2, // 8th notes
    feel: 'Progressive, experimental',
    strongBeats: [0], // Beat 1
    mediumBeats: [3], // Beat 4 (if grouped 3+2)
    accentPattern: [
      AccentStrength.strong,  // 1 (Start of 3-group)
      AccentStrength.weak,    // 2
      AccentStrength.weak,    // 3
      AccentStrength.medium,  // 4 (Start of 2-group)
      AccentStrength.weak,    // 5
    ],
  ),

  /// 7/8 - Seven eighth notes per bar (Asymmetrical)
  /// Feel: Driving, complex, ethnic
  /// Common in: Balkan music, prog rock, fusion
  /// Typically grouped as: 2+2+3
  time7_8(
    beats: 7,
    noteValue: 8,
    subdivision: 2, // 8th notes
    feel: 'Fusion, odd groove',
    strongBeats: [0], // Beat 1
    mediumBeats: [2, 4], // Beats 3, 5 (group starts)
    accentPattern: [
      AccentStrength.strong,  // 1 (Start of first 2-group)
      AccentStrength.weak,    // 2
      AccentStrength.medium,  // 3 (Start of second 2-group)
      AccentStrength.weak,    // 4
      AccentStrength.medium,  // 5 (Start of 3-group)
      AccentStrength.weak,    // 6
      AccentStrength.weak,    // 7
    ],
  );

  const TimeSignature({
    required this.beats,
    required this.noteValue,
    required this.subdivision,
    required this.feel,
    required this.strongBeats,
    required this.mediumBeats,
    required this.accentPattern,
  });

  /// Number of beats per bar
  final int beats;

  /// Bottom number of time signature (4 = quarter note, 8 = eighth note)
  final int noteValue;

  /// Subdivision per beat (2 = eighth notes, 3 = triplets)
  final int subdivision;

  /// Musical feel/character description
  final String feel;

  /// Indices of strong beats (0-indexed)
  final List<int> strongBeats;

  /// Indices of medium-strong beats (0-indexed)
  final List<int> mediumBeats;

  /// Accent pattern for each beat
  final List<AccentStrength> accentPattern;

  /// Get display name (e.g., "4/4")
  String get displayName => '$beats/$noteValue';

  /// Get total subdivisions in the bar
  /// For example: 4/4 with 8th note subdivision = 8 slots
  int get totalSubdivisions => beats * subdivision;

  /// Check if a beat index is a strong beat
  bool isStrongBeat(int beatIndex) => strongBeats.contains(beatIndex);

  /// Check if a beat index is a medium beat
  bool isMediumBeat(int beatIndex) => mediumBeats.contains(beatIndex);

  /// Get accent strength for a specific beat
  AccentStrength getAccentStrength(int beatIndex) {
    if (beatIndex >= 0 && beatIndex < accentPattern.length) {
      return accentPattern[beatIndex];
    }
    return AccentStrength.weak;
  }

  /// Get weight for pattern generation (higher = more likely to have a stroke)
  /// Used for smart randomness in pattern generation
  double getBeatWeight(int beatIndex, int subdivision) {
    if (beatIndex < 0) return 0.0;
    
    final beat = beatIndex ~/ subdivision;
    final subBeat = beatIndex % subdivision;
    
    // Strong beats get highest weight
    if (subBeat == 0) {
      if (isStrongBeat(beat)) return 1.0;
      if (isMediumBeat(beat)) return 0.75;
      return 0.5;
    }
    
    // Off-beats get lower weight
    if (subBeat == subdivision ~/ 2) return 0.4; // "and" of the beat
    
    return 0.25; // Other subdivisions
  }
}

/// Accent strength for beats in a bar
enum AccentStrength {
  strong,  // Primary accent (beat 1)
  medium,  // Secondary accent (beat 3 in 4/4)
  weak,    // Unaccented beats
}
