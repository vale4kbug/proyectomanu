import 'package:flutter/material.dart';

class TSliderTheme {
  TSliderTheme._();

  static SliderThemeData lightSliderTheme = SliderThemeData(
    activeTrackColor: Colors.blueAccent,
    inactiveTrackColor: Colors.blueAccent.withOpacity(0.3),
    thumbColor: Colors.blueAccent,
    overlayColor: Colors.blueAccent.withOpacity(0.2),
    trackHeight: 4,
  );

  static SliderThemeData darkSliderTheme = SliderThemeData(
    activeTrackColor: Colors.blueAccent,
    inactiveTrackColor: Colors.blueAccent.withOpacity(0.5),
    thumbColor: Colors.blueAccent,
    overlayColor: Colors.blueAccent.withOpacity(0.3),
    trackHeight: 4,
  );
}
