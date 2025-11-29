import 'package:dio/dio.dart';
import 'package:proyectomanu/features/niveles/models/tipoejercicio.dart';
import 'package:proyectomanu/utils/http/api_client.dart';

class NivelService {
  static final Dio _dio = ApiClient.instance;

  static Future<List<Map<String, Object?>>> getCaminoCompleto() async {
    try {
      // Llamamos al endpoint que devuelve TODO el mapa ordenado
      final response = await _dio.get("/niveles/camino_completo");

      List<dynamic> nivelesJson = response.data;
      return nivelesJson
          .map((nivel) => Map<String, Object?>.from(nivel))
          .toList();
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error al obtener el mapa completo.';
      throw Exception(errorMessage);
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
          tipo: tipo,
          data: Map<String, dynamic>.from(json['data']),
        );
      }).toList();
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error al cargar los ejercicios.';
      throw Exception(errorMessage);
    }
  }

  ///  para guardar el progreso cuando un nivel se completa
// Cambiamos void por Map<String, dynamic> para devolver los datos
  static Future<Map<String, dynamic>> finalizarNivel(
      int nivelId, int puntaje) async {
    try {
      final response = await _dio.post(
        "/niveles/finalizar",
        data: {
          "nivelId": nivelId,
          "puntaje": puntaje,
        },
      );

      // Devolvemos la data (que incluye 'nuevoNivel' y 'logrosObtenidos')
      return response.data;
    } catch (e) {
      print("No se pudo guardar el progreso del nivel: $e");
      throw Exception("Error al guardar progreso");
    }
  }
}
