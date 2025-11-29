import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

class NotificationController {
  static const int _idRecordatorio = 101;

  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/ic_noti',
      [
        NotificationChannel(
          channelKey: 'general_channel',
          channelName: 'Notificaciones Generales',
          channelDescription: 'Alertas generales de la app',
          defaultColor: TColors.primarioBoton,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
        NotificationChannel(
          channelKey: 'reminder_channel',
          channelName: 'Recordatorios',
          channelDescription: 'Recordatorios de práctica',
          defaultColor: Colors.blueAccent,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
        NotificationChannel(
          channelKey: 'achievement_channel',
          channelName: 'Logros',
          channelDescription: 'Notificaciones de logros',
          defaultColor: Colors.green,
          importance: NotificationImportance.High,
        ),
      ],
      debug: true,
    );
  }

  /// Configura los listeners para cuando se toca una notificación
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  /// Método que se ejecuta cuando tocas la notificación
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Aquí puedes poner lógica de navegación, ej: Ir a la pantalla de práctica
    print("El usuario tocó la notificación: ${receivedAction.title}");
  }

  /// 📅 Programar recordatorio cada 3 días
  static Future<void> scheduleReminder() async {
    // Usamos la hora local del dispositivo
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _idRecordatorio,
        channelKey: 'reminder_channel',
        title: '🧠 Recordatorio de práctica',
        body: '¡Han pasado 3 días sin practicar! No pierdas tu racha 👋',
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      // Usamos NotificationInterval para repetir cada X segundos
      // 3 días = 259200 segundos
      // Para pruebas, usa 60 segundos (1 minuto) y verifica que funcione.
      schedule: NotificationInterval(
        interval: const Duration(
            seconds:
                259200), // O mejor aún: const Duration(days: 3)        timeZone: localTimeZone,
        repeats: true,
        allowWhileIdle: true,
        preciseAlarm: true, // Requiere permiso en Android 12+
      ),
    );
    print("Recordatorio programado para cada 3 días.");
  }

  static Future<void> showAchievementNotification(String nombreLogro) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'achievement_channel',
        title: '🏆 ¡Logro Desbloqueado!',
        body: 'Has conseguido: ${nombreLogro} @( o･ω･)@/🎉',
      ),
    );
  }

  /// 📢 Notificación General (Nuevo Nivel / Contenido)
  static Future<void> showNewLevelNotification(int nivelId) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'general_channel', // Usa el canal azul
        title: '¡Nivel Desbloqueado! 🔓',
        body: 'El nivel ${nivelId} ya está disponible. ¡@(* ᗢ *)@"!',
      ),
    );
  }

  /// 🚫 Cancelar recordatorio
  static Future<void> cancelReminder() async {
    await AwesomeNotifications().cancel(_idRecordatorio);
    print("Recordatorio cancelado.");
  }

  /// 🔔 Mostrar notificación instantánea (Prueba o Toggle)
  static Future<void> showInstantNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'general_channel',
        title: title,
        body: body,
      ),
    );
  }
}
