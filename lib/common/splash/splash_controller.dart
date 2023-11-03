import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/routes.dart';

import '../../features/auth/auth_holder.dart';

class SplashController {
  final Future<SharedPreferences> prefs;
  final AuthHolder authHolder;

  SplashController({required this.prefs, required this.authHolder}) {}

  Future<bool> hasSeenIntro() async {
    final bool? seen = await prefs.then((p) => p.getBool('seen'));
    return seen ?? false;
  }

  Future<bool> isAuthenticated() async {
    return await authHolder.getAuthenticationToken() != null;
  }

  seenIntro() async {
    prefs.then((p) => p.setBool('seen', true));
  }

  void waitAndMove(DateTime start, String route, Object? p) {
    var dateDiff = DateTime.now().difference(start);
    print('DATE DIFF : ${dateDiff.inSeconds}');
    var secsRem = isTest ? 0 : 3 - dateDiff.inSeconds;
    print('SECONDS REMAINING : $secsRem');
    if (secsRem > 1) {
      Timer(Duration(seconds: secsRem), () async {
        Get.offAllNamed(route);
      });
    } else {
      Get.offAllNamed(route);
    }
  }

  Future<void> next() async {
    if (await hasSeenIntro() == false) {
      waitAndMove(DateTime.now(), Routes.intro, null);
      seenIntro();
      return;
    }
    if (await isAuthenticated() == false) {
      waitAndMove(DateTime.now(), Routes.getStarted, null);
      return;
    }
    waitAndMove(DateTime.now(), Routes.home, null);
  }
}
