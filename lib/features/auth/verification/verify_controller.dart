import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/src/form_builder.dart';
import 'package:get/get.dart';
import 'package:skillspro/env.config.dart';
import 'package:skillspro/features/auth/data/create_account_response.dart';
import 'package:skillspro/features/auth/user_service.dart';

import '../../../common/http/http_helper.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../auth_service.dart';

class VerifyController extends GetxController {
  final CreateAccountResponse createAccountResponse = Get.arguments;
  final UserService userService;
  final AuthService authService;
  final status = Status.init.obs;

  VerifyController(this.userService, this.authService);

  String getEmail() {
    return createAccountResponse.email;
  }

  String obscuredEmail() {
    return userService.obscureEmail(getEmail());
  }

  resend() {
    infoToast('Processing...', 'Resending passcode!');
    userService.resendVerificationToken(getEmail()).then((resp) => {
          if (resp.isSuccessful())
            successToast('Resend successful!', resp.data ?? '')
          else
            errorToast('Resend passcode error', resp.error?.message ?? '')
        });
  }

  verifyMe(GlobalKey<FormBuilderState> formKey) async {
    bool? isValid = formKey.currentState?.saveAndValidate();
    if (isValid != null && isValid == false) {
      return;
    }
    status.value = Status.processing;
    final verificationRequest = {
      'userId': getEmail(),
      'token': formKey.currentState?.value['token']
    };
    final response = await userService.verifyAccount(verificationRequest);
    status.value = response.getStatus();
    if (!response.isSuccessful()) {
      errorToast('Verify account error', response.error?.message ?? '');
      return;
    }

    authService.saveAuthentication(response.data!);
    Get.toNamed(Routes.createProfile, arguments: response.data);
  }
}
