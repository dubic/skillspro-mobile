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

  expect(find.text('Enter the email address associated with this account'), findsOneWidget);
  final email = find.byKey(const Key('email'));
  final login = find.byKey(const Key('remindMe'));

  await tester.enterText(email, IntegrationTestContext.loginRequest['email']!);
  await tester.tap(login);
  await tester.pumpAndSettle();

  ///RESET PASSWORD/////

}
