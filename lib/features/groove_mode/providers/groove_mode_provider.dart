import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/chord.dart';
import '../../../core/models/groove.dart';
import '../../../core/data/chord_repository.dart';
import '../../../core/services/metronome_engine.dart';
import '../../../core/providers/providers.dart';

final grooveModeProvider =
    StateNotifierProvider<GrooveModeNotifier, GrooveModeState>((ref) {
  return GrooveModeNotifier(
    ref.read(metronomeEngineProvider),
  );
});

class GrooveModeState {
  final List<Chord> availableChords;
  final Set<ChordCategory> selectedCategories;
  final Difficulty? difficulty;
  final int bpm;
  final int beatsPerBar;
  final bool isPlaying;
  final int currentBeat;
  final int sequenceLength;
  final Groove? currentGroove;

  const GrooveModeState({
    required this.availableChords,
    this.selectedCategories = const {},
    this.difficulty,
    this.bpm = 80,
    this.beatsPerBar = 4,
    this.isPlaying = false,
    this.currentBeat = 0,
    this.sequenceLength = 4,
    this.currentGroove,
  });

  /// Get chords filtered by selected categories and difficulty
  List<Chord> get filteredChords {
    var chords = availableChords;

    // Filter by categories if any are selected
    if (selectedCategories.isNotEmpty) {
      chords =
          chords.where((c) => selectedCategories.contains(c.category)).toList();
    }

    // Filter by difficulty if selected
    if (difficulty != null) {
      chords = chords.where((c) {
        switch (difficulty) {
          case Difficulty.beginner:
            return c.difficulty == Difficulty.beginner;
          case Difficulty.intermediate:
            return c.difficulty == Difficulty.beginner ||
                c.difficulty == Difficulty.intermediate;
          case Difficulty.advanced:
            return true;
          case null:
            return true;
        }
      }).toList();
    }

    return chords;
  }

  GrooveModeState copyWith({
    List<Chord>? availableChords,
    Set<ChordCategory>? selectedCategories,
    Difficulty? difficulty,
    bool clearDifficulty = false,
    int? bpm,
    int? beatsPerBar,
    bool? isPlaying,
    int? currentBeat,
    int? sequenceLength,
    Groove? currentGroove,
  }) {
    return GrooveModeState(
      availableChords: availableChords ?? this.availableChords,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      difficulty: clearDifficulty ? null : (difficulty ?? this.difficulty),
      bpm: bpm ?? this.bpm,
      beatsPerBar: beatsPerBar ?? this.beatsPerBar,
      isPlaying: isPlaying ?? this.isPlaying,
      currentBeat: currentBeat ?? this.currentBeat,
      sequenceLength: sequenceLength ?? this.sequenceLength,
      currentGroove: currentGroove ?? this.currentGroove,
    );
  }
}

class GrooveModeNotifier extends StateNotifier<GrooveModeState> {
  final MetronomeEngine _metronomeEngine;
  final Random _random = Random();
  StreamSubscription? _beatSubscription;

  GrooveModeNotifier(
    this._metronomeEngine,
  ) : super(const GrooveModeState(
          availableChords: ChordRepository.allChords,
        ));

  void toggleCategory(ChordCategory category) {
    final categories = Set<ChordCategory>.from(state.selectedCategories);
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
    state = state.copyWith(selectedCategories: categories);
  }

  void selectAllCategories() {
    state = state.copyWith(
      selectedCategories: Set.from(ChordCategory.values),
    );
  }

  void clearAllCategories() {
    state = state.copyWith(selectedCategories: {});
  }

  void setDifficulty(Difficulty? difficulty) {
    state = state.copyWith(
        difficulty: difficulty, clearDifficulty: difficulty == null);
  }

  void setBpm(int bpm) {
    state = state.copyWith(bpm: bpm);
  }

  void setSequenceLength(int length) {
    state = state.copyWith(sequenceLength: length.clamp(2, 8));
  }

  /// Generate a new groove with random chords and pattern
  Groove _generateNewGroove() {
    final chords = state.filteredChords;
    if (chords.isEmpty) {
      // Fallback to beginner chords
      return Groove(
        chords: [
          ChordRepository.allChords.firstWhere((c) => c.name == 'Am'),
          ChordRepository.allChords.firstWhere((c) => c.name == 'Dm'),
          ChordRepository.allChords.firstWhere((c) => c.name == 'C'),
        ],
        strummingPattern: 'DDUD',
      );
    }

    // Generate random chord sequence
    final randomChords = <Chord>[];
    for (int i = 0; i < state.sequenceLength; i++) {
      randomChords.add(chords[_random.nextInt(chords.length)]);
    }

    // Generate random strumming pattern
    const strummingSymbols = ['D', 'U'];
    final patternLength = _random.nextInt(4) + 4; // 4-7 strokes
    final pattern = List.generate(
      patternLength,
      (_) => strummingSymbols[_random.nextInt(strummingSymbols.length)],
    ).join();

    return Groove(
      chords: randomChords,
      strummingPattern: pattern,
      playCount: 0,
    );
  }

  void start() {
    if (state.filteredChords.isEmpty) return;

    final groove = _generateNewGroove();
    state = state.copyWith(
      currentGroove: groove,
      isPlaying: true,
      currentBeat: 0,
    );

    _metronomeEngine.start(
      bpm: state.bpm,
      beatsPerBar: state.beatsPerBar,
    );

    _beatSubscription = _metronomeEngine.beatStream.listen((beat) {
      state = state.copyWith(currentBeat: beat);

      // Detect end of bar/sequence
      if (beat == 0 && state.currentBeat != 0) {
        // One play-through complete
        final groove = state.currentGroove!;
        final newPlayCount = groove.playCount + 1;

        if (newPlayCount >= 4) {
          // Generate new groove and reset play count
          final newGroove = _generateNewGroove();
          state = state.copyWith(currentGroove: newGroove);
        } else {
          // Continue with same groove
          state = state.copyWith(
            currentGroove: groove.copyWith(playCount: newPlayCount),
          );
        }
      }
    });
  }

  void stop() {
    _metronomeEngine.stop();
    _beatSubscription?.cancel();
    state = state.copyWith(
      isPlaying: false,
      currentBeat: 0,
    );
  }

  @override
  void dispose() {
    _beatSubscription?.cancel();
    super.dispose();
  }
}
