import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:random_color_solid/widgets/app_widget.dart';

void main() {
  testWidgets('ColoredBox changes color on tap', (WidgetTester tester) async {
    const initialColor = Colors.white;
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AppWidget());

    // Getting box to test
    final coloredBox =
        tester.firstWidget(find.byType(ColoredBox)) as ColoredBox;

    // Verify that our color starts with white.
    expect(coloredBox.color == initialColor, true);

    // Tap on screen
    await tester.tapAt(const Offset(50, 50));
    await tester.pump();

    // Getting the updated box
    final updatedBox =
        tester.firstWidget(find.byType(ColoredBox)) as ColoredBox;

    // Verify that our color has changed.
    expect(updatedBox.color != initialColor, true);
  });
}
