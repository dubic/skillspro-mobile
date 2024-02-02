import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/auth_service.dart';
import 'package:skillspro/routes.dart';
import 'package:skillspro/theme.dart';

class SplashController extends GetxController{
  final Future<SharedPreferences> prefs;
  final AuthService authService;

  SplashController({required this.prefs, required this.authService});

  Future<bool> hasSeenIntro() async {
    final bool? seen = await prefs.then((p) => p.getBool('seen'));
    return seen ?? false;
  }

  Future<bool> isAuthenticated() async {
    await authService.getAuthentication();
    print('Auth account ::: ${authService.getAccount()}');
    await authService.registerAuthInterceptor();
    return await authService.isValidAuthentication();
  }

  seenIntro() async {
    prefs.then((p) => p.setBool('seen', true));
  }

  void waitAndMove(DateTime start, String route, Object? p) {
    var dateDiff = DateTime.now().difference(start);
    print('DATE DIFF : ${dateDiff.inSeconds}');
    var secsRem = 3 - dateDiff.inSeconds;
    print('SECONDS REMAINING : $secsRem');

    print('MOVING TO ROUTE : $route');
    Timer(Duration(seconds: secsRem), () async {
      Get.offAllNamed(route);
    });
  }

  Future<void> next() async {
    var startTime = DateTime.now();
    if (await hasSeenIntro() == false) {
      waitAndMove(startTime, Routes.intro, null);
      seenIntro();
      return;
    }
    try {
      if (await isAuthenticated() == false) {
        waitAndMove(startTime, Routes.getStarted, null);
        return;
      }
    } on Exception catch (e) {
     errorToast('Could not connect to server!', e.toString());
    }
    waitAndMove(startTime, Routes.createProfile, null);
  }
}
