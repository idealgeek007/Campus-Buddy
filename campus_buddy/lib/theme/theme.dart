import 'package:flutter/material.dart';

/*ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xFFDBDFEA),
    primary: Color(0xFFB0D0B0), // Soft Pastel Green
    secondary: Color(0xFFACB1D6),
    tertiary: Color(0xFF8294C4),

    surface: Color(0xFF80967C), // Light Gray with a Hint of Warmth
    error: Color(0xFFD32F2F),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
);*/
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xFFDBDFEA),
    primary: Color(0xFFB0CBEF), // Soft Pastel Blue
    secondary: Color(0xFFACB1D6),
    tertiary: Color(0xFF8294C4),
    surface: Colors.blueGrey,
    error: Color(0xFFD32F2F),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF6A9D7B),
    secondary: Color(0xFFA8C8B8),
    surface: Color(0xFF2D3B43),
    background: Color(0xFF344C50),
    error: Color(0xFFCC3333),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
);
