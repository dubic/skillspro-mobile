import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/started/get_started_controller.dart';
import 'package:skillspro/common/widgets/submit_button.dart';
import 'package:skillspro/theme.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetStartedController c = Get.find();
    return Scaffold(
        backgroundColor: backgoundColor1,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Image(image: AssetImage("assets/images/welcome.png")),
              // const SizedBox(height: 10),
              const Column(
                children: [
                  Text("Welcome", style: headingTextStyle),
                  SizedBox(height: 10),
                  Text(
                    "Create an account or login to showcase your talents",
                    style: bodyTextStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  OutlinedButton(
                      onPressed: () => c.loginWithGoogle(),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image(
                                image: AssetImage(
                                    "assets/images/google_colorful.png")),
                          ),
                          Expanded(
                              flex: 4,
                              child: Center(
                                  child: Text(
                                "Sign in with Google",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600),
                              )))
                        ],
                      )),
                  const SizedBox(height: 10),
                  SubmitBtn(
                      onPress: () => c.signUp(), title: const Text("Sign Up")),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Already have an account?"),
                      GestureDetector(
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () => c.toLogin())
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
