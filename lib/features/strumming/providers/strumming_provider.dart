import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/chord.dart';
import '../../../core/models/strumming_pattern.dart';
import '../../../core/models/time_signature.dart';
import '../../../core/services/generators.dart';
import '../../../core/services/metronome_engine.dart';
import '../../../core/providers/providers.dart';

final strummingProvider = StateNotifierProvider<StrummingNotifier, StrummingState>((ref) {
  return StrummingNotifier(
    ref.read(strummingGeneratorProvider),
    ref.read(metronomeEngineProvider),
  );
});

class StrummingState {
  final Difficulty difficulty;
  final TimeSignature timeSignature;
  final int bpm;
  final bool isPlaying;
  final StrummingPattern? currentPattern;
  final int currentBeat;
  final int currentSubdivision;
  final bool grooveLocked;

  const StrummingState({
    this.difficulty = Difficulty.beginner,
    this.timeSignature = TimeSignature.time4_4,
    this.bpm = 80,
    this.isPlaying = false,
    this.currentPattern,
    this.currentBeat = 0,
    this.currentSubdivision = 0,
    this.grooveLocked = false,
  });

  StrummingState copyWith({
    Difficulty? difficulty,
    TimeSignature? timeSignature,
    int? bpm,
    bool? isPlaying,
    StrummingPattern? currentPattern,
    int? currentBeat,
    int? currentSubdivision,
    bool? grooveLocked,
  }) {
    return StrummingState(
      difficulty: difficulty ?? this.difficulty,
      timeSignature: timeSignature ?? this.timeSignature,
      bpm: bpm ?? this.bpm,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPattern: currentPattern ?? this.currentPattern,
      currentBeat: currentBeat ?? this.currentBeat,
      currentSubdivision: currentSubdivision ?? this.currentSubdivision,
      grooveLocked: grooveLocked ?? this.grooveLocked,
    );
  }

  /// Legacy getter for backwards compatibility
  int get beatsPerBar => timeSignature.beats;
}

class StrummingNotifier extends StateNotifier<StrummingState> {
  final StrummingPatternGenerator _generator;
  final MetronomeEngine _metronomeEngine;
  StreamSubscription? _beatSubscription;
  int _barCount = 0;

  StrummingNotifier(this._generator, this._metronomeEngine) 
      : super(const StrummingState()) {
    generateNewPattern();
  }

  void setDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
    generateNewPattern();
  }

  void setTimeSignature(TimeSignature timeSignature) {
    state = state.copyWith(timeSignature: timeSignature);
    generateNewPattern();
  }

  void setBpm(int bpm) {
    state = state.copyWith(bpm: bpm);
  }

  void toggleGrooveLock() {
    state = state.copyWith(grooveLocked: !state.grooveLocked);
  }

  void generateNewPattern() {
    // Generate completely random pattern every time
    // The variationNumber is passed but the generator uses random probabilities
    final pattern = _generator.generate(
      difficulty: state.difficulty,
      timeSignature: state.timeSignature,
      variationNumber: DateTime.now().millisecondsSinceEpoch % 10000, // Use timestamp for randomness
    );
    
    state = state.copyWith(currentPattern: pattern);
  }

  void start() {
    if (state.currentPattern == null) return;

    state = state.copyWith(
      isPlaying: true,
      currentBeat: 0,
      currentSubdivision: 0,
    );
    _barCount = 0;

    _metronomeEngine.start(
      bpm: state.bpm,
      beatsPerBar: state.timeSignature.beats,
    );

    _beatSubscription = _metronomeEngine.beatStream.listen((beat) {
      state = state.copyWith(currentBeat: beat);

      // Auto-generate new random pattern every 4 bars if not locked
      if (beat == 0 && !state.grooveLocked) {
        _barCount++;
        
        // Generate completely new random pattern every 4 bars
        if (_barCount % 4 == 0) {
          final newPattern = _generator.generate(
            difficulty: state.difficulty,
            timeSignature: state.timeSignature,
            variationNumber: DateTime.now().millisecondsSinceEpoch % 10000,
          );
          state = state.copyWith(currentPattern: newPattern);
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
      currentSubdivision: 0,
    );
    _barCount = 0;
  }

  void changePattern() {
    // Always generate completely new random pattern
    generateNewPattern();
  }

  @override
  void dispose() {
    _beatSubscription?.cancel();
    super.dispose();
  }
}
