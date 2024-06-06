import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xFFF0F1F5),
    primary: Color(0xFF4E5669),
    secondary: Color(0xFFBFC7D4),
    tertiary: Color(0xFFD2D6E1),
    surface: Color(0xFFD2D6E1),
    error: Color(0xFFD32F2F),
    primaryContainer: Color(0xffE0E5EB),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFFD2D6E1),
    secondary: Color(0xFF4E5669),
    tertiary: Color(0xFF657084),
    surface: Color(0xFF657084),
    background: Color(0xFF373E4E),
    error: Color(0xFFCC3333),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
);

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme; // Set default theme to light

  // Step 2: Methods to update the custom theme
  void setCustomTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  void toggleTheme() {
    _currentTheme = _currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }

  ThemeData getCustomTheme() => _currentTheme;
}
