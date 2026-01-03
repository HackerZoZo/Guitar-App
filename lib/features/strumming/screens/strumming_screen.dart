import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/bpm_slider.dart';
import '../../../core/models/chord.dart';
import '../../../core/models/time_signature.dart';
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
          // Time Signature Selection
          Row(
            children: [
              const Icon(Icons.music_note, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Time Signature',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Dropdown for all time signatures
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<TimeSignature>(
                value: state.timeSignature,
                isExpanded: true,
                dropdownColor: AppColors.surface,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
                icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                items: TimeSignature.values.map((timeSig) {
                  return DropdownMenuItem(
                    value: timeSig,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            timeSig.displayName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            timeSig.feel,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (TimeSignature? newValue) {
                  if (newValue != null) {
                    notifier.setTimeSignature(newValue);
                  }
                },
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Difficulty Selection
          Text(
            'Difficulty',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SegmentedButton<Difficulty>(
            segments: const [
              ButtonSegment(value: Difficulty.beginner, label: Text('Easy')),
              ButtonSegment(value: Difficulty.intermediate, label: Text('Medium')),
              ButtonSegment(value: Difficulty.advanced, label: Text('Advanced')),
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
          
          BpmSlider(
            value: state.bpm,
            onChanged: notifier.setBpm,
          ),
          
          const SizedBox(height: 24),
          
          // Groove Lock Toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  state.grooveLocked ? Icons.lock : Icons.lock_open,
                  color: state.grooveLocked ? AppColors.primary : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lock Groove',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        state.grooveLocked 
                            ? 'Pattern variations only' 
                            : 'New patterns each time',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: state.grooveLocked,
                  onChanged: (_) => notifier.toggleGrooveLock(),
                  activeTrackColor: AppColors.primary,
                ),
              ],
            ),
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
            'Legend: D = Down, U = Up, - = Rest, ! = Accent, (D)/(U) = Ghost, X = Mute',
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
                // Time Signature Display
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    state.timeSignature.displayName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Beat Counter
                Text(
                  'Beat ${state.currentBeat + 1} of ${state.timeSignature.beats}',
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
