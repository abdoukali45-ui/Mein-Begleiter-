import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mein_begleiter/main.dart';

void main() {
  testWidgets('Home page shows welcome text and start button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeinBegleiterApp());

    expect(find.text('Guten Morgen! 👋'), findsOneWidget);
    expect(find.text('Gespräch beginnen'), findsOneWidget);
  });

  testWidgets('Tapping start button navigates to conversation page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MeinBegleiterApp());

    await tester.tap(find.text('Gespräch beginnen'));
    await tester.pumpAndSettle();

    expect(find.text('Anna'), findsOneWidget);
    expect(find.byIcon(Icons.mic), findsOneWidget);
  });
}
