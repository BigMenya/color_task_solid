import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_color_solid/widgets/palette/palette_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color boxColor = Colors.white;
  Color titleColor = Colors.black;
  bool paletteVisible = false;
  bool needOppositeColor = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            paletteVisible = !paletteVisible;
          });
        },
        child: Text(paletteVisible ? 'Tap' : 'Palette'),
      ),
      body: GestureDetector(
        onTap: () {
          if (!paletteVisible) {
            setState(() {
              final newColor = generateBackgroundColor();
              boxColor = newColor;
              updateTitleColor(newColor);
            });
          }
        },
        child: ColoredBox(
          color: boxColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello there',
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: titleColor),
                ),
                if (paletteVisible)
                  PaletteWidget(
                    onChanged: (color) {
                      setState(() {
                        boxColor = color;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Check if we need to change title color if background color is similar
  /// Normally I would apply theme to reflect background changes but for this
  /// task I think it's overkill
  Color updateTitleColor(Color backgroundColor) {
    const minDiff = 20;
    final backgroundCloseToBlack = backgroundColor.blue < minDiff &&
        backgroundColor.red < minDiff &&
        backgroundColor.green < minDiff;

    return titleColor = backgroundCloseToBlack ? Colors.white : Colors.black;
  }

  Color generateBackgroundColor() {
    final red = Random().nextInt(255);
    final green = Random().nextInt(255);
    final blue = Random().nextInt(255);

    return Color.fromRGBO(red, green, blue, 1);
  }
}
