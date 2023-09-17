import 'package:flutter/material.dart';
import 'package:skillspro/theme.dart';

class SubmitBtn extends StatelessWidget {
  final VoidCallback onPress;
  final Widget title;
  final bool loading;

  const SubmitBtn(
      {super.key,
      required this.onPress,
      required this.title,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
          onPressed: loading ? null : onPress,
          child: loading == false
              ? title
              : const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, backgroundColor: Colors.white)),
        ));
  }
}
