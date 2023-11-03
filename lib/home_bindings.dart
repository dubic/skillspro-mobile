import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillspro/common/intro/intro_controller.dart';
import 'package:skillspro/common/started/get_started_controller.dart';
import 'package:skillspro/features/auth/sign_up/sign_up_controller.dart';
import 'package:skillspro/features/auth/user_service.dart';
import 'package:skillspro/features/auth/verification/verify_controller.dart';

import 'common/splash/splash_controller.dart';
import 'features/auth/auth_holder.dart';
import 'features/auth/auth_service.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    const storage = FlutterSecureStorage();
    final authHolder = AuthHolder(storage: storage);
    Get.create<SplashController>(() => SplashController(
        prefs: SharedPreferences.getInstance(), authHolder: authHolder));
    Get.put<AuthHolder>(authHolder);
    Get.create(() => IntroController());
    Get.create(() => GetStartedController());
    final dio = Dio();
    var userService = UserService(dio);
    var authService = AuthService(dio, storage);
    Get.put(userService);
    Get.create(() => SignupController(userService));
    Get.create(() => VerifyController(userService, authService));

  }
}
