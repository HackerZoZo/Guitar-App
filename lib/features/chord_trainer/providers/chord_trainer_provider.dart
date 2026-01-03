import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/chord.dart';
import '../../../core/data/chord_repository.dart';
import '../../../core/services/generators.dart';
import '../../../core/services/metronome_engine.dart';
import '../../../core/providers/providers.dart';

final chordTrainerProvider = StateNotifierProvider<ChordTrainerNotifier, ChordTrainerState>((ref) {
  return ChordTrainerNotifier(
    ref.read(chordGeneratorProvider),
    ref.read(metronomeEngineProvider),
  );
});

class ChordTrainerState {
  final List<Chord> availableChords;
  final List<Chord> selectedChords;
  final Difficulty? difficulty;
  final int bpm;
  final int sessionMinutes;
  final int beatsPerBar;
  final bool isPlaying;
  final int currentBeat;
  final Chord? currentChord;

  const ChordTrainerState({
    required this.availableChords,
    this.selectedChords = const [],
    this.difficulty,
    this.bpm = 80,
    this.sessionMinutes = 2,
    this.beatsPerBar = 4,
    this.isPlaying = false,
    this.currentBeat = 0,
    this.currentChord,
  });

  ChordTrainerState copyWith({
    List<Chord>? availableChords,
    List<Chord>? selectedChords,
    Difficulty? difficulty,
    bool clearDifficulty = false,
    int? bpm,
    int? sessionMinutes,
    int? beatsPerBar,
    bool? isPlaying,
    int? currentBeat,
    Chord? currentChord,
  }) {
    return ChordTrainerState(
      availableChords: availableChords ?? this.availableChords,
      selectedChords: selectedChords ?? this.selectedChords,
      difficulty: clearDifficulty ? null : (difficulty ?? this.difficulty),
      bpm: bpm ?? this.bpm,
      sessionMinutes: sessionMinutes ?? this.sessionMinutes,
      beatsPerBar: beatsPerBar ?? this.beatsPerBar,
      isPlaying: isPlaying ?? this.isPlaying,
      currentBeat: currentBeat ?? this.currentBeat,
      currentChord: currentChord ?? this.currentChord,
    );
  }
}

class ChordTrainerNotifier extends StateNotifier<ChordTrainerState> {
  final ChordGenerator _generator;
  final MetronomeEngine _metronomeEngine;
  StreamSubscription? _beatSubscription;
  Timer? _sessionTimer;

  ChordTrainerNotifier(
    this._generator,
    this._metronomeEngine,
  ) : super(const ChordTrainerState(
          availableChords: ChordRepository.allChords,
        ));

  void toggleChord(Chord chord) {
    final selected = List<Chord>.from(state.selectedChords);
    if (selected.contains(chord)) {
      selected.remove(chord);
    } else {
      selected.add(chord);
    }
    state = state.copyWith(selectedChords: selected);
  }

  void setDifficulty(Difficulty? difficulty) {
    state = state.copyWith(difficulty: difficulty, clearDifficulty: difficulty == null);
  }

  void setBpm(int bpm) {
    state = state.copyWith(bpm: bpm);
  }

  void setSessionMinutes(int minutes) {
    final clamped = minutes.clamp(1, 5);
    state = state.copyWith(sessionMinutes: clamped);
  }

  void start() {
    if (state.selectedChords.isEmpty) return;

    Chord getNextRandomChord() {
      final seq = _generator.generateSequence(
        selectedChords: state.selectedChords,
        bars: 1,
        difficulty: state.difficulty,
      );
      var chord = seq.isNotEmpty ? seq.first : state.selectedChords.first;

      // Avoid repeating the exact same chord twice in a row when possible
      if (state.currentChord != null &&
          chord == state.currentChord &&
          state.selectedChords.length > 1) {
        final altSeq = _generator.generateSequence(
          selectedChords: state.selectedChords,
          bars: 1,
          difficulty: state.difficulty,
        );
        if (altSeq.isNotEmpty) {
          chord = altSeq.first;
        }
      }
      return chord;
    }

    final firstChord = getNextRandomChord();

    state = state.copyWith(
      currentBeat: 0,
      currentChord: firstChord,
      isPlaying: true,
    );

    _metronomeEngine.start(
      bpm: state.bpm,
      beatsPerBar: state.beatsPerBar,
    );

    _sessionTimer?.cancel();
    _sessionTimer = Timer(Duration(minutes: state.sessionMinutes), () {
      stop();
    });

    _beatSubscription = _metronomeEngine.beatStream.listen((beat) {
      state = state.copyWith(currentBeat: beat);

      // Change chord on the first beat of each bar
      if (beat == 0) {
        final nextChord = getNextRandomChord();
        state = state.copyWith(currentChord: nextChord);
      }
    });
  }

  void stop() {
    _metronomeEngine.stop();
    _beatSubscription?.cancel();
    _sessionTimer?.cancel();
    state = state.copyWith(
      isPlaying: false,
      currentBeat: 0,
    );
  }

  @override
  void dispose() {
    _beatSubscription?.cancel();
    _sessionTimer?.cancel();
    super.dispose();
  }
}
