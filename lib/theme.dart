import 'package:flutter/material.dart';

// Define the primary and accent colors for your app
const Color primaryColor = Color(0xff854FE3);
const Color accentColor = Color(0xFFB695EE);
const Color textColor = Color(0xFF424242);
const Color textColorOnPrimary = Colors.white;
const Color backgoundColor1 = Colors.white;

// Define the text styles for the app
const TextStyle headingTextStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  color: Color(0xff363637),
);

const TextStyle bodyTextStyle = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.w400, color: Color(0xff363637));

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
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
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
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryColor));

// Optionally, you can create a dark theme as well
