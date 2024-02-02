// ignore: implementation_imports
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/data/auth_response.dart';

class AuthService {
  Dio dio;
  final FlutterSecureStorage _storage;
  AuthResponse? _authResponse;

  AuthService(this.dio, this._storage);

  AuthResponse? getAccount(){
    return _authResponse;
  }

  Future<void> saveAuthentication(AuthResponse authResponse) async {
    _authResponse = authResponse;
    print('Auth save data ::: ${authResponse.getData()}');
    var jsonEncoded = jsonEncode(authResponse.getData());
    await _storage.write(key: 'auth_key', value: jsonEncoded);
    print('Auth account saved ::: ${getAccount()}');
  }

  Future<AuthResponse?> getAuthentication() async {
    var auth = await _storage.read(key: 'auth_key');
    if (auth == null) {
      return null;
    }
    try {
      _authResponse = AuthResponse.create(jsonDecode(auth));
    } on Exception catch (e) {
      print('Error: $e');
    }
    return _authResponse;
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
      AuthResponse authResponse = AuthResponse.create(response.data);
      await saveAuthentication(authResponse);

      return HttpResponse<AuthResponse>(response, authResponse);
    } on DioException catch (e) {
      return HttpResponse<AuthResponse>.exception(e);
    }
  }

  void updateAcountImageUrl(String? imageUrl) async {
    AuthResponse? auth = await getAuthentication();
    if (auth == null) {
      throw Exception('Error updating image url: No auth found');
    }
    auth.account.imageUrl = imageUrl;
    saveAuthentication(auth);
  }

  Future<bool> isValidAuthentication() async {
    AuthResponse? auth = await getAuthentication();
    if (auth == null) {
      return false;
    }
    try {
      final response = await dio.get("$baseUrl/auth/valid/${auth.token}");
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      if(e.response?.statusCode == 403){
        return false;
      }
      throw Exception(e.message);
    }
  }

  registerAuthInterceptor() async {
    AuthResponse? authResponse = await getAuthentication();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers['Authorization'] = 'Bearer ${authResponse?.token}';
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        }));
    print('Added interceptor for auth token ::: ${authResponse?.token}');
  }
}
