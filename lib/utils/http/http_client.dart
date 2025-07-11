import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrl = 'https://tu-api.com/api'; // cámbialo a tu base

  // GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Maneja todas las respuestas HTTP
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> decoded = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return decoded;
      case 400:
        throw Exception("Bad Request: ${decoded['message'] ?? response.body}");
      case 401:
        throw Exception("Unauthorized: ${decoded['message'] ?? response.body}");
      case 404:
        throw Exception("Not Found: ${decoded['message'] ?? response.body}");
      case 500:
        throw Exception("Server Error: ${decoded['message'] ?? response.body}");
      default:
        throw Exception(
          "Unknown Error: ${response.statusCode} ${decoded['message'] ?? response.body}",
        );
    }
  }
}
