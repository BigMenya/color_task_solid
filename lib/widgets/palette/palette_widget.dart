import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_color_solid/widgets/palette/palette_painter.dart';

class PaletteWidget extends StatefulWidget {
  const PaletteWidget({required this.onChanged});

  final Function(Color) onChanged;

  @override
  _PaletteWidgetState createState() => _PaletteWidgetState();
}

class _PaletteWidgetState extends State<PaletteWidget> {
  Color _currentColor = Colors.red;
  Offset _dragPosition = const Offset(100, 100);
  final double markerSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          final renderObject = context.findRenderObject();
          if (renderObject != null) {
            final box = renderObject as RenderBox;
            _dragPosition = box.globalToLocal(details.globalPosition);
            final Offset centeredPosition =
                _dragPosition - const Offset(100, 100);
            final double distance = centeredPosition.distance;
            if (distance <= 100 - markerSize / 2) {
              _currentColor = _getColorAtPosition(_dragPosition);
            } else {
              final double angle =
                  atan2(centeredPosition.dy, centeredPosition.dx);
              final double adjustedX =
                  cos(angle) * (100 - markerSize / 2) + 100;
              final double adjustedY =
                  sin(angle) * (100 - markerSize / 2) + 100;
              _dragPosition = Offset(adjustedX, adjustedY);
              _currentColor = _getColorAtPosition(_dragPosition);
            }
            widget.onChanged(_currentColor);
          }
        });
      },
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(200, 200),
              painter: PalettePainter(),
            ),
            Positioned(
              left: _dragPosition.dx - 10,
              top: _dragPosition.dy - 10,
              child: Container(
                width: markerSize,
                height: markerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorAtPosition(Offset position) {
    final double hue =
        (atan2(position.dy - 100, position.dx - 100) % (2 * pi)) * 180.0 / pi;
    final double saturation = min(max(position.distance / 100.0, 0.0), 1.0);

    return HSVColor.fromAHSV(1.0, hue, saturation, 1.0).toColor();
  }
}
