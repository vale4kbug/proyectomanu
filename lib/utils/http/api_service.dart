import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000/api";

  static Future<List<dynamic>> getUsuarios() async {
    final response = await http.get(Uri.parse("$baseUrl/usuarios"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al obtener usuarios");
    }
  }
}
