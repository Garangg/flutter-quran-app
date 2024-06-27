import 'dart:math' as math;
import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  StarPainter({required this.color, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the stroke
    final strokePaint = Paint()
      ..color = color // This is the stroke color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Paint for the fill
    final fillPaint = Paint()
      ..color =
          const Color.fromARGB(255, 61, 143, 209) // Set your desired fill color here
      ..style = PaintingStyle.fill; // Change this to PaintingStyle.fill

    const numberOfPoints = 8;
    final radius = size.width / 2;
    const double radianPerPoint = (math.pi * 2) / numberOfPoints;
    final path = Path();

    for (int i = 0; i < numberOfPoints * 2; i++) {
      final double angle = radianPerPoint * i - (math.pi / 2);
      final pointX = radius + radius * math.cos(angle);
      final pointY = radius + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(pointX, pointY);
      } else {
        path.lineTo(pointX, pointY);
      }
    }
    path.close();

    // Draw the path with the fill paint first
    canvas.drawPath(path, fillPaint);
    // Then draw the path with the stroke paint
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
