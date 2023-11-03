import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/auth_service.dart';
import 'package:skillspro/features/auth/user_service.dart';
import 'package:skillspro/features/auth/verification/verify_controller.dart';

import 'test_context.dart';

testVerify(WidgetTester tester, TestRoute route) async {
  //Given mocks
  final UserService userService = Get.find();
  final dioAdapter = DioAdapter(dio: userService.dio);

  dioAdapter.onPost(
      "$baseUrl/users/verify",
      (request) => request.reply(200, {
            "token": "e149c3b6-2afd-4e2b-9a3f-b2f5538fccb3",
            "account": {
              "name": IntegrationTestContext.user['name'],
              "email": IntegrationTestContext.user['email'],
              "verified": true
            }
          }),
      data: IntegrationTestContext.verificationRequest);

  dioAdapter.onGet('$baseUrl/users/verify/resend/${IntegrationTestContext.user['email']}',
      (request) => request.reply(200, {}));

  //find text fields and submit button
  final token = find.byKey(const Key('token'));
  final resend = find.text('Resend passcode');
  final verifyMe = find.byKey(const Key('verifyMe'));

  expect(token, findsOneWidget);
  expect(resend, findsOneWidget);
  expect(verifyMe, findsOneWidget);

  //trigger resend
  await tester.tap(resend);
  await tester.pumpAndSettle();

  //enter user details
  await tester.enterText(token, IntegrationTestContext.user['name']!);
  //submit
  await tester.tap(verifyMe);
  await tester.pumpAndSettle();
  
  //check authentication is saved
  // final AuthService authService = Get.find();
  // var authResponse = await authService.getAuthentication();
  // expect(authResponse?.token, "e149c3b6-2afd-4e2b-9a3f-b2f5538fccb3");
  // expect(authResponse?.account.email, IntegrationTestContext.user['email']);
  // expect(authResponse?.account.name, IntegrationTestContext.user['name']);
}
