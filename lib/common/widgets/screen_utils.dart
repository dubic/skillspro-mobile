import 'package:flutter/cupertino.dart';

class ScreenUtils {
  final MediaQueryData mediaQuery;

  ScreenUtils({required this.mediaQuery});

  static ScreenUtils getInstance(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ScreenUtils(mediaQuery: mediaQuery);
  }

  heightOf(int factor) {
    return mediaQuery.size.height / factor;
  }
}
