import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:proyectomanu/features/authentication/screens/login/login.dart';
import 'package:proyectomanu/features/authentication/screens/onBoarding/onboarding.dart';
import 'package:proyectomanu/utils/theme/theme.dart';

class App extends StatelessWidget {
  final bool showOnboarding;

  const App({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: showOnboarding ? const OnBoardingScreen() : const LoginScreen(),
    );
  }
}
