import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:proyectomanu/app.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyectomanu/utils/notifications/notification_controller.dart'; // Importa tu nuevo controlador

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inicializar Notificaciones
  await NotificationController.initializeLocalNotifications();

  // 2. Solicitar permisos básicos si no se tienen
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // 3. Iniciar Listeners (Importante para acciones en segundo plano)
  await NotificationController.startListeningNotificationEvents();

  // Inicia GetX
  Get.put(UserController());

  // Verificar onboarding
  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(App(
    showOnboarding: !hasSeenOnboarding,
  ));
}
