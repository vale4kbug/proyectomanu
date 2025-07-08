import 'package:flutter/material.dart';

class TFloatingActionButtonTheme {
  TFloatingActionButtonTheme._();

  static FloatingActionButtonThemeData lightFloatingActionButtonTheme =
      const FloatingActionButtonThemeData(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 6,
      );

  static FloatingActionButtonThemeData darkFloatingActionButtonTheme =
      const FloatingActionButtonThemeData(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black,
        elevation: 6,
      );
}
