import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color white = Colors.white;
  static const Color grey = Color.fromARGB(255, 95, 95, 95);
  static const Color orange = Colors.deepOrange;
  static ThemeData theme = ThemeData(
      fontFamily: 'poppins',
      primaryColor: black,
      appBarTheme: const AppBarTheme(backgroundColor: black));
}
