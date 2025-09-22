import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();
  static const String _fontFamily =
      'Bunny'; // ← Nombre definido en pubspec.yaml
  static const String _fontFamily2 =
      'Monse'; // ← Nombre definido en pubspec.yaml

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontFamily: _fontFamily,
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: const Color(0Xff0d4cd8),
    ),
    headlineMedium: const TextStyle().copyWith(
      fontFamily: _fontFamily,
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: const Color(0Xff0d4cd8),
    ),
    headlineSmall: const TextStyle().copyWith(
      fontFamily: _fontFamily,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: const Color(0Xff0d4cd8),
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w600,
      color: const Color(0Xff0d4cd8),
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16.0,
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w500,
      color: const Color(0Xff0d4cd8),
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16.0,
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w400,
      color: const Color(0Xff0d4cd8),
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.w500,
      color: const Color(0Xff0d4cd8),
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.normal,
      color: const Color(0Xff0d4cd8),
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.w500,
      color: const Color.fromARGB(172, 13, 77, 216),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.normal,
      color: const Color(0Xff0d4cd8),
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: 12.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.normal,
      color: const Color.fromARGB(172, 13, 77, 216),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      fontFamily: _fontFamily,
      color: Colors.white,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      fontFamily: _fontFamily,
      color: Colors.white,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      fontFamily: _fontFamily,
      color: Colors.white,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      fontFamily: _fontFamily,
      color: Colors.white,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      fontFamily: _fontFamily,
      color: Colors.white,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontFamily: _fontFamily,
      color: Colors.white,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.w500,
      color: Colors.white.withOpacity(0.5),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: 12.0,
      fontFamily: _fontFamily2,
      fontWeight: FontWeight.normal,
      color: Colors.white.withOpacity(0.5),
    ),
  );
}
