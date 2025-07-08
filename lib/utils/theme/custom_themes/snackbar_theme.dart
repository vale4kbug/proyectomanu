import 'package:flutter/material.dart';

class TSnackBarTheme {
  TSnackBarTheme._();

  static SnackBarThemeData lightSnackBarTheme = const SnackBarThemeData(
    backgroundColor: Colors.blueAccent,
    contentTextStyle: TextStyle(color: Colors.white),
    actionTextColor: Colors.yellow,
    elevation: 6,
    behavior: SnackBarBehavior.floating,
  );

  static SnackBarThemeData darkSnackBarTheme = const SnackBarThemeData(
    backgroundColor: Colors.black87,
    contentTextStyle: TextStyle(color: Colors.white),
    actionTextColor: Colors.blueAccent,
    elevation: 6,
    behavior: SnackBarBehavior.floating,
  );
}
