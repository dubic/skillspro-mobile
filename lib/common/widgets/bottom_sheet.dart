import 'package:flutter/material.dart';

import '../../theme.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget content;

  const BottomSheetContainer({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
          decoration: const BoxDecoration(
              color: backgoundColor1,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
          height: 600,
          width: double.infinity,
          child: Padding(padding: const EdgeInsets.all(12.0), child: content))
    ]);
  }
}
