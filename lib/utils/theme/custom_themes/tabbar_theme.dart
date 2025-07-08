import 'package:flutter/material.dart';

class TTabBarTheme {
  TTabBarTheme._();

  static TabBarThemeData lightTabBarTheme = const TabBarThemeData(
    labelColor: Colors.blueAccent,
    unselectedLabelColor: Colors.grey,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    ),
  );

  static TabBarThemeData darkTabBarTheme = const TabBarThemeData(
    labelColor: Colors.blueAccent,
    unselectedLabelColor: Colors.white54,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    ),
  );
}
