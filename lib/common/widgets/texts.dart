import 'package:flutter/material.dart';
import 'package:skillspro/theme.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: headingTextStyle);
  }
}

class BodyText extends StatelessWidget {
  final String text;

  const BodyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: bodyTextStyle, textAlign: TextAlign.center);
  }
}

class LinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool loading;

  const LinkText({Key? key, required this.text, required this.onTap, this.loading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: loading ? null : onTap,
        child: Text(
          loading ? 'Please wait...' : text,
          style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ));
  }
}
