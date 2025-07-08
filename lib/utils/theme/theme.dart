import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/theme/custom_themes/appbar_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/card_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/chip_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/dialog_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/floatingactionbutton.dart';
import 'package:proyectomanu/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/progressindicator_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/slider_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/snackbar_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/tabbar_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/text_theme.dart';
import 'package:proyectomanu/utils/theme/custom_themes/textfield_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    snackBarTheme: TSnackBarTheme.lightSnackBarTheme,
    cardTheme: TCardTheme.lightCardTheme,
    sliderTheme: TSliderTheme.lightSliderTheme,
    progressIndicatorTheme: TProgressIndicatorTheme.lightProgressIndicatorTheme,
    dialogTheme: TDialogTheme.lightDialogTheme,
    floatingActionButtonTheme:
        TFloatingActionButtonTheme.lightFloatingActionButtonTheme,
    tabBarTheme: TTabBarTheme.lightTabBarTheme,
    // los que ya tenías:
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
    brightness: Brightness.dark,
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.black,
    snackBarTheme: TSnackBarTheme.darkSnackBarTheme,
    cardTheme: TCardTheme.darkCardTheme,
    sliderTheme: TSliderTheme.darkSliderTheme,
    progressIndicatorTheme: TProgressIndicatorTheme.darkProgressIndicatorTheme,
    dialogTheme: TDialogTheme.darkDialogTheme,
    floatingActionButtonTheme:
        TFloatingActionButtonTheme.darkFloatingActionButtonTheme,
    tabBarTheme: TTabBarTheme.darkTabBarTheme,
    // los que ya tenías:
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
