import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/bpm_slider.dart';
import '../../../core/models/chord.dart';
import '../providers/strumming_provider.dart';
import '../widgets/pattern_display.dart';

class StrummingScreen extends ConsumerWidget {
  const StrummingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(strummingProvider);
    final notifier = ref.read(strummingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Strumming Patterns'),
        backgroundColor: AppColors.background,
      ),
      body: state.isPlaying
          ? _PlayingView(state: state, notifier: notifier)
          : _SetupView(state: state, notifier: notifier),
    );
  }
}

class _SetupView extends StatelessWidget {
  final StrummingState state;
  final StrummingNotifier notifier;

  const _SetupView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Difficulty',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SegmentedButton<Difficulty>(
            segments: [
              const ButtonSegment(value: Difficulty.beginner, label: Text('Easy')),
              const ButtonSegment(value: Difficulty.intermediate, label: Text('Medium')),
              const ButtonSegment(value: Difficulty.advanced, label: Text('Advanced')),
            ],
            selected: {state.difficulty},
            onSelectionChanged: (Set<Difficulty> newSelection) {
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
          
          Text(
            'Time Signature',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 4, label: Text('4/4')),
              ButtonSegment(value: 3, label: Text('3/4')),
              ButtonSegment(value: 6, label: Text('6/8')),
            ],
            selected: {state.beatsPerBar},
            onSelectionChanged: (Set<int> newSelection) {
              notifier.setBeatsPerBar(newSelection.first);
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
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Pattern Preview',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (state.currentPattern != null)
                  PatternDisplay(pattern: state.currentPattern!),
                const SizedBox(height: 12),
                SecondaryButton(
                  text: 'Generate New Pattern',
                  icon: Icons.shuffle,
                  onPressed: notifier.generateNewPattern,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          PrimaryButton(
            text: 'Start Practice',
            icon: Icons.play_arrow,
            onPressed: notifier.start,
          ),
          
          const SizedBox(height: 12),
          
          Text(
            'Legend: D = Down, U = Up, - = Rest, (D)/(U) = Ghost, X = Mute',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PlayingView extends StatelessWidget {
  final StrummingState state;
  final StrummingNotifier notifier;

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
                Text(
                  'Beat ${state.currentBeat + 1} of ${state.beatsPerBar}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                
                if (state.currentPattern != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PatternDisplay(
                      pattern: state.currentPattern!,
                      highlightBeat: state.currentBeat,
                    ),
                  ),
                
                const SizedBox(height: 48),
                
                Text(
                  '${state.bpm} BPM',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SecondaryButton(
                text: 'New Pattern',
                icon: Icons.shuffle,
                onPressed: notifier.changePattern,
              ),
              const SizedBox(height: 12),
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
