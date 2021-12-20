// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_op_gg/main.dart';
import 'package:my_op_gg/views/profile.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Recent Search'), findsOneWidget);
    expect(find.text('euw1'), findsOneWidget);
    expect(find.text("Champion's Rotation"), findsOneWidget);
    expect(find.text("Solo LeaderBoard"), findsOneWidget);
    expect(find.text("Flex LeaderBoard"), findsOneWidget);
    expect(find.text("Tft LeaderBoard"), findsOneWidget);
  });
}
