import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/common/widgets/texts.dart';
import 'package:skillspro/features/auth/password/forgot_password_controller.dart';

import '../../../common/widgets/buttons.dart';
import '../../../common/widgets/screen_utils.dart';
import '../../../theme.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final PasswordController c = Get.find();
    final screenUtils = ScreenUtils.getInstance(context);

    return Scaffold(
        backgroundColor: backgoundColor1,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
              child: Column(children: [
            const TitleText(text: 'Forgot Password'),
            const Gap(15),
            const BodyText(text: 'Enter the email address associated with this account'),
            Gap(screenUtils.heightOf(10)),
            Image(
                image: const AssetImage("assets/images/forgot_password.png"),
                width: screenUtils.heightOf(3)),
            Gap(screenUtils.heightOf(10)),
            form(context),
            const Gap(10),
            backTologin(c),
            Gap(screenUtils.heightOf(10)),
            Obx(() => SubmitBtn(
                  key: const Key('remindMe'),
                  onPress: () => c.remindMe(_formKey),
                  title: const Text('Remind Me'),
                  loading: c.remindStatus.value == Status.processing,
                ))
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
            const SizedBox(height: 15),
            FormBuilderTextField(
              key: const Key('email'),
              name: 'email',
              decoration: inputDecoration("Email"),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(), FormBuilderValidators.email()]),
            )
          ],
        ),
      )
    ]);
  }

  //Back to login
  backTologin(PasswordController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LinkText(key: const Key('toLogin'), text: 'Back to login', onTap: () => c.backTologin())
      ],
    );
  }
}
