import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/src/form_builder.dart';
import 'package:get/get.dart';
import 'package:skillspro/features/auth/user_service.dart';
import 'package:skillspro/routes.dart';
import 'package:skillspro/theme.dart';

import '../../../common/http/http_helper.dart';

class SignupController extends GetxController {
  var processing = false.obs;

  final status = Status.init.obs;

  UserService userService;

  SignupController(this.userService);

  createAccount(GlobalKey<FormBuilderState> formKey) async {
    bool? isValid = formKey.currentState?.saveAndValidate();
    if (isValid != null && isValid == false) {
      return;
    }
    status.value = Status.processing;
    final response = await userService.createAccount(formKey.currentState?.value);
    status.value = response.getStatus();
    if (!response.isSuccessful()) {
      errorToast('Create account error', response.error?.message ?? '');
      return;
    }
    if (response.data?.verified == false) {
      Get.toNamed(Routes.verification, arguments: {'email': response.data!.email});
    }
  }
}
