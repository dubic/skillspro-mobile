import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/src/form_builder.dart';
import 'package:get/get.dart';
import 'package:skillspro/features/auth/auth_service.dart';
import 'package:skillspro/features/auth/user_service.dart';
import 'package:skillspro/routes.dart';

import '../../../common/http/http_helper.dart';
import '../../../theme.dart';

class PasswordController extends GetxController {
  final UserService userService;
  final remindStatus = Status.init.obs;

  PasswordController(this.userService);

  backTologin() => Get.offAndToNamed(Routes.login);

  remindMe(GlobalKey<FormBuilderState> formKey) async {
    bool? isValid = formKey.currentState?.saveAndValidate();
    if (isValid != null && isValid == false) {
      return;
    }
    remindStatus.value = Status.processing;
    final email = formKey.currentState?.value['email'];
    final forgotPasswordResponse = await userService.forgotPassword(email);
    remindStatus.value = forgotPasswordResponse.getStatus();

    if (!forgotPasswordResponse.isSuccessful()) {
      errorToast('Forgot password error', forgotPasswordResponse.error?.message ?? '');
      return;
    }

    Get.toNamed(Routes.resetPassword, arguments: {'email': email});
  }
}
