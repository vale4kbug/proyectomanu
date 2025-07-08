import 'package:flutter/material.dart';

class TDialogTheme {
  TDialogTheme._();

  static DialogThemeData lightDialogTheme = DialogThemeData(
    backgroundColor: Colors.white,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    contentTextStyle: TextStyle(color: Colors.black87),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  static DialogThemeData darkDialogTheme = DialogThemeData(
    backgroundColor: Colors.grey[900],
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    contentTextStyle: TextStyle(color: Colors.white70),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}
