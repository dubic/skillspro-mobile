
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/splash/splash_controller.dart';
import 'features/auth/auth_holder.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    final authHolder = AuthHolder(storage: const FlutterSecureStorage());
    Get.put<SplashController>(SplashController(prefs: SharedPreferences.getInstance(), authHolder: authHolder));
    Get.put<AuthHolder>(authHolder);
  }
}