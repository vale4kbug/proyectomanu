import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

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
    tz_data.initializeTimeZones();
    _loadPreferences();
  }

  /// Carga preferencias
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _general = prefs.getBool('notif_general') ?? true;
      _recordatorios = prefs.getBool('notif_recordatorios') ?? true;
      _logros = prefs.getBool('notif_logros') ?? true;
    });

    if (_recordatorios) {
      _programarRecordatorioCadaTresDias();
    }
  }

  /// Guarda preferencia
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
      'Así se verán tus notificaciones en Manolingo 🎉',
    );
  }

  ///  cada 3 dias
  Future<void> _programarRecordatorioCadaTresDias() async {
    final now = tz.TZDateTime.now(tz.local);
    final proximo = now.add(const Duration(days: 3));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 101,
        channelKey: 'reminder_channel',
        title: '🧠 Recordatorio de práctica',
        body: '¡Han pasado 3 días sin practicar tu lenguaje de señas! 👋',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: proximo.year,
        month: proximo.month,
        day: proximo.day,
        hour: 10,
        minute: 0,
        timeZone: tz.local.name,
        repeats: true,
      ),
    );
  }

  Future<void> _cancelarRecordatorios() async {
    await AwesomeNotifications().cancel(101);
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
              SwitchListTile(
                title: Text(TTexts.configNotificacionesGen),
                subtitle: Text(TTexts.configNotificacionesAlertas),
                activeColor: TColors.primarioBoton,
                inactiveThumbColor: TColors.intermediofuerteAzul,
                value: _general,
                onChanged: (value) {
                  setState(() => _general = value);
                  _savePreference('notif_general', value);
                  if (value) {
                    _mostrarNotificacion(
                        'general_channel',
                        'Notificaciones activadas',
                        'Recibirás alertas importantes.');
                  }
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SwitchListTile(
                title: Text(TTexts.configNotificacionesReminder),
                subtitle: Text(TTexts.configNotificacionesReminderSub),
                activeColor: TColors.primarioBoton,
                inactiveThumbColor: TColors.intermediofuerteAzul,
                value: _recordatorios,
                onChanged: (value) async {
                  setState(() => _recordatorios = value);
                  _savePreference('notif_recordatorios', value);
                  if (value) {
                    _mostrarNotificacion(
                        'reminder_channel',
                        'Recordatorios activados',
                        'Recibirás recordatorios cada 3 días.');
                    await _programarRecordatorioCadaTresDias();
                  } else {
                    await _cancelarRecordatorios();
                    _mostrarNotificacion(
                        'reminder_channel',
                        'Recordatorios desactivados',
                        'Ya no recibirás recordatorios.');
                  }
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SwitchListTile(
                title: Text(TTexts.configNotificacionesLogro),
                subtitle: Text(TTexts.configNotificacionesLogroSub),
                activeColor: TColors.primarioBoton,
                inactiveThumbColor: TColors.intermediofuerteAzul,
                value: _logros,
                onChanged: (value) {
                  setState(() => _logros = value);
                  _savePreference('notif_logros', value);
                  if (value) {
                    _mostrarNotificacion('achievement_channel', '¡Felicidades!',
                        'Se mostrarán tus próximos logros 🏆');
                  }
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
