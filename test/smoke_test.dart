// Copyright 2025, Stormlight Labs
import 'package:flutter_test/flutter_test.dart';
import 'package:soulbloom/main.dart';

void main() {
  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Play'), findsOneWidget);

    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Music'), findsOneWidget);

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Play'), findsOneWidget);
  });
}
