import 'package:flutter/material.dart';
import '../../../core/models/strumming_pattern.dart';
import '../../../core/theme/app_theme.dart';

class PatternDisplay extends StatelessWidget {
  final StrummingPattern pattern;
  final int? highlightBeat;

  const PatternDisplay({
    super.key,
    required this.pattern,
    this.highlightBeat,
  });

  @override
  Widget build(BuildContext context) {
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
            'Pattern',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _buildStrokeWidgets(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStrokeWidgets() {
    final widgets = <Widget>[];
    final beatsPerBar = pattern.beatsPerBar;
    final strokesPerBeat = pattern.strokes.length ~/ beatsPerBar;

    for (int beat = 0; beat < beatsPerBar; beat++) {
      final startIndex = beat * strokesPerBeat;
      final endIndex = startIndex + strokesPerBeat;
      final beatStrokes = pattern.strokes.sublist(startIndex, endIndex);

      final isHighlighted = highlightBeat == beat;

      widgets.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isHighlighted 
                ? AppColors.primary.withOpacity(0.3)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHighlighted ? AppColors.primary : AppColors.divider,
              width: isHighlighted ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: beatStrokes.map((stroke) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _StrokeSymbol(stroke: stroke),
              );
            }).toList(),
          ),
        ),
      );
    }

    return widgets;
  }
}

class _StrokeSymbol extends StatelessWidget {
  final Stroke stroke;

  const _StrokeSymbol({required this.stroke});

  @override
  Widget build(BuildContext context) {
    Color color;
    String symbol;
    double fontSize;

    switch (stroke.type) {
      case StrokeType.down:
        color = AppColors.primary;
        symbol = 'D';
        fontSize = 18;
        break;
      case StrokeType.up:
        color = AppColors.primaryLight;
        symbol = 'U';
        fontSize = 18;
        break;
      case StrokeType.rest:
        color = AppColors.textTertiary;
        symbol = '-';
        fontSize = 18;
        break;
      case StrokeType.ghostDown:
        color = AppColors.textSecondary;
        symbol = '(D)';
        fontSize = 14;
        break;
      case StrokeType.ghostUp:
        color = AppColors.textSecondary;
        symbol = '(U)';
        fontSize = 14;
        break;
      case StrokeType.mute:
        color = AppColors.warning;
        symbol = 'X';
        fontSize = 18;
        break;
    }

    return Text(
      symbol,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    );
  }
}
