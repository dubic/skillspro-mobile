import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class SearchField extends StatelessWidget {
  final String placeholder;
  final onChanged;

  // final Callback onChanged;

  const SearchField({Key? key, required this.placeholder, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const throttleDuration = Duration(milliseconds: 500);
    Timer? _throttleTimer;

    return TextField(
        onChanged: (String value) {
          if (_throttleTimer == null || !_throttleTimer!.isActive) {
            // Your function or API call
            print('Scrolling, but in a measured cadence.');
            onChanged(value);

            _throttleTimer = Timer(throttleDuration, () {
              _throttleTimer = null;
            });
          }
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: placeholder,
            hintStyle: const TextStyle(fontSize: 18),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SvgPicture.asset('assets/images/instagram.svg'),
            )));
  }
}
