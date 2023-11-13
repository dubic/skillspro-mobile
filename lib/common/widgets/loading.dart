import 'package:flutter/material.dart';

import '../../theme.dart';

class Loading extends StatelessWidget {
  final String text;
  const Loading({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
