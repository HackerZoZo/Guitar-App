import 'package:flutter/material.dart';
import '../../core/models/chord.dart';
import '../../core/theme/app_theme.dart';

class ChordDiagram extends StatelessWidget {
  final Chord chord;
  final double size;

  const ChordDiagram({
    super.key,
    required this.chord,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 1.2,
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: _ChordDiagramPainter(chord),
        child: Container(),
      ),
    );
  }
}

class _ChordDiagramPainter extends CustomPainter {
  final Chord chord;
  static const int numFrets = 5;
  static const int numStrings = 6;

  _ChordDiagramPainter(this.chord);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final stringSpacing = size.width / (numStrings - 1);
    final fretSpacing = size.height / (numFrets + 1);
    final startY = fretSpacing * 0.8;

    // Draw strings (vertical lines)
    for (int i = 0; i < numStrings; i++) {
      final x = i * stringSpacing;
      canvas.drawLine(
        Offset(x, startY),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw frets (horizontal lines)
    for (int i = 0; i <= numFrets; i++) {
      final y = startY + (i * fretSpacing);
      paint.strokeWidth = i == 0 && chord.baseFret == 1 ? 4 : 2;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Draw fret number if not starting at fret 1
    if (chord.baseFret > 1) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${chord.baseFret}fr',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(size.width + 8, startY - 6));
    }

    // Draw finger positions and indicators
    for (int stringIndex = 0; stringIndex < chord.frets.length; stringIndex++) {
      final fret = chord.frets[stringIndex];
      final finger = chord.fingers[stringIndex];
      final x = stringIndex * stringSpacing;

      if (fret == -1) {
        // Muted string - draw X
        _drawX(canvas, x, startY - 20, 12);
      } else if (fret == 0) {
        // Open string - draw O
        _drawO(canvas, x, startY - 20, 8);
      } else {
        // Fretted note - draw circle with finger number
        final displayFret = fret - chord.baseFret + 1;
        final y = startY + (displayFret * fretSpacing) - (fretSpacing / 2);
        
        _drawFinger(canvas, x, y, finger);
      }
    }

    // Draw barre if applicable
    if (chord.isBarre) {
      _drawBarre(canvas, size, stringSpacing, fretSpacing, startY);
    }
  }

  void _drawX(Canvas canvas, double x, double y, double size) {
    final paint = Paint()
      ..color = AppColors.error
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(x - size / 2, y - size / 2),
      Offset(x + size / 2, y + size / 2),
      paint,
    );
    canvas.drawLine(
      Offset(x + size / 2, y - size / 2),
      Offset(x - size / 2, y + size / 2),
      paint,
    );
  }

  void _drawO(Canvas canvas, double x, double y, double radius) {
    final paint = Paint()
      ..color = AppColors.success
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  void _drawFinger(Canvas canvas, double x, double y, int finger) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x, y), 12, paint);

    if (finger > 0) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: finger.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  void _drawBarre(Canvas canvas, Size size, double stringSpacing, double fretSpacing, double startY) {
    // Find barre finger positions (usually finger 1)
    final barrePositions = <int>[];
    for (int i = 0; i < chord.fingers.length; i++) {
      if (chord.fingers[i] == 1 && chord.frets[i] > 0) {
        barrePositions.add(i);
      }
    }

    if (barrePositions.length >= 2) {
      final firstString = barrePositions.first;
      final lastString = barrePositions.last;
      final fret = chord.frets[firstString] - chord.baseFret + 1;
      final y = startY + (fret * fretSpacing) - (fretSpacing / 2);

      final paint = Paint()
        ..color = AppColors.primary
        ..strokeWidth = 20
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
        Offset(firstString * stringSpacing, y),
        Offset(lastString * stringSpacing, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ChordDiagramPainter oldDelegate) {
    return oldDelegate.chord != chord;
  }
}
