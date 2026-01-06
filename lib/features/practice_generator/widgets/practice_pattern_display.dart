import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/practice_pattern.dart';

class PracticePatternDisplay extends StatelessWidget {
  final PracticePattern pattern;
  final int currentBar;
  final bool isPlaying;

  const PracticePatternDisplay({
    super.key,
    required this.pattern,
    required this.currentBar,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display each bar
          for (var barIndex = 0; barIndex < pattern.numBars; barIndex++) ...[
            if (barIndex > 0) const SizedBox(height: 24),
            _buildBar(context, barIndex),
          ],
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, int barIndex) {
    final chord = pattern.chords[barIndex];
    final strokes = pattern.getStrokesForBar(barIndex);
    final isCurrentBar = isPlaying && currentBar % pattern.numBars == barIndex;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentBar 
            ? AppColors.primary.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentBar 
              ? AppColors.primary
              : AppColors.surfaceVariant,
          width: isCurrentBar ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chord name
          Text(
            chord,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isCurrentBar ? AppColors.primary : AppColors.textPrimary,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 12),
          
          // Strumming pattern
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: strokes.map((stroke) {
              return Text(
                stroke.symbol,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isCurrentBar 
                      ? AppColors.primary 
                      : AppColors.textSecondary,
                  fontFamily: 'monospace',
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Minimal clean output display for copy/paste
class MinimalPatternDisplay extends StatelessWidget {
  final PracticePattern pattern;

  const MinimalPatternDisplay({
    super.key,
    required this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    // Build chord line
    final strokesPerBar = pattern.strokesPerBar;
    final chordSpacing = strokesPerBar * 2 + 4; // Approximate spacing
    
    final chordLine = pattern.chords.map((chord) {
      return chord.padRight(chordSpacing);
    }).join('');
    
    // Build pattern line
    final patternLine = pattern.strokes.map((s) => s.symbol).join(' ');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SelectableText(
        '$chordLine\n$patternLine',
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 18,
          color: Colors.greenAccent,
          height: 1.8,
        ),
      ),
    );
  }
}
