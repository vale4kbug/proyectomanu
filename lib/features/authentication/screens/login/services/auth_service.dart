import 'package:dio/dio.dart';
// Asegúrate de que la ruta a tu ApiClient sea correcta
import 'package:proyectomanu/utils/http/api_client.dart';

class AuthService {
  // ¡Correcto! Usamos la instancia de Dio que maneja las cookies.
  static final Dio _dio = ApiClient.instance;

  /// Inicia sesión con email y contraseña.
  /// (El CookieManager de Dio guardará la cookie automáticamente)
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await _dio.post(
        "/usuarios/login",
        data: {"email": email, "password": password},
      );

      // Ya no necesitamos SharedPreferences. La cookie es suficiente.
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error de red o del servidor.';
      throw Exception(errorMessage);
    }
  }

  /// ¡CORREGIDO! Obtiene el perfil del usuario usando la cookie de sesión.
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      // Llamamos al endpoint [Authorize] que usa la cookie.
      final response = await _dio.get("/usuarios/perfil");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Si la API devuelve 401 (no autorizado), lanzamos este error.
        throw Exception("No hay sesión iniciada o la sesión expiró.");
      }
      final errorMessage =
          e.response?.data['message'] ?? 'Error al cargar el perfil.';
      throw Exception(errorMessage);
    }
  }

  /// Cierra la sesión (borra la cookie en el backend y en la app).
  static Future<void> logout() async {
    try {
      // Llama al endpoint de logout de tu API
      await _dio.post("/usuarios/logout");
    } catch (e) {
      print("Error al hacer logout (backend): $e");
    }

    // Ya no necesitamos SharedPreferences. El CookieManager se encarga.
  }

  /// Registra un nuevo usuario. (Tu código estaba bien)
  static Future<Map<String, dynamic>> register({
    required String nombre,
    String? apellido,
    required String nombreUsuario,
    required String email,
    required String password,
    required String authProvider,
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
          "authProvider": authProvider,
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
