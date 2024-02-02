import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillspro/common/intro/intro_controller.dart';
import 'package:skillspro/common/services/firestore.dart';
import 'package:skillspro/common/started/get_started_controller.dart';
import 'package:skillspro/features/auth/login/login_controller.dart';
import 'package:skillspro/features/auth/password/forgot_password_controller.dart';
import 'package:skillspro/features/auth/password/reset_password_controller.dart';
import 'package:skillspro/features/auth/sign_up/sign_up_controller.dart';
import 'package:skillspro/features/auth/user_service.dart';
import 'package:skillspro/features/auth/verification/verify_controller.dart';
import 'package:skillspro/features/profile/data/select_state_controller.dart';
import 'package:skillspro/features/profile/profile_service.dart';
import 'package:skillspro/features/profile/skills/add_skills_controller.dart';

import 'common/splash/splash_controller.dart';
import 'features/auth/auth_service.dart';
import 'features/profile/details/create_profile_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    const storage = FlutterSecureStorage();
    final dio = Dio();

    // dio.interceptors.add(LogInterceptor());
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 45);

    var userService = UserService(dio: dio);
    Get.put(userService);
    var authService = AuthService(dio, storage);
    Get.put(authService);
    var fireStoreService = FireStoreService();
    Get.put(fireStoreService);
    final profileService = ProfileService(dio: dio);
    Get.put(profileService);

    Get.create<SplashController>(
        () => SplashController(prefs: SharedPreferences.getInstance(), authService: authService));
    Get.create(() => IntroController());

    Get.create(() => GetStartedController(authService));
    Get.create(() => SignupController(userService));
    Get.create(() => VerifyController(userService, authService));
    Get.create(() => LoginController(authService));
    Get.create(() => PasswordController(userService));
    Get.create(() => ResetPasswordController(userService));
    Get.create(() => CreateProfileController(
        authService: authService, userService: userService, profileService: profileService));
    Get.put(SelectStateController(fireStoreService));
    Get.create(() => AddSkillsController());
  }
}
