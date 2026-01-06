import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/bpm_slider.dart';
import '../../../core/models/chord.dart' show ChordCategory, Difficulty;
import '../../../core/models/time_signature.dart';
import '../../../core/models/practice_pattern.dart';
import '../providers/practice_generator_provider.dart';
import '../widgets/practice_pattern_display.dart';

class PracticeGeneratorScreen extends ConsumerWidget {
  const PracticeGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(practiceGeneratorProvider);
    final notifier = ref.read(practiceGeneratorProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Generator'),
        backgroundColor: AppColors.background,
      ),
      body: state.isPlaying
          ? _PlayingView(state: state, notifier: notifier)
          : _SetupView(state: state, notifier: notifier),
    );
  }
}

class _SetupView extends StatelessWidget {
  final PracticeGeneratorState state;
  final PracticeGeneratorNotifier notifier;

  const _SetupView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Practice Mode Selection
          _buildSectionTitle(context, 'Practice Mode', Icons.fitness_center),
          const SizedBox(height: 12),
          _buildModeSelector(),
          
          const SizedBox(height: 24),
          
          // Time Signature
          _buildSectionTitle(context, 'Time Signature', Icons.music_note),
          const SizedBox(height: 12),
          _buildTimeSignatureDropdown(),
          
          const SizedBox(height: 24),
          
          // Pattern Length
          _buildSectionTitle(context, 'Pattern Length', Icons.view_week),
          const SizedBox(height: 12),
          _buildPatternLengthSelector(),
          
          const SizedBox(height: 24),
          
          // Difficulty
          _buildSectionTitle(context, 'Difficulty', Icons.stairs),
          const SizedBox(height: 12),
          _buildDifficultySelector(),
          
          const SizedBox(height: 24),
          
          // Chord Categories
          _buildSectionTitle(context, 'Chord Categories', Icons.piano),
          const SizedBox(height: 12),
          _buildChordCategories(),
          
          const SizedBox(height: 24),
          
          // BPM
          _buildSectionTitle(context, 'Tempo', Icons.speed),
          const SizedBox(height: 12),
          BpmSlider(
            value: state.config.bpm,
            onChanged: (bpm) => notifier.setBpm(bpm),
          ),
          
          const SizedBox(height: 32),
          
          // Preview Pattern
          if (state.currentPattern != null) ...[
            _buildSectionTitle(context, 'Preview', Icons.preview),
            const SizedBox(height: 16),
            PracticePatternDisplay(
              pattern: state.currentPattern!,
              currentBar: state.currentBar,
              isPlaying: false,
            ),
            const SizedBox(height: 24),
          ],
          
          // Control Buttons
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  text: 'Generate New',
                  icon: Icons.refresh,
                  onPressed: notifier.generateNewPattern,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  text: 'Start Practice',
                  icon: Icons.play_arrow,
                  onPressed: notifier.start,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget _buildModeSelector() {
    return SegmentedButton<PracticeMode>(
      segments: const [
        ButtonSegment(
          value: PracticeMode.jam,
          label: Text('Jam'),
          icon: Icon(Icons.music_note),
        ),
        ButtonSegment(
          value: PracticeMode.practice,
          label: Text('Practice'),
          icon: Icon(Icons.repeat),
        ),
        ButtonSegment(
          value: PracticeMode.grooveExploration,
          label: Text('Groove'),
          icon: Icon(Icons.explore),
        ),
      ],
      selected: {state.config.mode},
      onSelectionChanged: (Set<PracticeMode> newSelection) {
        notifier.setMode(newSelection.first);
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
    );
  }

  Widget _buildTimeSignatureDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TimeSignature>(
          value: state.config.timeSignature,
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
    );
  }

  Widget _buildPatternLengthSelector() {
    return SegmentedButton<int>(
      segments: const [
        ButtonSegment(value: 1, label: Text('1 Bar')),
        ButtonSegment(value: 2, label: Text('2 Bars')),
        ButtonSegment(value: 4, label: Text('4 Bars')),
      ],
      selected: {state.config.numBars},
      onSelectionChanged: (Set<int> newSelection) {
        notifier.setNumBars(newSelection.first);
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
    );
  }

  Widget _buildDifficultySelector() {
    return SegmentedButton<Difficulty>(
      segments: const [
        ButtonSegment(value: Difficulty.beginner, label: Text('Beginner')),
        ButtonSegment(value: Difficulty.intermediate, label: Text('Intermediate')),
        ButtonSegment(value: Difficulty.advanced, label: Text('Advanced')),
      ],
      selected: {state.config.difficulty},
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
    );
  }

  Widget _buildChordCategories() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildChordCategoryChip(ChordCategory.major, 'Major'),
        _buildChordCategoryChip(ChordCategory.minor, 'Minor'),
        _buildChordCategoryChip(ChordCategory.barre, 'Barre'),
      ],
    );
  }

  Widget _buildChordCategoryChip(ChordCategory category, String label) {
    final isSelected = state.config.chordCategories.contains(category);
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => notifier.toggleChordCategory(category),
      backgroundColor: AppColors.surfaceVariant,
      selectedColor: AppColors.primary,
      checkmarkColor: Colors.black,
      labelStyle: TextStyle(
        color: isSelected ? Colors.black : AppColors.textPrimary,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class _PlayingView extends StatelessWidget {
  final PracticeGeneratorState state;
  final PracticeGeneratorNotifier notifier;

  const _PlayingView({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    if (state.currentPattern == null) {
      return const Center(child: Text('No pattern loaded'));
    }

    return Column(
      children: [
        // Mode indicator
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: AppColors.primary.withValues(alpha: 0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_getModeIcon(), color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                _getModeText(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        // Pattern Display
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: PracticePatternDisplay(
                pattern: state.currentPattern!,
                currentBar: state.currentBar,
                isPlaying: true,
              ),
            ),
          ),
        ),
        
        // Control buttons
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: 'New Pattern',
                      icon: Icons.refresh,
                      onPressed: notifier.generateNewPattern,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Stop',
                      icon: Icons.stop,
                      onPressed: notifier.stop,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'BPM: ${state.config.bpm}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getModeIcon() {
    switch (state.config.mode) {
      case PracticeMode.jam:
        return Icons.music_note;
      case PracticeMode.practice:
        return Icons.repeat;
      case PracticeMode.grooveExploration:
        return Icons.explore;
    }
  }

  String _getModeText() {
    switch (state.config.mode) {
      case PracticeMode.jam:
        return 'JAM MODE - New chords & pattern each time';
      case PracticeMode.practice:
        return 'PRACTICE MODE - Same chords, new patterns';
      case PracticeMode.grooveExploration:
        return 'GROOVE MODE - Same pattern, new chords';
    }
  }
}
