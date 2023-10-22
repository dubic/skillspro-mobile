import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/widgets/screen_utils.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/features/auth/sign_up/sign_up_controller.dart';
import 'package:skillspro/theme.dart';

import '../../../common/widgets/submit_button.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final SignupController c = Get.find();
    final ScreenUtils screenUtils = ScreenUtils.getInstance(context);

    return Scaffold(
        backgroundColor: backgoundColor1,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(child: signText(context), flex: 2),
              // SizedBox(height: screenUtils.heightOf(10)),
              Expanded(child: form(context), flex: 3),
              // SizedBox(height: screenUtils.heightOf(10)),
              Expanded(child: button(context, c), flex: 1)
            ]),
          ),
        ));
  }

// TEXT ---------------------------------------------------
  signText(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Sign Up",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const Text(
        "Fill in the details and create your account",
      )
    ]);
  }

  // FORMS ---------------------------------------------------
  form(BuildContext context) {
    return Column(children: [
      FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'name',
              decoration: inputDecoration("Full name"),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: 'email',
              decoration: inputDecoration("Email"),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(), FormBuilderValidators.email()]),
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: 'password',
              obscureText: true,
              maxLines: 1,
              decoration: inputDecoration("Password"),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
            ),
          ],
        ),
      )
    ]);
  }

  // ACTIONS ---------------------------------------------------
  button(BuildContext context, SignupController c) {
    return Column(children: [
      Obx(() => SubmitBtn(
          onPress: () => c.createAccount(_formKey),
          title: const Text("Create me"),
          loading: c.status.value == Status.processing))
    ]);
  }
}
