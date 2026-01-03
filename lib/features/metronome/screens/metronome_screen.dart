import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/bpm_slider.dart';
import '../../../core/providers/providers.dart';

class MetronomeScreen extends ConsumerWidget {
  const MetronomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(metronomeStateProvider);
    final notifier = ref.read(metronomeStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metronome'),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            
            // BPM Display
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                boxShadow: state.isRunning
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ]
                    : null,
              ),
              child: Column(
                children: [
                  Text(
                    '${state.bpm}',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 64,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'BPM',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Beat Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(state.beatsPerBar, (index) {
                final isActive = state.isRunning && state.currentBeat == index;
                final isAccent = index == 0;
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? (isAccent ? AppColors.warning : AppColors.primary)
                          : AppColors.surfaceVariant,
                      border: isAccent
                          ? Border.all(color: AppColors.warning, width: 2)
                          : null,
                    ),
                  ),
                );
              }),
            ),
            
            const Spacer(),
            
            // BPM Slider
            BpmSlider(
              value: state.bpm,
              onChanged: notifier.setBpm,
            ),
            
            const SizedBox(height: 24),
            
            // Quick Tempo Presets
            Text(
              'Quick Presets',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _TempoChip(
                  label: 'Slow (60)',
                  bpm: 60,
                  onTap: () => notifier.setBpm(60),
                ),
                _TempoChip(
                  label: 'Medium (80)',
                  bpm: 80,
                  onTap: () => notifier.setBpm(80),
                ),
                _TempoChip(
                  label: 'Fast (120)',
                  bpm: 120,
                  onTap: () => notifier.setBpm(120),
                ),
                _TempoChip(
                  label: 'Rock (140)',
                  bpm: 140,
                  onTap: () => notifier.setBpm(140),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Time Signature
            Text(
              'Time Signature',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 3, label: Text('3/4')),
                ButtonSegment(value: 4, label: Text('4/4')),
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
            
            const SizedBox(height: 32),
            
            // Play/Stop Button
            PrimaryButton(
              text: state.isRunning ? 'Stop' : 'Start',
              icon: state.isRunning ? Icons.stop : Icons.play_arrow,
              onPressed: notifier.toggle,
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _TempoChip extends StatelessWidget {
  final String label;
  final int bpm;
  final VoidCallback onTap;

  const _TempoChip({
    required this.label,
    required this.bpm,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: AppColors.surfaceVariant,
      labelStyle: const TextStyle(color: AppColors.textPrimary),
    );
  }
}
