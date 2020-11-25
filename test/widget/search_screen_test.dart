// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_example_app/app.dart';
import 'package:flutter_example_app/di/app_module.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('flutter test search screen', (WidgetTester tester) async {
    setupDI();
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');

    // Tap the add button.
    await tester.tap(find.byType(RaisedButton));
    expect(find.text('hi'), findsOneWidget);
  });
}
