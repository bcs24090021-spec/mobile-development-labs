// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab1/main.dart';

void main() {
  testWidgets('Student profile smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudentInfoApp());

    // Verify student name and ID are displayed.
    expect(find.text('ANGELA NGUI XUE LING'), findsOneWidget);
    expect(find.text('Student ID: BCS24090021'), findsOneWidget);
  });
}
