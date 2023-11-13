// ignore: implementation_imports
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/auth_holder.dart';
import 'package:skillspro/features/auth/data/auth_response.dart';
import 'package:skillspro/features/auth/data/create_account_response.dart';

class AuthService {
  Dio dio;
  final FlutterSecureStorage _storage;

  AuthService(this.dio, this._storage);

  Future<void> saveAuthentication(AuthResponse authResponse) async {
    var jsonEncoded = authResponse.getData().toString();
    await _storage.write(key: 'auth_key', value: jsonEncoded);
  }

  Future<AuthResponse?> getAuthentication() async {
    var auth = await _storage.read(key: 'auth_key');
    if (auth == null) {
      return null;
    }
    return AuthResponse.create(jsonDecode(auth));
  }

  Future<HttpResponse<AuthResponse?>> socialSignin(String idToken) async {
    try {
      final response = await dio.post("$baseUrl/auth/social/login", data: {'idToken': idToken});
      return HttpResponse<AuthResponse>(response, AuthResponse.create(response.data));
    } on DioException catch (e) {
      return HttpResponse<AuthResponse>.exception(e);
    }
  }

  Future<HttpResponse<AuthResponse>> login(Map<String, dynamic>? loginData) async {
    try {
      final response = await dio.post("$baseUrl/auth/login", data: loginData);
      return HttpResponse<AuthResponse>(response, AuthResponse.create(response.data));
    } on DioException catch (e) {
      return HttpResponse<AuthResponse>.exception(e);
    }
  }
}
