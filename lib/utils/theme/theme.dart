import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/theme/custom_themes/appbar_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/chip_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/text_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/textfield_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Bunny',
    brightness: Brightness.light,
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Bunny',
    brightness: Brightness.dark,
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.black,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
