import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthHolder{
  final FlutterSecureStorage storage;
  String? authToken;

  AuthHolder({required this.storage} ){}

  Future<String?> getAuthenticationToken() async {
    authToken ??= await getAuthTokenFromStorage();
    return authToken;
  }

  Future<String?> getAuthTokenFromStorage() async {
    String? authStr = await storage.read(key: "auth");
    if (authStr != null) {
      var authResponse = json.decode(authStr);
      return authResponse['token'];
    }
    return null;
  }
}