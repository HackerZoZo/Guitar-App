import '../models/exercise.dart';

class ExerciseRepository {
  static const List<Exercise> allExercises = [
    Exercise(
      id: 'spider',
      name: 'Spider Exercise',
      description: 'Classic finger independence and coordination builder',
      instructions: '''
1. Start on the 5th fret, low E string
2. Play frets 5-6-7-8 with fingers 1-2-3-4
3. Move to the next string and repeat
4. Work your way across all 6 strings
5. Return back down the strings
6. Keep fingers close to fretboard

Pattern: 
E: 5-6-7-8
A: 5-6-7-8
D: 5-6-7-8
G: 5-6-7-8
B: 5-6-7-8
e: 5-6-7-8
''',
      benefits: [
        'Builds finger independence',
        'Improves coordination',
        'Develops muscle memory',
        'Increases fretboard familiarity'
      ],
      defaultBpm: 60,
      minBpm: 40,
      maxBpm: 180,
    ),
    
    Exercise(
      id: 'chromatic',
      name: '1-2-3-4 Chromatic',
      description: 'Fundamental chromatic scale exercise for all fingers',
      instructions: '''
1. Place finger 1 on fret 1, low E string
2. Play frets 1-2-3-4 ascending
3. Move to next string, same frets
4. Continue across all strings
5. Return with reverse pattern 4-3-2-1
6. Maintain even timing

Focus on:
- Clean note separation
- Even volume across all fingers
- Minimal finger lift
''',
      benefits: [
        'Strengthens all fingers equally',
        'Improves fretting hand dexterity',
        'Builds finger strength',
        'Perfect for warming up'
      ],
      defaultBpm: 60,
      minBpm: 40,
      maxBpm: 160,
    ),
    
    Exercise(
      id: 'stretching',
      name: 'Finger Stretching',
      description: 'Expand your reach and flexibility between fingers',
      instructions: '''
1. Start on fret 5, low E string
2. Play frets 5-7-9-12 (one finger per fret)
3. This creates a wide stretch
4. Hold each note briefly
5. Move across all strings
6. Gradually increase stretch distance

Variation 1: 5-6-8-10
Variation 2: 3-5-7-10

IMPORTANT: Never force - stop if pain occurs
''',
      benefits: [
        'Increases finger span',
        'Improves flexibility',
        'Prepares for barre chords',
        'Reduces tension'
      ],
      defaultBpm: 50,
      minBpm: 40,
      maxBpm: 100,
    ),
    
    Exercise(
      id: 'speed_builder',
      name: 'Speed Building',
      description: 'Develop speed while maintaining accuracy and clarity',
      instructions: '''
1. Choose a simple 4-note pattern (e.g., 5-6-7-8)
2. Play on one string, repeating the pattern
3. Start VERY slow - focus on perfect timing
4. Use a metronome
5. Increase BPM by 5 when comfortable
6. Reset to slow tempo if mistakes occur

Patterns to try:
- 5-6-7-8 (ascending)
- 8-7-6-5 (descending)
- 5-8-6-7 (mixed)
- 5-7-8-6 (string skipping preparation)

Key: ACCURACY over speed!
''',
      benefits: [
        'Builds picking speed',
        'Improves timing precision',
        'Develops muscle memory',
        'Increases endurance'
      ],
      defaultBpm: 80,
      minBpm: 60,
      maxBpm: 220,
    ),
  ];

  List<Exercise> getAllExercises() => allExercises;
  
  Exercise? getExerciseById(String id) {
    try {
      return allExercises.firstWhere((ex) => ex.id == id);
    } catch (e) {
      return null;
    }
  }
}
