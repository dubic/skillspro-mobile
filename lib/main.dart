import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/splash/splash.dart';
import 'package:skillspro/features/auth/sign_up/sign_up.dart';
import 'package:skillspro/features/auth/verification/verify.dart';
import 'package:skillspro/routes.dart';
import 'package:skillspro/theme.dart';

import 'common/intro/intro.dart';
import 'common/started/get_started.dart';
import 'features/auth/login/login.dart';
import 'features/home/home.dart';
import 'firebase_options.dart';
import 'home_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Initialized default app $app');
  runApp(const MyApp());
}

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
        GetPage(name: Routes.getStarted, page: () => const GetStarted()), // here!
        GetPage(name: Routes.intro, page: () => const Intro()),
        GetPage(name: Routes.login, page: () => Login()),
        GetPage(name: Routes.home, page: () => const Home()),
        GetPage(name: Routes.signUp, page: () => SignUp()),
        GetPage(name: Routes.verification, page: () => Verification()),
      ],
    );
  }
}
