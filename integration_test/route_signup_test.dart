import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:skillspro/main.dart';

import 'get_started_test.dart';
import 'test_context.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const MyApp());
      IntegrationTestContext.resetIntro();

      // Trigger a frame.
      await tester.pumpAndSettle();

      expect(find.text('DONE'), findsNothing);
      expect(find.text('NEXT'), findsOneWidget);
      final next = find.byKey(const Key('next'));
      await tester.tap(next);
      await tester.pumpAndSettle();
      expect(find.text('DONE'), findsOneWidget);

      final done = find.byKey(const Key('done'));
      await tester.tap(done);
      await tester.pumpAndSettle();
      await testGetStarted(tester, TestRoute.SIGNUP);
    });
  });
}
