import 'package:dio/dio.dart';
import 'package:proyectomanu/utils/http/api_client.dart';

class PracticaService {
  static final Dio _dio = ApiClient.instance;

  // Obtiene la lista para el menú de botones
  static Future<List<Map<String, dynamic>>> getMenuPracticas() async {
    try {
      final response = await _dio.get("/practicas");
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception("Error al cargar menú de prácticas");
    }
  }

  // Obtiene el contenido de una práctica específica
  static Future<Map<String, dynamic>> getPracticaDetalle(int id) async {
    try {
      final response = await _dio.get("/practicas/$id");
      return response.data;
    } catch (e) {
      throw Exception("Error al cargar contenido de la práctica");
    }
  }
}
