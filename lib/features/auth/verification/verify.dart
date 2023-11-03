import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:skillspro/features/auth/verification/verify_controller.dart';
import 'package:skillspro/theme.dart';

import '../../../common/http/http_helper.dart';
import '../../../common/widgets/submit_button.dart';

class Verification extends StatelessWidget {
  Verification({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final VerifyController c = Get.find();
    return Scaffold(
        backgroundColor: backgoundColor1,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Expanded(flex: 2, child: signText(context, c)),
            Expanded(flex: 3, child: forms(context, c)),
            Expanded(flex: 1, child: button(context, c))
          ]),
        )));
  }

  // TEXT ---------------------------------------------------
  signText(BuildContext context, VerifyController c) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Verify Account",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 10),
      const Text(
        "We need to verify your account to protect your details",
      ),
      const SizedBox(height: 10),
      Text(
        "Enter the passcode sent to ${c.obscuredEmail()}",
      )
    ]);
  }

  // FORMS ---------------------------------------------------
  forms(BuildContext context, VerifyController c) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            key: const Key('token'),
            name: 'token',
            decoration: inputDecoration("Passcode"),
            validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  child: const Text("Resend passcode",
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                  onTap: () => c.resend())
            ],
          )
        ],
      ),
    );
  }

  // ACTIONS ---------------------------------------------------
  button(BuildContext context, VerifyController c) {
    return Column(children: [
      Obx(() => SubmitBtn(
          key: const Key('verifyMe'),
          onPress: () => c.verifyMe(_formKey),
          title: const Text("Verify me"),
          loading: c.status.value == Status.processing))
    ]);
  }
}
