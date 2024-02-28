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
  bool paletteVisible = false;

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
              boxColor = generateBackgroundColor();
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
                  style: theme.textTheme.headlineMedium?.copyWith(),
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

  Color generateBackgroundColor() {
    final red = Random().nextInt(255);
    final green = Random().nextInt(255);
    final blue = Random().nextInt(255);

    return Color.fromRGBO(red, green, blue, 1);
  }
}
