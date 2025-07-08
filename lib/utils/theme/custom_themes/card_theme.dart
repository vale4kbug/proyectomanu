import 'package:flutter/material.dart';

class TCardTheme {
  TCardTheme._();

  static CardThemeData lightCardTheme = CardThemeData(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    shadowColor: Colors.blueAccent.shade100,
  );

  static CardThemeData darkCardTheme = CardThemeData(
    color: Colors.grey[900],
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    shadowColor: Colors.blueAccent.shade100,
  );
}
