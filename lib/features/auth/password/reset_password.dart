import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/widgets/loading.dart';
import 'package:skillspro/common/widgets/texts.dart';
import 'package:skillspro/features/auth/password/reset_password_controller.dart';
import 'package:skillspro/theme.dart';

import '../../../common/http/http_helper.dart';
import '../../../common/widgets/buttons.dart';
import '../../../common/widgets/screen_utils.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final ResetPasswordController c = Get.find();
    final screenUtils = ScreenUtils.getInstance(context);

    return Scaffold(
        backgroundColor: backgoundColor1,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
              child: Column(children: [
            const TitleText(text: 'Reset password'),
            const Gap(15),
            const BodyText(text: 'Your password reset token has been sent to your email.'),
            const Gap(15),
            BodyText(text: 'Enter the token sent to ${c.maskedEmail()}'),
            Gap(screenUtils.heightOf(10)),
            form(context),
            Gap(screenUtils.heightOf(10)),
            Obx(() => SubmitBtn(
                  key: const Key('resetPassword'),
                  onPress: () => c.reset(_formKey),
                  title: const Text('Reset password'),
                  loading: c.status.value == Status.processing,
                )),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => LinkText(
                      key: const Key('resend'),
                      text: 'Resend token',
                      onTap: () => c.resend(),
                      loading: c.resendStatus.value == Status.processing,
                    ))
              ],
            )
          ])),
        )));
  }

  // FORMS ---------------------------------------------------
  form(BuildContext context) {
    return Column(children: [
      FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              key: const Key('token'),
              name: 'token',
              decoration: inputDecoration("Token"),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
            ),
            const Gap(15),
            FormBuilderTextField(
              key: const Key('password'),
              name: 'newPassword',
              obscureText: true,
              decoration: inputDecoration("New Password"),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
            )
          ],
        ),
      )
    ]);
  }
}
