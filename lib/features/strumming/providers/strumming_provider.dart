import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/chord.dart';
import '../../../core/models/strumming_pattern.dart';
import '../../../core/services/generators.dart';
import '../../../core/providers/providers.dart';

final strummingProvider = StateNotifierProvider<StrummingNotifier, StrummingState>((ref) {
  return StrummingNotifier(
    ref.read(strummingGeneratorProvider),
    ref.read(metronomeEngineProvider),
  );
});

class StrummingState {
  final Difficulty difficulty;
  final int bpm;
  final int beatsPerBar;
  final bool isPlaying;
  final StrummingPattern? currentPattern;
  final int currentBeat;

  const StrummingState({
    this.difficulty = Difficulty.beginner,
    this.bpm = 80,
    this.beatsPerBar = 4,
    this.isPlaying = false,
    this.currentPattern,
    this.currentBeat = 0,
  });

  StrummingState copyWith({
    Difficulty? difficulty,
    int? bpm,
    int? beatsPerBar,
    bool? isPlaying,
    StrummingPattern? currentPattern,
    int? currentBeat,
  }) {
    return StrummingState(
      difficulty: difficulty ?? this.difficulty,
      bpm: bpm ?? this.bpm,
      beatsPerBar: beatsPerBar ?? this.beatsPerBar,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPattern: currentPattern ?? this.currentPattern,
      currentBeat: currentBeat ?? this.currentBeat,
    );
  }
}

class StrummingNotifier extends StateNotifier<StrummingState> {
  final StrummingPatternGenerator _generator;
  final _metronomeEngine;
  StreamSubscription? _beatSubscription;

  StrummingNotifier(this._generator, this._metronomeEngine) 
      : super(const StrummingState()) {
    generateNewPattern();
  }

  void setDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
    generateNewPattern();
  }

  void setBpm(int bpm) {
    state = state.copyWith(bpm: bpm);
  }

  void setBeatsPerBar(int beats) {
    state = state.copyWith(beatsPerBar: beats);
    generateNewPattern();
  }

  void generateNewPattern() {
    final pattern = _generator.generate(
      difficulty: state.difficulty,
      beatsPerBar: state.beatsPerBar,
    );
    state = state.copyWith(currentPattern: pattern);
  }

  void start() {
    if (state.currentPattern == null) return;

    state = state.copyWith(isPlaying: true, currentBeat: 0);

    _metronomeEngine.start(
      bpm: state.bpm,
      beatsPerBar: state.beatsPerBar,
    );

    _beatSubscription = _metronomeEngine.beatStream.listen((beat) {
      state = state.copyWith(currentBeat: beat);
    });
  }

  void stop() {
    _metronomeEngine.stop();
    _beatSubscription?.cancel();
    state = state.copyWith(isPlaying: false, currentBeat: 0);
  }

  void changePattern() {
    generateNewPattern();
  }

  @override
  void dispose() {
    _beatSubscription?.cancel();
    super.dispose();
  }
}
