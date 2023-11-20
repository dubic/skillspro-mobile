import 'package:shared_preferences/shared_preferences.dart';

class IntegrationTestContext {
  static const user = {
    'email': 'udubic@gmail.com',
    'name': 'Dubic Uzuegbu',
    'password': 'dcamic45081'
  };

  static dynamic verificationRequest = {'userId': user['email'], 'token': '123456'};
  static dynamic loginRequest = {'email': user['email'], 'password': user['password']};

  static resetIntro({required bool seen}) async {
    var p = await SharedPreferences.getInstance();
    await p.setBool('seen', seen);
  }
}

enum TestRoute { SIGNUP, LOGIN, PASSWORD }
