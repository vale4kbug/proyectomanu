import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/utils/http/nivel_service.dart';
import 'package:proyectomanu/utils/notifications/notification_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NivelController extends GetxController {
  Future<void> finalizarNivel(int nivelId, int puntaje) async {
    try {
      final result = await NivelService.finalizarNivel(nivelId, puntaje);

      final prefs = await SharedPreferences.getInstance();
      final notifLogrosActivas = prefs.getBool('notif_logros') ?? true;

      // --- Notificación de nuevo nivel ---
      if (result['nivelDesbloqueado'] == true && result['nuevoNivel'] != null) {
        print("DEBUG: ¡Nuevo nivel desbloqueado! Enviando notificación.");
        NotificationController.showNewLevelNotification(result['nuevoNivel']);
      } else {
        print("DEBUG: Nivel completado, pero no hubo desbloqueo nuevo.");
      }

      // --- Notificación de logros desbloqueados ---
      if (notifLogrosActivas && result["logrosObtenidos"] != null) {
        print("DEBUG logrosObtenidos: ${result["logrosObtenidos"]}");

        for (final logro in result["logrosObtenidos"]) {
          if (logro != null && logro.toString().trim().isNotEmpty) {
            print("Enviando notificación de logro: $logro");
            NotificationController.showAchievementNotification(logro);
          }
        }
      }

      // --- Recargar usuario ---
      final userController = Get.find<UserController>();
      await userController.recargarUsuario();
    } catch (e) {
      print("ERROR en NivelController.finalizarNivel: $e");
      rethrow;
    }
  }
}
