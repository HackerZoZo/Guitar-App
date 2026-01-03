import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/chord.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/chord_diagram.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/providers/providers.dart';

class ChordsScreen extends ConsumerStatefulWidget {
  const ChordsScreen({super.key});

  @override
  ConsumerState<ChordsScreen> createState() => _ChordsScreenState();
}

class _ChordsScreenState extends ConsumerState<ChordsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chordRepo = ref.read(chordRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chords'),
        backgroundColor: AppColors.background,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: 'Major'),
            Tab(text: 'Minor'),
            Tab(text: 'Barre'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ChordList(chords: chordRepo.getMajorChords()),
          _ChordList(chords: chordRepo.getMinorChords()),
          _ChordList(chords: chordRepo.getBarreChords()),
        ],
      ),
    );
  }
}

class _ChordList extends StatelessWidget {
  final List<Chord> chords;

  const _ChordList({required this.chords});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: chords.length,
      itemBuilder: (context, index) {
        final chord = chords[index];
        return _ChordCard(chord: chord);
      },
    );
  }
}

class _ChordCard extends StatelessWidget {
  final Chord chord;

  const _ChordCard({required this.chord});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _showChordDetail(context, chord),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              chord.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 28,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ChordDiagram(
                chord: chord,
                size: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _DifficultyBadge(difficulty: chord.difficulty),
            ),
          ],
        ),
      ),
    );
  }

  void _showChordDetail(BuildContext context, Chord chord) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _ChordDetailSheet(chord: chord),
    );
  }
}

class _ChordDetailSheet extends ConsumerWidget {
  final Chord chord;

  const _ChordDetailSheet({required this.chord});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metronomeState = ref.watch(metronomeStateProvider);
    final metronomeNotifier = ref.read(metronomeStateProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            chord.name,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          _DifficultyBadge(difficulty: chord.difficulty),
          const SizedBox(height: 24),
          ChordDiagram(chord: chord, size: 240),
          const SizedBox(height: 24),
          _FingerPositions(chord: chord),
          const SizedBox(height: 24),
          PrimaryButton(
            text: metronomeState.isRunning ? 'Stop Practice' : 'Practice with Metronome',
            icon: metronomeState.isRunning ? Icons.stop : Icons.play_arrow,
            onPressed: metronomeNotifier.toggle,
          ),
          const SizedBox(height: 16),
          SecondaryButton(
            text: 'Close',
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class _FingerPositions extends StatelessWidget {
  final Chord chord;

  const _FingerPositions({required this.chord});

  @override
  Widget build(BuildContext context) {
    final stringNames = ['E', 'A', 'D', 'G', 'B', 'e'];
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Finger Positions',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ...List.generate(6, (i) {
            final fret = chord.frets[i];
            final finger = chord.fingers[i];
            final stringName = stringNames[i];
            
            String position;
            if (fret == -1) {
              position = 'Muted';
            } else if (fret == 0) {
              position = 'Open';
            } else {
              position = 'Fret $fret (Finger $finger)';
            }
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      '$stringName:',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    position,
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  final Difficulty difficulty;

  const _DifficultyBadge({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    
    switch (difficulty) {
      case Difficulty.beginner:
        color = AppColors.success;
        label = 'Beginner';
        break;
      case Difficulty.intermediate:
        color = AppColors.warning;
        label = 'Intermediate';
        break;
      case Difficulty.advanced:
        color = AppColors.error;
        label = 'Advanced';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
