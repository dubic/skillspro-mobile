import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/intro/page.dart';
import 'package:skillspro/routes.dart';

class IntroController extends GetxController {
  final PageController pageController = PageController();
  var onLastPage = false.obs;
  List<IntroPage> pages = List.of([
    IntroPage(
        image: 'assets/images/undraw_portfolio_feedback.svg',
        title: "Display your talents",
        desc:
            "Build your portfolio, add your completed projects to your profile"),
    IntroPage(
        image: 'assets/images/undraw_social_girl_re_kdrx.svg',
        title: "Unveil Your Expertise",
        desc: "Post images of what you can achieve for all")
  ]);

  done() {
    Get.offAllNamed(Routes.getStarted);
  }

  onPageChanged(int value) {
    onLastPage.value = (value == pages.length - 1);
  }

  skip() {
    Get.offAllNamed(Routes.getStarted);
  }
}
