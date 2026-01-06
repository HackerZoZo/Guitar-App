import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/chord.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/bpm_slider.dart';
import '../../../core/widgets/countdown_ring.dart';
import '../providers/groove_mode_provider.dart';

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

class GrooveModeScreen extends ConsumerWidget {
  const GrooveModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(grooveModeProvider);
    final notifier = ref.read(grooveModeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Groove Mode'),
        backgroundColor: AppColors.background,
      ),
      body: state.isPlaying
          ? _PlayingView(state: state, notifier: notifier)
          : _SetupView(state: state, notifier: notifier),
    );
  }
}

class _SetupView extends StatelessWidget {
  final GrooveModeState state;
  final GrooveModeNotifier notifier;

  const _SetupView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CHORD CATEGORIES SECTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chord Categories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: notifier.selectAllCategories,
                    child: const Text('All'),
                  ),
                  TextButton(
                    onPressed: notifier.clearAllCategories,
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Select chord types to practice',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 12),
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
                  color: isSelected ? Colors.black : info.color,
                ),
                label: Text(info.label),
                selected: isSelected,
                onSelected: (_) => notifier.toggleCategory(info.category),
                backgroundColor: AppColors.surfaceVariant,
                selectedColor: info.color.withValues(alpha: 0.8),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.black : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),

          // DIFFICULTY SECTION
          Text(
            'Difficulty Level',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Beginner: Open chords  •  Intermediate: + Barre & 7th  •  Advanced: Full library',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<Difficulty?>(
            segments: const [
              ButtonSegment(value: null, label: Text('All')),
              ButtonSegment(
                  value: Difficulty.beginner, label: Text('Beginner')),
              ButtonSegment(
                  value: Difficulty.intermediate, label: Text('Intermediate')),
              ButtonSegment(
                  value: Difficulty.advanced, label: Text('Advanced')),
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
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),

          // SEQUENCE LENGTH SECTION
          Text(
            'Chord Sequence Length',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: state.sequenceLength.toDouble(),
                  min: 2,
                  max: 8,
                  divisions: 6,
                  label: '${state.sequenceLength} chords',
                  onChanged: (value) =>
                      notifier.setSequenceLength(value.toInt()),
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
                  '${state.sequenceLength}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),

          // BPM SECTION
          BpmSlider(
            value: state.bpm,
            onChanged: notifier.setBpm,
          ),
          const SizedBox(height: 32),

          // START BUTTON
          Builder(
            builder: (context) {
              final VoidCallback? startCallback =
                  state.filteredChords.isEmpty ? null : () => notifier.start();

              return PrimaryButton(
                text: 'Start Groove',
                icon: Icons.play_arrow,
                onPressed: startCallback,
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _PlayingView extends StatelessWidget {
  final GrooveModeState state;
  final GrooveModeNotifier notifier;

  const _PlayingView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final groove = state.currentGroove;
    if (groove == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GROOVE DISPLAY - FORMATTED OUTPUT
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Chord Row
                      Text(
                        groove.chords.map((c) => c.name).join('       '),
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  letterSpacing: 2,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Strumming Pattern Row
                      Text(
                        List.filled(
                          groove.chords.length,
                          groove.strummingPattern,
                        ).join('  '),
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[600],
                                  letterSpacing: 2,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // PLAY COUNT & REFRESH INFO
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'Play ${groove.playCount + 1}/4 • Next groove generates after 4 plays',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                // BEAT COUNTDOWN
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
          child: PrimaryButton(
            text: 'Stop',
            icon: Icons.stop,
            onPressed: notifier.stop,
          ),
        ),
      ],
    );
  }
}
