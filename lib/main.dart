import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/app.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';

void main() {
  Get.put(UserController());

  runApp(const App());
}
