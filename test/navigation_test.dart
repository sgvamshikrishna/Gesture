import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/main.dart';

void main() {
  testWidgets('Three-screen flow passes data and returns a saved name', (
    tester,
  ) async {
    await tester.pumpWidget(const NavigationApp());
    await tester.tap(find.text('View session summary'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rename session'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Practice session');
    await tester.tap(find.text('Save name'));
    await tester.pumpAndSettle();
    expect(find.text('Practice session'), findsOneWidget);
    // Reproduce the lost-result case: use the app-bar back button,
    // rather than the explicit return button, after renaming.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Practice session'), findsOneWidget);
  });

  testWidgets('Cancel, system back, and blank-name validation work', (
    tester,
  ) async {
    await tester.pumpWidget(const NavigationApp());
    await tester.tap(find.text('View session summary'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rename session'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '   ');
    await tester.tap(find.text('Save name'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a session name.'), findsOneWidget);
    await tester.tap(find.text('Cancel and go back'));
    await tester.pumpAndSettle();
    expect(find.text('My navigation session'), findsOneWidget);
    await tester.tap(find.text('Rename session'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Discard this');
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('My navigation session'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('1. Navigation'), findsOneWidget);
    await tester.tap(find.text('View session summary'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back to home'));
    await tester.pumpAndSettle();
    expect(find.text('1. Navigation'), findsOneWidget);
  });
}
