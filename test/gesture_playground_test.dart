import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/main.dart';

void main() {
  testWidgets('Tap and long press update the screen; reset restores it', (
    tester,
  ) async {
    await tester.pumpWidget(const GestureApp());
    await tester.tap(find.text('Tap me'));
    await tester.pump();
    expect(find.text('Taps: 1'), findsOneWidget);
    expect(find.text('You tapped the button!'), findsOneWidget);

    await tester.longPress(find.text('Long press me'));
    await tester.pump();
    expect(find.text('Long press! Color changed to green.'), findsOneWidget);
    final box = find.ancestor(
      of: find.text('Long press me'),
      matching: find.byType(Container),
    );
    expect(
      (tester.widget<Container>(box).decoration as BoxDecoration).color,
      Colors.green,
    );
    expect(find.text('Taps: 1'), findsOneWidget);

    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(find.text('Taps: 0'), findsOneWidget);
    expect(
      (tester.widget<Container>(box).decoration as BoxDecoration).color,
      Colors.blue,
    );
  });
}
