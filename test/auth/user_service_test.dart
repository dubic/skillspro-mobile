import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/user_service.dart';

// @GenerateMocks([Dio])
void main() {


  test("create account is successful", () async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);

    final account = {'name': 'Dubic uzuegbu'};
    dioAdapter.onPost(
      "$baseUrl/users",
          (request) => request.reply(200, {'verified': false, 'tokenTtlSecs': 300}),
      data: account
    );
    final response = await UserService(dio).createAccount(account);
    print(response.data);
    expect(response.isSuccessful(), true);
    expect(response.data?.verified, false);
    expect(response.data?.tokenTtlSecs, 300);
  });

  test("create account invalid request", () async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);

    final account = {'name': ''};
    dioAdapter.onPost(
        "$baseUrl/users",
            (request) => request.reply(400, {'title': 'Bad Request', 'detail': 'name must be provided'}),
        data: account
    );
    final response = await UserService(dio).createAccount(account);
    print(response.error);
    expect(response.isSuccessful(), false);
    expect(response.data, null);
    expect(response.error?.message, 'name must be provided');
    expect(response.error?.title, 'Bad Request');
  });
}
