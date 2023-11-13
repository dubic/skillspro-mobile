import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:skillspro/common/splash/splash_controller.dart';
import 'package:skillspro/main.dart';

import 'get_started_test.dart';
import 'intro_test.dart';
import 'test_context.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('signup tests', () {
    testWidgets('signup route', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const MyApp());
      IntegrationTestContext.resetIntro(seen: false);

      // Trigger a frame.
      await tester.pumpAndSettle();
//intro
      await testIntro(tester);
      await testGetStarted(tester, TestRoute.SIGNUP);
    });
  });

  group('login tests', () {
    testWidgets('login route', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const MyApp());
      IntegrationTestContext.resetIntro(seen: false);

      // Trigger a frame.
      await tester.pumpAndSettle();
      await testIntro(tester);
      await testGetStarted(tester, TestRoute.LOGIN);
    });
  });
}
