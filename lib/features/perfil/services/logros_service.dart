import 'package:dio/dio.dart';
import 'package:proyectomanu/utils/http/api_client.dart';

class LogrosService {
  static final Dio _dio = ApiClient.instance;

  static Future<List<dynamic>> obtenerLogrosUsuario() async {
    try {
      final response = await _dio.get("/logros/usuario");
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al obtener logros');
    }
  }
}
