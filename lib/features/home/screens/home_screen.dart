import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../exercises/screens/exercises_screen.dart';
import '../../chords/screens/chords_screen.dart';
import '../../chord_trainer/screens/chord_trainer_screen.dart';
import '../../strumming/screens/strumming_screen.dart';
import '../../practice_generator/screens/practice_generator_screen.dart';
import '../../groove_mode/screens/groove_mode_screen.dart';
import '../../metronome/screens/metronome_screen.dart';
import '../../settings/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.background,
              Color(0xFF0D1117),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.gradient1, AppColors.gradient2],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.music_note,
                        color: Color(0xFF0A0E12),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Guitar Practice',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your daily path to mastery',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      IconButtonCard(
                        icon: Icons.piano,
                        label: 'Finger\nExercises',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ExercisesScreen()),
                        ),
                      ),
                      IconButtonCard(
                        icon: Icons.music_note,
                        label: 'Chords\nPractice',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ChordsScreen()),
                        ),
                      ),
                      IconButtonCard(
                        icon: Icons.shuffle,
                        label: 'Random\nChord Trainer',
                        color: const Color(0xFF8B5CF6),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ChordTrainerScreen()),
                        ),
                      ),
                      IconButtonCard(
                        icon: Icons.gesture,
                        label: 'Strumming\nPatterns',
                        color: const Color(0xFFF59E0B),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const StrummingScreen()),
                        ),
                      ),
                      IconButtonCard(
                        icon: Icons.auto_awesome,
                        label: 'Practice\nGenerator',
                        color: AppColors.success,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PracticeGeneratorScreen()),
                        ),
                      ),
                      IconButtonCard(
                        icon: Icons.waves,
                        label: 'Groove\nMode',
                        color: const Color(0xFFEC4899),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const GrooveModeScreen()),
                        ),
                      ),
                      IconButtonCard(
                        icon: Icons.speed,
                        label: 'Metronome',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MetronomeScreen()),
                        ),
                      ),
                      IconButtonCard(
                        icon: Icons.settings,
                        label: 'Settings',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SettingsScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
