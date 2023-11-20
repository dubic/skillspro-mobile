import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../common/http/http_helper.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../auth_service.dart';

class LoginController extends GetxController {
  final pageStatus = Status.init.obs;
  final loginStatus = Status.init.obs;

  final AuthService authService;

  LoginController(this.authService);

  forgotPassword() {
    Get.toNamed(Routes.forgotPassword);
  }

  login(GlobalKey<FormBuilderState> formKey) async {
    bool? isValid = formKey.currentState?.saveAndValidate();
    if (isValid != null && isValid == false) {
      return;
    }
    loginStatus.value = Status.processing;
    final loginResponse = await authService.login(formKey.currentState?.value);

    if (!loginResponse.isSuccessful()) {
      errorToast('Login error', loginResponse.error?.message ?? '');
      loginStatus.value = loginResponse.getStatus();
      return;
    }

    final authResponse = loginResponse.data!;
    if (authResponse.account.verified == false) {
      loginStatus.value = loginResponse.getStatus();
      Get.toNamed(Routes.verification, arguments: {'email': authResponse.account.email});
      return;
    }

    await authService.saveAuthentication(authResponse);
    loginStatus.value = loginResponse.getStatus();
    Get.offAllNamed(Routes.home);
  }

  loginWithGoogle() {
    pageStatus.value = Status.processing;
    Future.delayed(const Duration(seconds: 2), () {
      pageStatus.value = Status.success;
    });
  }

  toSignUp() {
    Get.toNamed(Routes.signUp);
  }
}
