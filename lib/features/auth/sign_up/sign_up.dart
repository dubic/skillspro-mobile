import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/features/auth/sign_up/sign_up_controller.dart';
import 'package:skillspro/theme.dart';

import '../../../common/widgets/screen_utils.dart';
import '../../../common/widgets/buttons.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final SignupController c = Get.find();
    final screenUtils = ScreenUtils.getInstance(context);

    return Scaffold(
        backgroundColor: backgoundColor1,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                signText(context),
                SizedBox(height: screenUtils.heightOf(10)),
                form(context),
                SizedBox(height: screenUtils.heightOf(10)),
                button(context, c)
              ]),
            ),
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
      const SizedBox(height: 10),
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
              key: const Key('name'),
              name: 'name',
              decoration: inputDecoration("Full name"),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              key: const Key('email'),
              name: 'email',
              decoration: inputDecoration("Email"),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(), FormBuilderValidators.email()]),
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              key: const Key('password'),
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
          key: const Key('createMe'),
          onPress: () => c.createAccount(_formKey),
          title: const Text("Create me"),
          loading: c.status.value == Status.processing))
    ]);
  }
}
