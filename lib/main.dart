import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:proyectomanu/app.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().initialize(
    'resource://drawable/ic_noti',
    [
      NotificationChannel(
        channelKey: 'general_channel',
        channelName: 'Notificaciones Generales',
        channelDescription: 'Alertas generales de la app',
        defaultColor: const Color(0xFF77BAFF),
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'reminder_channel',
        channelName: 'Recordatorios',
        channelDescription: 'Recordatorios periódicos de práctica',
        defaultColor: Colors.blueAccent,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: 'achievement_channel',
        channelName: 'Logros',
        channelDescription: 'Notificaciones de logros alcanzados',
        defaultColor: Colors.green,
        importance: NotificationImportance.High,
      ),
    ],
  );

  // solicita permiso
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Inicia GetX
  Get.put(UserController());

  // Verificar si ya vio el onboarding
  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  runApp(App(
    showOnboarding: !hasSeenOnboarding,
  ));
}
