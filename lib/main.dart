import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/splash/splash.dart';
import 'package:skillspro/features/auth/sign_up/sign_up.dart';
import 'package:skillspro/routes.dart';
import 'package:skillspro/theme.dart';

import 'common/home/home.dart';
import 'common/intro/intro.dart';
import 'common/started/get_started.dart';
import 'features/auth/login/login.dart';
import 'home_bindings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skillspro',
      theme: appTheme,
      initialRoute: "/",
      initialBinding: HomeBinding(),
      getPages: [
        GetPage(name: "/", page: () => const Splash()), // here!
        GetPage(
            name: Routes.getStarted, page: () => const GetStarted()), // here!
        GetPage(name: Routes.intro, page: () => const Intro()),
        GetPage(name: Routes.login, page: () => const Login()),
        GetPage(name: Routes.home, page: () => const Home()),
        GetPage(name: Routes.signUp, page: () => SignUp()),
      ],
    );
  }
}
