import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/widgets/loading.dart';
import 'package:skillspro/common/widgets/buttons.dart';
import 'package:skillspro/features/auth/login/login_controller.dart';
import 'package:skillspro/theme.dart';

import '../../../common/http/http_helper.dart';
import '../../../common/widgets/screen_utils.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final LoginController c = Get.find();
    final screenUtils = ScreenUtils.getInstance(context);

    return Scaffold(
        backgroundColor: backgoundColor1,
        body: SafeArea(
          child: buildGetStarted(c, screenUtils),
        ));
  }

  buildGetStarted(LoginController c, ScreenUtils screenUtils) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
          child: Column(children: [
        topImage(screenUtils),
        const Gap(45),
        forms(),
        const Gap(20),
        forgotPassword(c),
        const Gap(45),
        actions(c),
        const Gap(35),
        signupLine(c)
      ])),
    );
  }

  topImage(ScreenUtils screenUtils) {
    return Column(children: [
      const Text("Welcome back!", style: headingTextStyle),
      const Gap(15),
      Image(
          image: const AssetImage("assets/images/undraw_login.png"), width: screenUtils.heightOf(3))
    ]);
  }

  forms() {
    return FormBuilder(
        key: _formKey,
        child: Column(children: [
          FormBuilderTextField(
            key: const Key('email'),
            name: 'email',
            decoration: inputDecoration("Email"),
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(), FormBuilderValidators.email()]),
          ),
          const Gap(20),
          FormBuilderTextField(
            key: const Key('password'),
            name: 'password',
            obscureText: true,
            maxLines: 1,
            decoration: inputDecoration("Password"),
            validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
          )
        ]));
  }

  forgotPassword(LoginController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            key: const Key('forgotPassword'),
            child: const Text(
              "forgot password?",
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
            onTap: () => c.forgotPassword())
      ],
    );
  }

  actions(LoginController c) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          flex: 2,
          child: Obx(() => SubmitBtn(
                key: const Key('login'),
                onPress: () => c.login(_formKey),
                title: const Text('Login'),
                loading: c.loginStatus.value == Status.processing,
              ))),
      const Expanded(flex: 1, child: Center(child: Text('Or via'))),
      Expanded(
          flex: 1,
          child: Obx(() => CircularButton(
              key: const Key('loginGoogle'),
              loading: c.pageStatus.value == Status.processing,
              content: const Image(image: AssetImage("assets/images/google_red.png")),
              onPress: () => c.loginWithGoogle())))
    ]);
  }

  signupLine(LoginController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Don’t have an account?"),
        GestureDetector(
            key: const Key('signup'),
            child: const Text(
              "Sign up",
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
            onTap: () => c.toSignUp())
      ],
    );
  }
}
