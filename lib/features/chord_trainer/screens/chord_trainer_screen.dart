import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/chord.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/bpm_slider.dart';
import '../../../core/widgets/chord_diagram.dart';
import '../../../core/widgets/countdown_ring.dart';
import '../providers/chord_trainer_provider.dart';

class ChordTrainerScreen extends ConsumerWidget {
  const ChordTrainerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chordTrainerProvider);
    final notifier = ref.read(chordTrainerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Chord Trainer'),
        backgroundColor: AppColors.background,
      ),
      body: state.isPlaying
          ? _PlayingView(state: state, notifier: notifier)
          : _SetupView(state: state, notifier: notifier),
    );
  }
}

class _SetupView extends StatelessWidget {
  final ChordTrainerState state;
  final ChordTrainerNotifier notifier;

  const _SetupView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Chords',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: state.availableChords.map((chord) {
              final isSelected = state.selectedChords.contains(chord);
              return FilterChip(
                label: Text(chord.name),
                selected: isSelected,
                onSelected: (_) => notifier.toggleChord(chord),
                backgroundColor: AppColors.surfaceVariant,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.black : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Difficulty',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SegmentedButton<Difficulty?>(
            segments: const [
              ButtonSegment(value: null, label: Text('All')),
              ButtonSegment(value: Difficulty.beginner, label: Text('Beginner')),
              ButtonSegment(value: Difficulty.intermediate, label: Text('Intermediate')),
            ],
            selected: {state.difficulty},
            onSelectionChanged: (Set<Difficulty?> newSelection) {
              notifier.setDifficulty(newSelection.first);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primary;
                }
                return AppColors.surfaceVariant;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.black;
                }
                return AppColors.textPrimary;
              }),
            ),
          ),
          
          const SizedBox(height: 24),
          
          BpmSlider(
            value: state.bpm,
            onChanged: notifier.setBpm,
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Session Duration',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: state.sessionMinutes.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: '${state.sessionMinutes} min',
                  onChanged: (value) => notifier.setSessionMinutes(value.toInt()),
                ),
              ),
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${state.sessionMinutes}m',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          Builder(
            builder: (context) {
              final VoidCallback? startCallback = state.selectedChords.isEmpty
                  ? null
                  : () => notifier.start();

              return PrimaryButton(
                text: 'Start Training',
                icon: Icons.play_arrow,
                onPressed: startCallback,
              );
            },
          ),
          
          if (state.selectedChords.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Please select at least one chord',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

class _PlayingView extends StatelessWidget {
  final ChordTrainerState state;
  final ChordTrainerNotifier notifier;

  const _PlayingView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.currentChord != null)
                  Text(
                    state.currentChord!.name,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 72,
                      color: AppColors.primary,
                    ),
                  ),
                
                const SizedBox(height: 32),
                
                if (state.currentChord != null)
                  ChordDiagram(
                    chord: state.currentChord!,
                    size: 240,
                  ),
                
                const SizedBox(height: 32),
                
                CountdownRing(
                  currentBeat: state.currentBeat,
                  totalBeats: state.beatsPerBar,
                  size: 100,
                ),
              ],
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              PrimaryButton(
                text: 'Stop',
                icon: Icons.stop,
                onPressed: notifier.stop,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
