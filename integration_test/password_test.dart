import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/user_service.dart';

import 'test_context.dart';

testPassword(WidgetTester tester, TestRoute route) async {
  //Given mocks
  final UserService userService = Get.find();
  final dioAdapter = DioAdapter(dio: userService.dio);

  dioAdapter.onGet("$baseUrl/users/forgot-password/${IntegrationTestContext.user['email']}",
          (request) => request.reply(200, {}));
  dioAdapter.onPost("$baseUrl/users/reset-password",
          (request) => request.reply(200, {}), data: {
        "email": "udubic@gmail.com",
        "token": "22913950",
        "newPassword": "new_dcamic_4602"
      });

  expect(find.text('Enter the email address associated with this account'), findsOneWidget);
  final email = find.byKey(const Key('email'));
  final login = find.byKey(const Key('remindMe'));

  await tester.enterText(email, IntegrationTestContext.loginRequest['email']!);
  await tester.tap(login);
  await tester.pumpAndSettle();

  ///RESET PASSWORD/////
  expect(find.text('Reset password'), findsAtLeastNWidgets(1));
  final token = find.byKey(const Key('token'));
  final password = find.byKey(const Key('password'));
  final resend = find.text('Resend token');
  final reset = find.byKey(const Key('resetPassword'));

  //trigger resend
  await tester.tap(resend);
  await tester.pumpAndSettle();

  //reset
  await tester.enterText(token, '1234567');
  await tester.enterText(password, 'my-new-password');
  await tester.tap(reset);
  await tester.pumpAndSettle();
}