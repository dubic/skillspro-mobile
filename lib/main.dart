import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/splash/splash.dart';
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
        GetPage(name: "/getStarted", page: () => const GetStarted()), // here!
        GetPage(name: "/intro", page: () => const Intro()),
        GetPage(name: "/login", page: () => const Login()),
        GetPage(name: "/home", page: () => const Home()),
      ],
    );
  }
}


