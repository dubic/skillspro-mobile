import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

// Define the primary and accent colors for your app
const Color primaryColor = Color(0xff854FE3);
const Color accentColor = Color(0xFFB695EE);
const Color textColor = Color(0xFF424242);
const Color textColorOnPrimary = Colors.white;
const Color backgoundColor1 = Colors.white;

// Define the text styles for the app
const TextStyle headingTextStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Color(0xff363637),
);

const TextStyle subHeadingTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Color(0xff363637),
);

const TextStyle bodyTextStyle =
    TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Color(0xff363637));

TextStyle boldBodyTextStyle(double size) =>
    TextStyle(fontSize: size, fontWeight: FontWeight.bold, color: const Color(0xff363637));

// Define the ThemeData for your app
final ThemeData appTheme = ThemeData(
    primaryColor: primaryColor,
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      // ···
      titleLarge: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        color: textColor,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.amberAccent,
      // textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primaryColor));

InputDecoration inputDecoration(String label,
{String? placeholder, Widget? prefix, Widget? suffix}) {
  return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: prefix,
      ),
      suffix: suffix,
      labelText: label,
      hintText: placeholder,
      hintStyle: const TextStyle(fontSize: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)));
}

errorToast(String title, String message) {
  Get.snackbar(title, message,
      backgroundColor: Colors.redAccent, duration: const Duration(seconds: 5));
}

successToast(String title, String message) {
  Get.snackbar(title, message,
      backgroundColor: Colors.greenAccent, duration: const Duration(seconds: 3));
}

infoToast(String title, String message) {
  Get.snackbar(title, message,
      backgroundColor: Colors.lightBlue, duration: const Duration(seconds: 2));
}
// Optionally, you can create a dark theme as well
