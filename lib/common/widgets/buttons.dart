import 'package:flutter/material.dart';
import 'package:skillspro/theme.dart';

class SubmitBtn extends StatelessWidget {
  final VoidCallback onPress;
  final Widget title;
  final bool loading;

  const SubmitBtn({super.key, required this.onPress, required this.title, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
          onPressed: loading ? null : onPress,
          child: loading == false
              ? title
              : const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.white)),
        ));
  }
}

class CircularButton extends StatelessWidget {
  final VoidCallback onPress;
  final Widget content;
  final bool loading;

  const CircularButton(
      {Key? key, required this.onPress, required this.content, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: loading ? null : onPress,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: backgoundColor1, // <-- Button color
          // foregroundColor: Colors.red, // <-- Splash color
        ),
        child: loading == false
            ? content
            : const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.white)),
      ),
    );
  }
}
