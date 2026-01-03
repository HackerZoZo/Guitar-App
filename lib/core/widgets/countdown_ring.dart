import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_theme.dart';

class CountdownRing extends StatelessWidget {
  final int currentBeat;
  final int totalBeats;
  final double size;

  const CountdownRing({
    super.key,
    required this.currentBeat,
    required this.totalBeats,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentBeat / totalBeats;
    
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: 1.0,
              color: AppColors.surfaceVariant,
              strokeWidth: 8,
            ),
          ),
          // Progress circle
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: progress,
              color: AppColors.primary,
              strokeWidth: 8,
            ),
          ),
          // Beat number
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${currentBeat + 1}',
                style: TextStyle(
                  fontSize: size * 0.3,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'of $totalBeats',
                style: TextStyle(
                  fontSize: size * 0.12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    // Start from top (-90 degrees)
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
