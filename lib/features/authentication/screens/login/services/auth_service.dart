import 'package:dio/dio.dart';
// Asegúrate de que la ruta a tu ApiClient sea correcta
import 'package:proyectomanu/utils/http/api_client.dart';
// Usaremos SharedPreferences para guardar el ID del usuario
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Obtenemos la instancia de Dio configurada desde nuestro ApiClient.
  static final Dio _dio = ApiClient.instance;

  /// Inicia sesión con email y contraseña.
  /// Devuelve el objeto de usuario si es exitoso.
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await _dio.post(
        "/usuarios/login",
        data: {"email": email, "password": password},
      );

      // GUARDAMOS EL ID DEL USUARIO PARA SIMULAR UNA SESIÓN
      if (response.data != null && response.data['usuario'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', response.data['usuario']['idUsuario']);
      }

      return response.data;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error de red o del servidor.';
      throw Exception(errorMessage);
    }
  }

  // ¡ATENCIÓN! Este método getProfile no funcionará porque tu API no tiene
  // un sistema de sesión (cookie o JWT) para saber quién es el usuario.
  // Lo dejaremos preparado para el futuro.
  static Future<Map<String, dynamic>> getProfile() async {
    // Por ahora, leeremos el ID guardado y pediremos ese usuario específico
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      throw Exception('No hay sesión iniciada.');
    }

    try {
      // Llamamos al endpoint que obtiene un usuario por ID
      final response = await _dio.get("/usuarios/$userId");
      return response.data;
    } on DioException catch (e) {
      throw Exception('Error al obtener el perfil: ${e.response?.statusCode}');
    }
  }

  /// Cierra la sesión (en este caso, solo borra el ID guardado).
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  /// Registra un nuevo usuario.
  static Future<Map<String, dynamic>> register({
    required String nombre,
    String? apellido,
    required String nombreUsuario,
    required String email,
    required String password,
    required String authProvider, // <-- PARÁMETRO AÑADIDO
  }) async {
    try {
      final response = await _dio.post(
        "/usuarios/register",
        data: {
          "nombre": nombre,
          "apellido": apellido,
          "nombreUsuario": nombreUsuario,
          "email": email,
          "password": password,
          "authProvider": authProvider, // <-- AÑADIDO AL CUERPO DE LA PETICIÓN
        },
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error al registrar usuario.';
      throw Exception(errorMessage);
    }
  }

  /// Solicita un correo para restablecer la contraseña.
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        "/usuarios/forgot-password",
        data: {"email": email},
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error al solicitar reseteo.';
      throw Exception(errorMessage);
    }
  }

  /// Restablece la contraseña usando un token y la nueva contraseña.
  static Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        "/usuarios/reset-password",
        data: {"token": token, "newPassword": newPassword},
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error al restablecer contraseña.';
      throw Exception(errorMessage);
    }
  }

  /// Reenvía el correo de verificación a un email dado.
  static Future<Map<String, dynamic>> resendVerificationEmail(
      String email) async {
    try {
      final response = await _dio.post(
        "/usuarios/resend-verification",
        data: {"email": email},
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error al reenviar el correo.';
      throw Exception(errorMessage);
    }
  }
}
