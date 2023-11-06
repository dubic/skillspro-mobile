import 'package:get/get.dart';
import 'package:skillspro/features/auth/google_sign_in.dart';
import 'package:skillspro/routes.dart';
import 'package:skillspro/theme.dart';

class GetStartedController {
  void loginWithGoogle() {}

  signUp() {
    Get.toNamed(Routes.signUp);
  }

  toLogin() {
    Get.toNamed(Routes.login);
  }

  googleSignIn() async {
    try {
      var googleUser = await signInWithGoogle();
      var idToken = await googleUser.user?.getIdToken();
      print('Authenticated - ID tokens...$idToken');
    } on Exception catch (e) {
      e.printError();
      errorToast('Google sign in failed', e.toString());
    }
  }
}
