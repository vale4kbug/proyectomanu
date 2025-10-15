import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/features/authentication/screens/login/login.dart';
import 'package:proyectomanu/features/authentication/screens/login/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId != null) {
      try {
        // Llama a la versión adaptada de getProfile
        final usuarioData = await AuthService.getProfile();
        usuario.value = UsuarioModel.fromJson(usuarioData);
      } catch (e) {
        print("Auto-login fallido: $e");
        await logout(); // Limpia la sesión si hay un error
      }
    }
    isLoading.value = false;
  }

  Future<void> login(String email, String password) async {
    try {
      // AuthService.login ahora guarda el ID del usuario
      await AuthService.login(email, password);
      // Después del login, carga el perfil
      await intentarAutoLogin();

      // Solo navega si la carga del perfil fue exitosa
      if (usuario.value != null) {
        Get.offAll(() => const NavigationMenu());
      } else {
        throw Exception(
            "No se pudo cargar el perfil del usuario después del login.");
      }
    } catch (e) {
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
}
