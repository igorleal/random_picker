// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:RandomPicker/main.dart';

void main() {
  testWidgets('Starts with message and hide it once one item is added', (WidgetTester tester) async {
    await tester.pumpWidget(RandomPickerApp());

    expect(find.text("Use the button to add items to the list"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pump();

    expect(find.text("Use the button to add items to the list"), findsNothing);
  });

  testWidgets('Add adds new row', (WidgetTester tester) async {
    await tester.pumpWidget(RandomPickerApp());

    expect(find.byIcon(Icons.remove_circle), findsNothing);

    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pump();

    expect(find.byIcon(Icons.remove_circle), findsOneWidget);
  });

  testWidgets('Removes rows', (WidgetTester tester) async {
    await tester.pumpWidget(RandomPickerApp());

    expect(find.byElementType(TextFormField), findsNothing);

    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pump();

    expect(find.byType(TextFormField), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove_circle));
    await tester.pump();

    expect(find.byElementType(TextFormField), findsNothing);
  });
}
