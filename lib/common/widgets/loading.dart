import 'package:flutter/material.dart';

import '../../theme.dart';

class Loading extends StatelessWidget {
  final String text;
  final bool loading;
  Widget? child;
  Loading({Key? key, required this.text, this.child, required this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(loading || child == null) {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(strokeWidth: 2, backgroundColor: primaryColor),
              const SizedBox(height: 10),
              Text(text)
            ],
          ));
    }
    return child!;
  }
}
