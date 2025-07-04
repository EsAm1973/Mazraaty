import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mazraaty/Features/history/data/models/history_model.dart';

// Custom painter for pie chart
class PieChartPainter extends CustomPainter {
  final List<HistoryDisease> diseases;
  final int totalRepetitions;
  final double animation;
  final List<Color> colors;
  final int touchedIndex;

  PieChartPainter({
    required this.diseases,
    required this.totalRepetitions,
    required this.animation,
    required this.colors,
    required this.touchedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.8;

    // Draw pie sections
    double startAngle = -90 * math.pi / 180; // Start from top (270 degrees)

    for (int i = 0; i < diseases.length; i++) {
      final disease = diseases[i];
      final percentage = disease.repetitions / totalRepetitions;
      final sweepAngle = percentage * 2 * math.pi * animation;

      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = colors[i % colors.length];

      // If this section is touched, make it slightly larger
      final sectionRadius = touchedIndex == i ? radius * 1.1 : radius;

      // Draw main arc
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: sectionRadius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw arc border with slightly lighter color
      final borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.white.withOpacity(0.3)
        ..strokeWidth = 1.5;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: sectionRadius),
        startAngle,
        sweepAngle,
        false,
        borderPaint,
      );

      startAngle += sweepAngle;
    }

    // Draw center circle (hole)
    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    // Draw shadow for the center hole
    final shadowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black.withOpacity(0.1);

    canvas.drawCircle(center, radius * 0.51, shadowPaint);
    canvas.drawCircle(center, radius * 0.5, centerPaint);
    
    // Draw subtle ring around the center hole
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;
      
    canvas.drawCircle(center, radius * 0.5, ringPaint);
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) {
    return oldDelegate.animation != animation ||
           oldDelegate.touchedIndex != touchedIndex;
  }
}
