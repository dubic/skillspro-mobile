// ignore: implementation_imports

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/data/auth_response.dart';
import 'package:skillspro/features/auth/data/create_account_response.dart';

class UserService {
  final Dio dio;

  UserService({required this.dio});

  Future<HttpResponse<CreateAccountResponse>> createAccount(dynamic accountData) async {
    try {
      final response = await dio.post("$baseUrl/users", data: accountData);
      return HttpResponse<CreateAccountResponse>(
          response, CreateAccountResponse.create(accountData['email'], response.data));
    } on DioException catch (e) {
      return HttpResponse<CreateAccountResponse>.exception(e);
    }
  }

  String obscureEmail(String email) {
    final parts = email.split("@");
    var len = parts[0].length;
    var end = len;
    var numbersToObscure = len > 3 ? 3 : len - 1;
    numbersToObscure = numbersToObscure == 0 ? 1 : numbersToObscure;
    var start = len - numbersToObscure;
    return '${parts[0].replaceRange(start, end, ''.padRight(numbersToObscure, '*'))}@${parts[1]}';
  }

  Future<HttpResponse<String>> resendVerificationToken(String email) async {
    try {
      final response = await dio.get('$baseUrl/users/verify/resend/$email');
      return HttpResponse<String>(response, 'Verification token resent!');
    } on DioException catch (e) {
      return HttpResponse<String>.exception(e);
    }
  }

  Future<HttpResponse<AuthResponse>> verifyAccount(Map<String, dynamic> verificationRequest) async {
    try {
      final response = await dio.post('$baseUrl/users/verify', data: verificationRequest);
      return HttpResponse<AuthResponse>(response, AuthResponse.create(response.data));
    } on DioException catch (e) {
      return HttpResponse<AuthResponse>.exception(e);
    }
  }

  Future<HttpResponse<String>> forgotPassword(String email) async {
    try {
      final response = await dio.get('$baseUrl/users/forgot-password/$email');
      return HttpResponse<String>(response, 'successful');
    } on DioException catch (e) {
      return HttpResponse<String>.exception(e);
    }
  }

  Future<HttpResponse<String>> resetPassword(Map<String, dynamic> resetData) async {
    try {
      final response = await dio.post('$baseUrl/users/reset-password', data: resetData);
      return HttpResponse<String>(response, 'successful');
    } on DioException catch (e) {
      return HttpResponse<String>.exception(e);
    }
  }

  Future<HttpResponse<String>> uploadProfileImage(String path, String fileName) async {
    try {
      final formData = FormData.fromMap({
        'profile': await MultipartFile.fromFile(path, filename: fileName, contentType: MediaType('image','jpeg')),

      });
      print('Image data path :: $path');
      print('Image data name :: ${formData.files[0].value.filename}');
      print('Image data type :: ${formData.files[0].value.contentType?.type}');
      print('Image data type :: ${formData.files[0].value.contentType?.type}');
      final response = await dio.post('$baseUrl/users/photo', data: formData, options: Options(contentType: Headers.multipartFormDataContentType));
      return HttpResponse<String>(response, response.data.toString());
    } on DioException catch (e) {
      return HttpResponse<String>.exception(e);
    }
  }

  Future<String> fakeUploadProfileImage(String path, String fileName) async {
    final formData = FormData.fromMap({
      'profile': await MultipartFile.fromFile(path, filename: fileName),
    });
    final url = await Future.delayed(
        const Duration(seconds: 2),
        () =>
            "https://www.kasandbox.org/programming-images/avatars/marcimus.png");
    //final response = await dio.post('$baseUrl/users/photo', data: formData);
    return url;
  }
}
