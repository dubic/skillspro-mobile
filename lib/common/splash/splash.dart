import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/splash/splash_controller.dart';
import 'package:skillspro/theme.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashController splashCtrl = Get.find();
    splashCtrl.next();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: primaryColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 120,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/images/skillspro_white.png'))),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
