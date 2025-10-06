import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://10.0.2.2:5199/api";

  // ... (login y register sin cambios) ...
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/usuarios/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? "Error al iniciar sesión");
    }
  }

  static Future<Map<String, dynamic>> register({
    required String nombre,
    required String apellido,
    required String nombreUsuario,
    required String email,
    required String password,
    required String authProvider,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/usuarios/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nombre": nombre,
        "apellido": apellido,
        "nombreUsuario": nombreUsuario,
        "email": email,
        "password": password,
        "authProvider": authProvider,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? "Error al registrar usuario");
    }
  }

  // --- Método para solicitar el reseteo ---
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/usuarios/forgot-password"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? "Error al solicitar el reseteo");
    }
  }

  // --- Método para confirmar la nueva contraseña ---
  static Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/usuarios/reset-password"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "token": token,
        "newPassword": newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
          errorBody['message'] ?? "Error al restablecer la contraseña");
    }
  }

  // --- NUEVO MÉTODO: Reenviar correo de verificación ---
  static Future<Map<String, dynamic>> resendVerificationEmail(
      String email) async {
    // Nota: El endpoint "/resend-verification" es una suposición.
    // Ajústalo al que tengas en tu API.
    final response = await http.post(
      Uri.parse("$baseUrl/usuarios/resend-verification"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? "Error al reenviar el correo");
    }
  }
}
