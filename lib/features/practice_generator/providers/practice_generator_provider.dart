import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/chord.dart' show ChordCategory, Difficulty;
import '../../../core/models/practice_pattern.dart';
import '../../../core/models/time_signature.dart';
import '../../../core/services/practice_generator.dart';
import '../../../core/services/metronome_engine.dart';
import '../../../core/providers/providers.dart';

final practiceGeneratorProvider = StateNotifierProvider<PracticeGeneratorNotifier, PracticeGeneratorState>((ref) {
  return PracticeGeneratorNotifier(
    PracticePatternGenerator(ref.read(chordRepositoryProvider)),
    ref.read(metronomeEngineProvider),
  );
});

class PracticeGeneratorState {
  final PracticeConfig config;
  final PracticePattern? currentPattern;
  final bool isPlaying;
  final int currentBeat;
  final int currentBar;
  final List<String>? lockedChords; // For practice mode

  const PracticeGeneratorState({
    this.config = const PracticeConfig(),
    this.currentPattern,
    this.isPlaying = false,
    this.currentBeat = 0,
    this.currentBar = 0,
    this.lockedChords,
  });

  PracticeGeneratorState copyWith({
    PracticeConfig? config,
    PracticePattern? currentPattern,
    bool? isPlaying,
    int? currentBeat,
    int? currentBar,
    List<String>? lockedChords,
  }) {
    return PracticeGeneratorState(
      config: config ?? this.config,
      currentPattern: currentPattern ?? this.currentPattern,
      isPlaying: isPlaying ?? this.isPlaying,
      currentBeat: currentBeat ?? this.currentBeat,
      currentBar: currentBar ?? this.currentBar,
      lockedChords: lockedChords ?? this.lockedChords,
    );
  }
}

class PracticeGeneratorNotifier extends StateNotifier<PracticeGeneratorState> {
  final PracticePatternGenerator _generator;
  final MetronomeEngine _metronomeEngine;
  StreamSubscription? _beatSubscription;
  PracticePattern? _lockedPattern; // For grooveExploration mode

  PracticeGeneratorNotifier(this._generator, this._metronomeEngine)
      : super(const PracticeGeneratorState()) {
    generateNewPattern();
  }

  void updateConfig(PracticeConfig newConfig) {
    state = state.copyWith(config: newConfig);
    
    // Reset locked data if time signature or bars changed
    if (newConfig.timeSignature != state.config.timeSignature ||
        newConfig.numBars != state.config.numBars) {
      _lockedPattern = null;
      state = state.copyWith(lockedChords: null);
    }
    
    generateNewPattern();
  }

  void setDifficulty(Difficulty difficulty) {
    updateConfig(state.config.copyWith(difficulty: difficulty));
  }

  void setTimeSignature(TimeSignature timeSignature) {
    updateConfig(state.config.copyWith(timeSignature: timeSignature));
  }

  void setBpm(int bpm) {
    updateConfig(state.config.copyWith(bpm: bpm));
  }

  void setNumBars(int numBars) {
    updateConfig(state.config.copyWith(numBars: numBars));
  }

  void setMode(PracticeMode mode) {
    updateConfig(state.config.copyWith(mode: mode));
    
    // Lock current chords when switching to practice mode
    if (mode == PracticeMode.practice && state.currentPattern != null) {
      state = state.copyWith(lockedChords: state.currentPattern!.chords);
    }
    
    // Lock current pattern when switching to groove exploration
    if (mode == PracticeMode.grooveExploration && state.currentPattern != null) {
      _lockedPattern = state.currentPattern;
    }
  }

  void toggleChordCategory(ChordCategory category) {
    final categories = Set<ChordCategory>.from(state.config.chordCategories);
    
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
    
    if (categories.isEmpty) {
      categories.add(ChordCategory.major); // Always have at least one
    }
    
    updateConfig(state.config.copyWith(chordCategories: categories));
  }

  void setCustomChords(List<String> chords) {
    updateConfig(state.config.copyWith(customChords: chords));
  }

  void generateNewPattern() {
    PracticePattern newPattern;

    switch (state.config.mode) {
      case PracticeMode.practice:
        // Keep chords, new pattern
        if (state.lockedChords != null && state.lockedChords!.isNotEmpty) {
          newPattern = _generator.generate(state.config);
          newPattern = PracticePattern(
            chords: state.lockedChords!,
            strokes: newPattern.strokes,
            config: newPattern.config,
            numBars: newPattern.numBars,
          );
        } else {
          newPattern = _generator.generate(state.config);
          state = state.copyWith(lockedChords: newPattern.chords);
        }
        break;

      case PracticeMode.grooveExploration:
        // Keep pattern, new chords
        if (_lockedPattern != null) {
          newPattern = _generator.generate(state.config);
          newPattern = PracticePattern(
            chords: newPattern.chords,
            strokes: _lockedPattern!.strokes,
            config: newPattern.config,
            numBars: newPattern.numBars,
          );
        } else {
          newPattern = _generator.generate(state.config);
          _lockedPattern = newPattern;
        }
        break;

      case PracticeMode.jam:
        // Change everything
        newPattern = _generator.generate(state.config);
        break;
    }

    state = state.copyWith(currentPattern: newPattern);
  }

  void start() {
    if (state.currentPattern == null) return;

    state = state.copyWith(
      isPlaying: true,
      currentBeat: 0,
      currentBar: 0,
    );

    _metronomeEngine.start(
      bpm: state.config.bpm,
      beatsPerBar: state.config.timeSignature.beats,
    );

    _beatSubscription = _metronomeEngine.beatStream.listen((beat) {
      final beatsPerBar = state.config.timeSignature.beats;
      final currentBar = beat ~/ beatsPerBar;
      final currentBeat = beat % beatsPerBar;

      state = state.copyWith(
        currentBeat: currentBeat,
        currentBar: currentBar,
      );
    });
  }

  void stop() {
    _metronomeEngine.stop();
    _beatSubscription?.cancel();
    state = state.copyWith(
      isPlaying: false,
      currentBeat: 0,
      currentBar: 0,
    );
  }

  @override
  void dispose() {
    _beatSubscription?.cancel();
    super.dispose();
  }
}
