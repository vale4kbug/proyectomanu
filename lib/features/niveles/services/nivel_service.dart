import 'package:dio/dio.dart';
import 'package:proyectomanu/features/niveles/models/tipoejercicio.dart';
import 'package:proyectomanu/utils/http/api_client.dart';

class NivelService {
  static final Dio _dio = ApiClient.instance;
  static Future<List<Map<String, Object?>>> getCamino() async {
    try {
      final response = await _dio.get("/niveles/camino");
      List<dynamic> nivelesJson = response.data;
      return nivelesJson
          .map((nivel) => Map<String, Object?>.from(nivel))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al obtener niveles.');
    }
  }

  static Future<List<Ejercicio>> getEjercicios(int nivelId) async {
    try {
      final response = await _dio.get("/niveles/$nivelId/ejercicios");
      List<dynamic> ejerciciosJson = response.data;
      return ejerciciosJson.map((json) {
        TipoEjercicio tipo = TipoEjercicio.values.firstWhere(
          (e) => e.name == json['tipo'],
          orElse: () => TipoEjercicio.lectura,
        );
        return Ejercicio(
            tipo: tipo, data: Map<String, dynamic>.from(json['data']));
      }).toList();
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Error al cargar ejercicios.');
    }
  }
}
