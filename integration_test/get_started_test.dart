import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login_test.dart';
import 'signup_test.dart';
import 'test_context.dart';

testGetStarted(WidgetTester tester, TestRoute route) async {
  final login = find.byKey(const Key('login'));
  final signup = find.byKey(const Key('signup'));
  // expect(find.text('Login'), findsOneWidget);
  // expect(find.text('Sign Up'), findsOneWidget);

  //tap buttons
  if (route == TestRoute.SIGNUP) {
    await tester.tap(signup);
    await tester.pumpAndSettle();
    await testSignUp(tester, route);
  }
  if (route == TestRoute.LOGIN) {
    await tester.tap(login);
    await tester.pumpAndSettle();
    await testLogin(tester, route);
  }
}

