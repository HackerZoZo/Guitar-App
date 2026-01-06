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

/// Category display info for UI
class _CategoryInfo {
  final ChordCategory category;
  final String label;
  final IconData icon;
  final Color color;

  const _CategoryInfo(this.category, this.label, this.icon, this.color);
}

const _categoryInfoList = [
  _CategoryInfo(ChordCategory.major, 'Major', Icons.music_note, Colors.blue),
  _CategoryInfo(
      ChordCategory.minor, 'Minor', Icons.music_note_outlined, Colors.purple),
  _CategoryInfo(
      ChordCategory.barre, 'Barre', Icons.horizontal_rule, Colors.orange),
  _CategoryInfo(ChordCategory.seventh, '7th', Icons.filter_7, Colors.teal),
  _CategoryInfo(ChordCategory.suspended, 'Sus', Icons.pause, Colors.indigo),
  _CategoryInfo(ChordCategory.added, 'Add', Icons.add, Colors.green),
  _CategoryInfo(
      ChordCategory.extended, 'Ext', Icons.unfold_more, Colors.deepPurple),
  _CategoryInfo(ChordCategory.power, 'Power', Icons.bolt, Colors.red),
  _CategoryInfo(ChordCategory.slash, 'Slash', Icons.remove, Colors.brown),
  _CategoryInfo(
      ChordCategory.diminished, 'Dim', Icons.trending_down, Colors.grey),
  _CategoryInfo(
      ChordCategory.augmented, 'Aug', Icons.trending_up, Colors.amber),
];

class _SetupView extends StatelessWidget {
  final ChordTrainerState state;
  final ChordTrainerNotifier notifier;

  const _SetupView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CHORD CATEGORIES SECTION
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.category,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Chord Categories',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: notifier.selectAllCategories,
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: const Text('All',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        TextButton(
                          onPressed: notifier.clearAllCategories,
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.textSecondary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Select chord types to practice',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _categoryInfoList.map((info) {
                    final isSelected =
                        state.selectedCategories.contains(info.category);
                    return FilterChip(
                      avatar: Icon(
                        info.icon,
                        size: 18,
                        color:
                            isSelected ? const Color(0xFF0A0E12) : info.color,
                      ),
                      label: Text(info.label),
                      selected: isSelected,
                      onSelected: (_) => notifier.toggleCategory(info.category),
                      backgroundColor: AppColors.surfaceVariant,
                      selectedColor: info.color,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? const Color(0xFF0A0E12)
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      showCheckmark: false,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // DIFFICULTY SECTION
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.bar_chart,
                        color: AppColors.warning,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Difficulty Level',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Beginner: Open chords  •  Intermediate: + Barre & 7th  •  Advanced: Full library',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 16),
                SegmentedButton<Difficulty?>(
                  segments: const [
                    ButtonSegment(
                      value: null,
                      label: Text('All', style: TextStyle(fontSize: 13)),
                    ),
                    ButtonSegment(
                      value: Difficulty.beginner,
                      label: Text('Beginner', style: TextStyle(fontSize: 13)),
                    ),
                    ButtonSegment(
                      value: Difficulty.intermediate,
                      label: Text('Inter.', style: TextStyle(fontSize: 13)),
                    ),
                    ButtonSegment(
                      value: Difficulty.advanced,
                      label: Text('Adv.', style: TextStyle(fontSize: 13)),
                    ),
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
                        return const Color(0xFF0A0E12);
                      }
                      return AppColors.textPrimary;
                    }),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // SELECTED CHORDS PREVIEW
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: (state.selectedChords.isEmpty
                                    ? AppColors.error
                                    : AppColors.success)
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            state.selectedChords.isEmpty
                                ? Icons.warning_outlined
                                : Icons.check_circle_outline,
                            color: state.selectedChords.isEmpty
                                ? AppColors.error
                                : AppColors.success,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Selected Chords',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: state.selectedChords.isEmpty
                            ? AppColors.error.withValues(alpha: 0.15)
                            : AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: state.selectedChords.isEmpty
                              ? AppColors.error.withValues(alpha: 0.3)
                              : AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        '${state.selectedChords.length} chords',
                        style: TextStyle(
                          color: state.selectedChords.isEmpty
                              ? AppColors.error
                              : AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (state.selectedChords.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.error.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.error.withValues(alpha: 0.8),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Select at least one category or difficulty to add chords',
                            style: TextStyle(
                              color: AppColors.error.withValues(alpha: 0.9),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints: const BoxConstraints(maxHeight: 120),
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.selectedChords.map((chord) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              chord.name,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // BPM & SESSION SETTINGS
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
                  onChanged: (value) =>
                      notifier.setSessionMinutes(value.toInt()),
                ),
              ),
              Container(
                width: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

          // Allow Repetition Toggle
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Allow Repetition',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Same chord can appear twice in a row',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              Switch(
                value: state.allowRepetition,
                onChanged: notifier.setAllowRepetition,
                activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
                thumbColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary;
                  }
                  return null;
                }),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // START BUTTON
          Builder(
            builder: (context) {
              final VoidCallback? startCallback =
                  state.selectedChords.isEmpty ? null : () => notifier.start();

              return PrimaryButton(
                text: 'Start Training (${state.selectedChords.length} chords)',
                icon: Icons.play_arrow,
                onPressed: startCallback,
              );
            },
          ),

          const SizedBox(height: 24),
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
