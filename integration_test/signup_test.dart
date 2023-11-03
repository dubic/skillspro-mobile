import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/user_service.dart';

import 'test_context.dart';
import 'verify_test.dart';

Future<void> testSignUp(WidgetTester tester, TestRoute route) async {
  //Given mocks
  final UserService userService = Get.find();
  final dioAdapter = DioAdapter(dio: userService.dio);

  dioAdapter.onPost(
      "$baseUrl/users",
          (request) => request.reply(200, {'verified': false, 'tokenTtlSecs': 300}),
      data: IntegrationTestContext.user
  );
  //find text fields and submit button
  final name = find.byKey(const Key('name'));
  final email = find.byKey(const Key('email'));
  final password = find.byKey(const Key('password'));
  final createMe = find.byKey(const Key('createMe'));

  expect(name, findsOneWidget);
  expect(email, findsOneWidget);
  expect(password, findsOneWidget);
  expect(createMe, findsOneWidget);
//enter user details
  await tester.enterText(name, IntegrationTestContext.user['name']!);
  await tester.enterText(email, IntegrationTestContext.user['email']!);
  await tester.enterText(password, IntegrationTestContext.user['password']!);

  //submit
  await tester.tap(createMe);
  await tester.pumpAndSettle();

  await testVerify(tester, route);
}