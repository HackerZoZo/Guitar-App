import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/exercise.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/bpm_slider.dart';
import '../../../core/providers/providers.dart';

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  ConsumerState<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {
  late int _bpm;

  @override
  void initState() {
    super.initState();
    _bpm = widget.exercise.defaultBpm;
  }

  @override
  Widget build(BuildContext context) {
    final metronomeState = ref.watch(metronomeStateProvider);
    final metronomeNotifier = ref.read(metronomeStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
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
                      const Icon(Icons.info_outline, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.exercise.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Instructions
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
                      const Icon(Icons.list_alt, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Instructions',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.exercise.instructions,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Benefits
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
                      const Icon(Icons.star, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Benefits',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...widget.exercise.benefits.map(
                    (benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 20,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              benefit,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // BPM Control
            BpmSlider(
              value: _bpm,
              onChanged: (value) {
                setState(() => _bpm = value);
                metronomeNotifier.setBpm(value);
              },
              min: widget.exercise.minBpm,
              max: widget.exercise.maxBpm,
            ),
            
            const SizedBox(height: 24),
            
            // Control Button
            PrimaryButton(
              text: metronomeState.isRunning ? 'Pause' : 'Start Practice',
              icon: metronomeState.isRunning ? Icons.pause : Icons.play_arrow,
              onPressed: () {
                if (metronomeState.isRunning) {
                  metronomeNotifier.stop();
                } else {
                  metronomeNotifier.setBpm(_bpm);
                  metronomeNotifier.start();
                }
              },
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
