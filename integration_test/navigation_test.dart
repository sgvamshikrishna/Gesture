import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigate three screens and return data on a device', (
    tester,
  ) async {
    await tester.pumpWidget(const NavigationApp());
    await tester.ensureVisible(find.text('View session summary'));
    await tester.tap(find.text('View session summary'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rename session'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Device session');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text('Device session'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Device session'), findsOneWidget);
    await tester.ensureVisible(find.text('View session summary'));
    await tester.tap(find.text('View session summary'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rename session'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel and go back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back to home'));
    await tester.pumpAndSettle();
    expect(find.text('1. Navigation'), findsOneWidget);
  });
}
