import 'package:flutter/material.dart';

// Define the primary and accent colors for your app
const Color primaryColor = Color(0xff854FE3);
const Color accentColor = Color(0xFFB695EE);
const Color textColor = Color(0xFF424242);

// Define the text styles for the app
const TextStyle headingTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

final TextStyle bodyTextStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.grey[800],
);

// Define the ThemeData for your app
final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
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
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData (
    backgroundColor: primaryColor
  )
);

// Optionally, you can create a dark theme as well