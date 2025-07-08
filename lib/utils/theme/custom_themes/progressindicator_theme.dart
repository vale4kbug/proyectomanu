import 'package:flutter/material.dart';

class TProgressIndicatorTheme {
  TProgressIndicatorTheme._();

  static ProgressIndicatorThemeData lightProgressIndicatorTheme =
      const ProgressIndicatorThemeData(
        color: Colors.blueAccent,
        linearTrackColor: Colors.blueGrey,
        circularTrackColor: Colors.blueGrey,
      );

  static ProgressIndicatorThemeData darkProgressIndicatorTheme =
      const ProgressIndicatorThemeData(
        color: Colors.blueAccent,
        linearTrackColor: Colors.grey,
        circularTrackColor: Colors.grey,
      );
}
