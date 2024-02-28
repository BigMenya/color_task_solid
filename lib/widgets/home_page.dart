import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color boxColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            boxColor = generateBackgroundColor();
          });
        },
        child: ColoredBox(
          color: boxColor,
          child: Center(
            child: Text(
              'Hello there',
              style: theme.textTheme.headlineMedium?.copyWith(),
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
