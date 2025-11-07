import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/features/authentication/screens/login/login.dart';
import 'package:proyectomanu/features/authentication/screens/login/models/usuario_model.dart';

import 'package:proyectomanu/features/authentication/screens/login/services/auth_service.dart';
import 'package:proyectomanu/navigation_menu.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final Rx<UsuarioModel?> usuario = Rx<UsuarioModel?>(null);
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    intentarAutoLogin();
  }

  Future<void> intentarAutoLogin() async {
    isLoading.value = true;
    try {
      final usuarioData = await AuthService.getProfile();
      usuario.value = UsuarioModel.fromJson(usuarioData);
    } catch (e) {
      // Esto es normal si no hay una sesión guardada.
      print("No hay sesión de auto-login: $e");
      usuario.value = null;
    }
    // Finalmente, quitamos la carga (incluso si falló)
    isLoading.value = false;
  }

  Future<void> login(String email, String password) async {
    try {
      print("1. [DEBUG] Iniciando login...");
      await AuthService.login(email, password);
      print("2. [DEBUG] Login (cookie) exitoso. Pidiendo perfil...");

      final usuarioData = await AuthService.getProfile();

      // --- ¡ESTA ES LA LÍNEA MÁS IMPORTANTE! ---
      print("3. [DEBUG] Datos del perfil recibidos: $usuarioData");

      if (usuarioData == null) {
        print("ERROR: AuthService.getProfile() devolvió null.");
        throw Exception("Los datos del perfil llegaron vacíos.");
      }

      usuario.value = UsuarioModel.fromJson(usuarioData);
      print(
          "4. [DEBUG] Modelo de usuario creado: ${usuario.value?.nombreUsuario}");

      Get.offAll(() => const NavigationMenu());
      print("5. [DEBUG] Navegando a NavigationMenu...");
    } catch (e) {
      // --- TAMBIÉN MUY IMPORTANTE ---
      print("ERROR [DEBUG]: La ejecución falló. Causa: $e");
      Get.snackbar(
          'Error de Login', e.toString().replaceFirst("Exception: ", ""),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    usuario.value = null;
    Get.offAll(() => const LoginScreen());
  }

  Future<void> recargarUsuario() async {
    try {
      isLoading.value = true;
      print("DEBUG: Recargando perfil del usuario...");
      final usuarioData = await AuthService.getProfile();
      usuario.value = UsuarioModel.fromJson(usuarioData);
      print("DEBUG: Perfil recargado correctamente.");
    } catch (e) {
      print("ERROR al recargar usuario: $e");
      Get.snackbar(
        'Error',
        'No se pudo actualizar el perfil.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
