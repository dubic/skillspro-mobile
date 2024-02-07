import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/common/started/get_started_controller.dart';
import 'package:skillspro/common/widgets/loading.dart';
import 'package:skillspro/common/widgets/screen_utils.dart';
import 'package:skillspro/common/widgets/buttons.dart';
import 'package:skillspro/common/widgets/texts.dart';
import 'package:skillspro/theme.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtils = ScreenUtils.getInstance(context);
    final GetStartedController c = Get.find();
    return Scaffold(
        backgroundColor: backgoundColor1,
        body: SafeArea(
          child: Obx(() =>
              // ignore: prefer_const_constructors
              Loading(
                  text: 'Creating your account...',
                  loading: c.status.value == Status.processing,
                  child: buildGetStarted(c, screenUtils))),
        ));
  }

//GET STARTED
  buildGetStarted(GetStartedController c, ScreenUtils screenUtils) {
    return SingleChildScrollView(
      child: SizedBox(
        height: screenUtils.heightOf(1),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                  image: const AssetImage("assets/images/welcome.png"),
                  width: screenUtils.heightOf(3)),
              Column(
                children: [
                  const TitleText(text: 'Welcome'),
                  SizedBox(height: screenUtils.heightOf(35)),
                  const BodyText(text: 'Create an account or login to showcase your talents')
                ],
              ),
              // SizedBox(height: ScreenUtils.heightOf(30)),
              Column(
                children: [
                  OutlinedButton(
                      onPressed: () => c.loginWithGoogle(),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image(image: AssetImage("assets/images/google_colorful.png")),
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(height: screenUtils.heightOf(30)),
                  SubmitBtn(
                      key: const Key('signup'),
                      onPress: () => c.signUp(),
                      title: const Text("Sign Up")),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Already have an account?"),
                      LinkText(key: const Key('login'), text: 'Login', onTap: () => c.toLogin())
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
