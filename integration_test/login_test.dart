import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/auth_service.dart';

import 'password_test.dart';
import 'test_context.dart';

testLogin(WidgetTester tester, TestRoute route) async {
  //Given mocks
  final AuthService authService = Get.find();
  final dioAdapter = DioAdapter(dio: authService.dio);

  dioAdapter.onPost(
      "$baseUrl/auth/login",
      (request) => request.reply(200, {
            'token': '123_test_token',
            'account': {
              'name': IntegrationTestContext.user['name'],
              'email': IntegrationTestContext.user['email'],
              'verified': true
            }
          }),
      data: IntegrationTestContext.loginRequest);
  //find text fields and submit button
  expect(find.text('Welcome back!'), findsOneWidget);
  expect(find.text('Don’t have an account?'), findsOneWidget);
  expect(find.text('Sign up'), findsOneWidget);
  final email = find.byKey(const Key('email'));
  final password = find.byKey(const Key('password'));
  final login = find.byKey(const Key('login'));
  final loginGoogle = find.byKey(const Key('loginGoogle'));
  final forgotPassword = find.byKey(const Key('forgotPassword'));

  //enter login details
  await tester.enterText(email, IntegrationTestContext.loginRequest['email']!);
  await tester.enterText(password, IntegrationTestContext.loginRequest['password']!);

  if (route == TestRoute.LOGIN) {
    //login submit
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.tap(login);
    await tester.pumpAndSettle();
  }
  if (route == TestRoute.PASSWORD) {
    await tester.tap(forgotPassword);
    await tester.pumpAndSettle();
    await testPassword(tester, route);
  }
}
