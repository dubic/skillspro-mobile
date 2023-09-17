import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/intro/intro_page.dart';
import 'package:skillspro/common/intro/intro_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IntroController c = Get.find();
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: c.pageController,
          onPageChanged: (value) => c.onPageChanged(value),
          children: [
            introPage(0, c),
            introPage(1, c),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.85),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(onTap: () => c.skip(), child: const Text("SKIP")),
              SmoothPageIndicator(
                controller: c.pageController,
                count: c.pages.length,
                effect: const WormEffect(),
                onDotClicked: (position) {},
              ),
              Obx(() {
                return c.onLastPage.value == true
                    ? GestureDetector(
                        onTap: () => c.done(), child: const Text("DONE"))
                    : GestureDetector(
                        onTap: () => c.pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn),
                        child: const Text("NEXT"));
              })
            ],
          ),
        ),
      ]),
    );
  }
}
