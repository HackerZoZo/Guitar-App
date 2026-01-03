import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../exercises/screens/exercises_screen.dart';
import '../../chords/screens/chords_screen.dart';
import '../../chord_trainer/screens/chord_trainer_screen.dart';
import '../../strumming/screens/strumming_screen.dart';
import '../../metronome/screens/metronome_screen.dart';
import '../../settings/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Guitar Practice',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Daily training for guitar mastery',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    IconButtonCard(
                      icon: Icons.piano,
                      label: 'Finger\nExercises',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ExercisesScreen()),
                      ),
                    ),
                    IconButtonCard(
                      icon: Icons.music_note,
                      label: 'Chords\nPractice',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ChordsScreen()),
                      ),
                    ),
                    IconButtonCard(
                      icon: Icons.shuffle,
                      label: 'Random\nChord Trainer',
                      color: AppColors.primaryLight,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ChordTrainerScreen()),
                      ),
                    ),
                    IconButtonCard(
                      icon: Icons.gesture,
                      label: 'Strumming\nPatterns',
                      color: AppColors.primaryLight,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StrummingScreen()),
                      ),
                    ),
                    IconButtonCard(
                      icon: Icons.speed,
                      label: 'Metronome',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MetronomeScreen()),
                      ),
                    ),
                    IconButtonCard(
                      icon: Icons.settings,
                      label: 'Settings',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
