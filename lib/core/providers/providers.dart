import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/metronome_engine.dart';
import '../services/generators.dart';
import '../data/chord_repository.dart';
import '../data/exercise_repository.dart';

// Repositories
final chordRepositoryProvider = Provider((ref) => ChordRepository());
final exerciseRepositoryProvider = Provider((ref) => ExerciseRepository());

// Generators
final chordGeneratorProvider = Provider((ref) => ChordGenerator());
final strummingGeneratorProvider = Provider((ref) => StrummingPatternGenerator());

// Metronome (singleton)
final metronomeEngineProvider = Provider((ref) {
  final engine = MetronomeEngine();
  engine.initialize();
  ref.onDispose(() => engine.dispose());
  return engine;
});

// Metronome State
final metronomeStateProvider = StateNotifierProvider<MetronomeStateNotifier, MetronomeState>((ref) {
  final engine = ref.watch(metronomeEngineProvider);
  return MetronomeStateNotifier(engine);
});

class MetronomeState {
  final bool isRunning;
  final int bpm;
  final int currentBeat;
  final int beatsPerBar;

  const MetronomeState({
    this.isRunning = false,
    this.bpm = 80,
    this.currentBeat = 0,
    this.beatsPerBar = 4,
  });

  MetronomeState copyWith({
    bool? isRunning,
    int? bpm,
    int? currentBeat,
    int? beatsPerBar,
  }) {
    return MetronomeState(
      isRunning: isRunning ?? this.isRunning,
      bpm: bpm ?? this.bpm,
      currentBeat: currentBeat ?? this.currentBeat,
      beatsPerBar: beatsPerBar ?? this.beatsPerBar,
    );
  }
}

class MetronomeStateNotifier extends StateNotifier<MetronomeState> {
  final MetronomeEngine _engine;

  MetronomeStateNotifier(this._engine) : super(const MetronomeState()) {
    _engine.beatStream.listen((beat) {
      state = state.copyWith(currentBeat: beat);
    });
  }

  void start() {
    _engine.start(bpm: state.bpm, beatsPerBar: state.beatsPerBar);
    state = state.copyWith(isRunning: true);
  }

  void stop() {
    _engine.stop();
    state = state.copyWith(isRunning: false, currentBeat: 0);
  }

  void setBpm(int bpm) {
    _engine.setBpm(bpm);
    state = state.copyWith(bpm: bpm);
  }

  void setBeatsPerBar(int beats) {
    final wasRunning = state.isRunning;
    if (wasRunning) stop();
    state = state.copyWith(beatsPerBar: beats);
    if (wasRunning) start();
  }

  void toggle() {
    if (state.isRunning) {
      stop();
    } else {
      start();
    }
  }
}
