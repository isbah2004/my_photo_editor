import 'package:flutter/material.dart';

class AppTheme {
  // static const Color primaryColor = Color(0xFF673AB7);
  // static const Color hintColor = Color(0xFF1976D2);
  // static const Color textBackground = Color(0x3E000000);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color selectedButtonBackground = Color(0x37FFFFFF);

  static TextStyle displayLarge = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static ThemeData defaultTheme = ThemeData(
    sliderTheme: const SliderThemeData(activeTrackColor: whiteColor,thumbColor: whiteColor),
    appBarTheme: const AppBarTheme(backgroundColor: blackColor),
    scaffoldBackgroundColor: blackColor,
    primaryColor: blackColor,
    hintColor: whiteColor,
    textTheme: TextTheme(
      displayLarge: displayLarge,
      bodyLarge: bodyLarge,
    ),
  );
}
