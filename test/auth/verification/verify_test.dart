import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:skillspro/features/auth/auth_service.dart';
import 'package:skillspro/features/auth/user_service.dart';
import 'package:skillspro/features/auth/verification/verify.dart';
import 'package:skillspro/features/auth/verification/verify_controller.dart';

void main(){
  testWidgets("test verification widget", (WidgetTester tester) async {
    //given
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    final controller = Get.put(VerifyController(UserService(dio), AuthService(dio, const FlutterSecureStorage())));
    await tester.pumpWidget(Verification());

    // expect(find.text('We need to verify your account to protect your details'), findsOneWidget);
    expect(find.byKey(const Key('token')), findsOneWidget);
  });
}