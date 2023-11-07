import 'package:get/get.dart';
import 'package:skillspro/features/auth/auth_service.dart';
import 'package:skillspro/features/auth/google_sign_in.dart';
import 'package:skillspro/routes.dart';
import 'package:skillspro/theme.dart';

import '../http/http_helper.dart';

class GetStartedController extends GetxController {
  final AuthService authService;
  final status = Status.init.obs;

  GetStartedController(this.authService);

  signUp() {
    Get.toNamed(Routes.signUp);
  }

  toLogin() {
    Get.toNamed(Routes.login);
  }

  loginWithGoogle() async {
    try {
      var googleUser = await signInWithGoogle();
      var idToken = await googleUser.user?.getIdToken();
      if (idToken == null) {
        throw Exception('Could not retrieve id token');
      }
      status.value = Status.processing;
      final response = await authService.socialSignin(idToken);
      status.value = response.getStatus();

      if (!response.isSuccessful()) {
        errorToast('Verify account error', response.error?.message ?? '');
        return;
      }

      authService.saveAuthentication(response.data!);
      Get.toNamed(Routes.createProfile, arguments: response.data);
    } on Exception catch (e) {
      status.value = Status.error;
      e.printError();
      errorToast('Google sign in failed', e.toString());
    }
  }
}
