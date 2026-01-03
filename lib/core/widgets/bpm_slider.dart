import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BpmSlider extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const BpmSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 40,
    this.max = 220,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tempo',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$value BPM',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: value > min ? () => onChanged(value - 5) : null,
              icon: const Icon(Icons.remove_circle_outline),
              color: AppColors.primary,
            ),
            Expanded(
              child: Slider(
                value: value.toDouble(),
                min: min.toDouble(),
                max: max.toDouble(),
                divisions: (max - min) ~/ 5,
                onChanged: (v) => onChanged(v.round()),
              ),
            ),
            IconButton(
              onPressed: value < max ? () => onChanged(value + 5) : null,
              icon: const Icon(Icons.add_circle_outline),
              color: AppColors.primary,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$min',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '$max',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
