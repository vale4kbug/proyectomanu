import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
// Importa el controlador
import 'package:proyectomanu/utils/notifications/notification_controller.dart';

class ConfiguracionNotificacionesScreen extends StatefulWidget {
  const ConfiguracionNotificacionesScreen({super.key});

  @override
  State<ConfiguracionNotificacionesScreen> createState() =>
      _ConfiguracionNotificacionesScreenState();
}

class _ConfiguracionNotificacionesScreenState
    extends State<ConfiguracionNotificacionesScreen> {
  bool _general = true;
  bool _recordatorios = true;
  bool _logros = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _general = prefs.getBool('notif_general') ?? true;
      _recordatorios = prefs.getBool('notif_recordatorios') ?? true;
      _logros = prefs.getBool('notif_logros') ?? true;
    });

    // Aseguramos consistencia al cargar la pantalla
    if (_recordatorios) {
      NotificationController.scheduleReminder();
    }
  }

  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  /// 🔔 Crea notificación instantánea
  void _mostrarNotificacion(String canal, String titulo, String cuerpo) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: canal,
        title: titulo,
        body: cuerpo,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  void _mostrarNotificacionPrueba() {
    _mostrarNotificacion(
      'general_channel',
      '🔔 Notificación de prueba',
      'Así se verán tus notificaciones en Manolingo @(* ᗢ *)@/',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text(TTexts.configNotificacionesTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(title: TTexts.configNotificacionesSubTitle),
              const Divider(),

              // --- Switch General ---
              SwitchListTile(
                title: Text(TTexts.configNotificacionesGen),
                subtitle: Text(TTexts.configNotificacionesAlertas),
                activeColor: TColors.primarioBoton,
                value: _general,
                onChanged: (value) {
                  setState(() => _general = value);
                  _savePreference('notif_general', value);
                  if (value) {
                    NotificationController.showInstantNotification(
                        'Notificaciones activadas',
                        'Recibirás alertas importantes.');
                  }
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // --- Switch Recordatorios (AQUÍ ESTÁ LA CLAVE) ---
              SwitchListTile(
                title: Text(TTexts.configNotificacionesReminder),
                subtitle: Text(TTexts.configNotificacionesReminderSub),
                activeColor: TColors.primarioBoton,
                value: _recordatorios,
                onChanged: (value) async {
                  setState(() => _recordatorios = value);
                  _savePreference('notif_recordatorios', value);

                  if (value) {
                    // 1. Si activa, programamos
                    await NotificationController.scheduleReminder();
                    NotificationController.showInstantNotification(
                        'Recordatorios activados',
                        'Te avisaremos cada 3 días.');
                  } else {
                    // 2. Si desactiva, cancelamos
                    await NotificationController.cancelReminder();
                  }
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // --- Switch Logros ---
              SwitchListTile(
                title: Text(TTexts.configNotificacionesLogro),
                subtitle: Text(TTexts.configNotificacionesLogroSub),
                activeColor: TColors.primarioBoton,
                value: _logros,
                onChanged: (value) {
                  setState(() => _logros = value);
                  _savePreference('notif_logros', value);
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const SizedBox(height: TSizes.spaceBtwSections * 1.5),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primarioBoton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onPressed: _mostrarNotificacionPrueba,
                  icon: const Icon(Icons.notifications_active_outlined),
                  label: const Text('Probar notificación'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2),
            ],
          ),
        ),
      ),
    );
  }
}
