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
          Row(
            children: [
              Text(
                'Pattern',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  pattern.timeSignature.displayName,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _buildBeatWidgets(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBeatWidgets() {
    final widgets = <Widget>[];
    final timeSignature = pattern.timeSignature;

    for (int beat = 0; beat < timeSignature.beats; beat++) {
      final beatStrokes = pattern.getStrokesForBeat(beat);
      final isHighlighted = highlightBeat == beat;
      final isStrongBeat = timeSignature.isStrongBeat(beat);

      widgets.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isHighlighted 
                ? AppColors.primary.withValues(alpha: 0.4)
                : isStrongBeat
                    ? AppColors.surface.withValues(alpha: 0.8)
                    : AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHighlighted 
                  ? AppColors.primary 
                  : isStrongBeat
                      ? AppColors.primary.withValues(alpha: 0.3)
                      : AppColors.divider,
              width: isHighlighted ? 2 : 1,
            ),
            boxShadow: isHighlighted
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              // Beat number
              Text(
                '${beat + 1}',
                style: TextStyle(
                  fontSize: 10,
                  color: isStrongBeat 
                      ? AppColors.primary 
                      : AppColors.textTertiary,
                  fontWeight: isStrongBeat ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              // Strokes
              Row(
                mainAxisSize: MainAxisSize.min,
                children: beatStrokes.map((stroke) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: _StrokeSymbol(
                      stroke: stroke,
                      isHighlighted: isHighlighted,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }
}

class _StrokeSymbol extends StatelessWidget {
  final Stroke stroke;
  final bool isHighlighted;

  const _StrokeSymbol({
    required this.stroke,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String symbol;
    double fontSize;

    switch (stroke.type) {
      case StrokeType.down:
        color = stroke.isAccented 
            ? AppColors.primary
            : isHighlighted
                ? AppColors.primary.withValues(alpha: 0.9)
                : AppColors.primary.withValues(alpha: 0.7);
        symbol = stroke.isAccented ? 'D!' : 'D';
        fontSize = stroke.isAccented ? 20 : 18;
        break;
      case StrokeType.up:
        color = stroke.isAccented
            ? AppColors.primaryLight
            : isHighlighted
                ? AppColors.primaryLight.withValues(alpha: 0.9)
                : AppColors.primaryLight.withValues(alpha: 0.7);
        symbol = stroke.isAccented ? 'U!' : 'U';
        fontSize = stroke.isAccented ? 20 : 18;
        break;
      case StrokeType.rest:
        color = AppColors.textTertiary;
        symbol = '-';
        fontSize = 16;
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
        fontWeight: stroke.isAccented || isHighlighted 
            ? FontWeight.bold 
            : FontWeight.w600,
        fontFamily: 'monospace',
      ),
    );
  }
}
