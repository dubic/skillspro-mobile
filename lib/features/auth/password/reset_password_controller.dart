import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/src/form_builder.dart';
import 'package:get/get.dart';
import 'package:skillspro/routes.dart';

import '../../../common/http/http_helper.dart';
import '../../../theme.dart';
import '../user_service.dart';

class ResetPasswordController extends GetxController {
  final UserService userService;
  final status = Status.init.obs;
  final resendStatus = Status.init.obs;
  final argumentMap = Get.arguments;

  ResetPasswordController(this.userService);

  maskedEmail() => userService.obscureEmail(getEmail());

  reset(GlobalKey<FormBuilderState> formKey) async {
    bool? isValid = formKey.currentState?.saveAndValidate();
    if (isValid != null && isValid == false) {
      return;
    }
    status.value = Status.processing;
    var request = formKey.currentState!.value;
    final resetResponse = await userService.resetPassword(
        {'email': getEmail(), 'token': request['token'], 'newPassword': request['newPassword']});
    status.value = resetResponse.getStatus();

    if (!resetResponse.isSuccessful()) {
      errorToast('Reset password error', resetResponse.error?.message ?? '');
      return;
    }

    successToast('Success', 'Password reset successful!');
    Get.offNamed(Routes.login);
  }

  resend() async {
    resendStatus.value = Status.processing;
    final forgotResponse = await userService.forgotPassword(getEmail());
    resendStatus.value = forgotResponse.getStatus();

    if (!forgotResponse.isSuccessful()) {
      errorToast('Resend token error', forgotResponse.error?.message ?? '');
      return;
    }

    successToast('Success', 'Token resent successfully');
  }

  String getEmail() => argumentMap['email'];
}
