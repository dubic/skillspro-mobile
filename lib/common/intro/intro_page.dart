import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skillspro/common/intro/intro_controller.dart';
import 'package:skillspro/theme.dart';

introPage(final int index, final IntroController controller) {
  return Container(
    color: primaryColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(height: 200, controller.pages[index].image),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(controller.pages[index].title,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: textColorOnPrimary)),
              const SizedBox(height: 20),
              Text(controller.pages[index].desc,
                  style:
                      const TextStyle(fontSize: 20, color: textColorOnPrimary))
            ],
          ),
        ),
      ],
    ),
  );
}
