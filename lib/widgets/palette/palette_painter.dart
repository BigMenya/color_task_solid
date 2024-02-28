import 'dart:math';

import 'package:flutter/material.dart';

class PalettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const half = 2;
    const maxAngle = 360;
    const maxAngleHalf = 180;
    const increment = 5;

    for (double i = 0; i < maxAngle; i += increment) {
      final Paint paint = Paint()
        ..color = HSVColor.fromAHSV(1.0, i, 1.0, 1.0).toColor();
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / half, size.height / half),
          radius: size.width / half,
        ),
        (i - half) * pi / maxAngleHalf,
        increment * pi / maxAngleHalf,
        true,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
