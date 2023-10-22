// ignore: implementation_imports
import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/data/create_account_response.dart';

class UserService {
  Dio dio;

  UserService(this.dio);

  Future<HttpResponse<CreateAccountResponse>> createAccount(dynamic accountData) async {
    try {
      final response = await dio.post("$baseUrl/users", data: accountData);
      return HttpResponse<CreateAccountResponse>(
          response, CreateAccountResponse.create(response.data));
    } on DioException catch (e) {
      return HttpResponse<CreateAccountResponse>.exception(e);
    }
  }
}
