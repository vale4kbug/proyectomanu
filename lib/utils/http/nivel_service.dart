import 'package:dio/dio.dart';
import 'package:proyectomanu/features/niveles/models/tipoejercicio.dart';
import 'package:proyectomanu/utils/http/api_client.dart';

class NivelService {
  static final Dio _dio = ApiClient.instance;

  static Future<List<Map<String, Object?>>> getCamino(String categoria) async {
    try {
      final response = await _dio.get("/niveles/camino");
      List<dynamic> nivelesJson = response.data;
      return nivelesJson
          .map((nivel) => Map<String, Object?>.from(nivel))
          .toList();
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ??
          'Error al obtener el camino de niveles.';
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
  static Future<void> finalizarNivel(int nivelId, int puntaje) async {
    try {
      final data = {"nivelId": nivelId, "puntaje": puntaje};
      print("DEBUG: Enviando POST /niveles/finalizar -> $data");
      final response = await _dio.post("/niveles/finalizar", data: data);
      print(
          "DEBUG: Response finalizarNivel status=${response.statusCode} data=${response.data}");
    } catch (e, st) {
      print("ERROR: No se pudo guardar el progreso del nivel: $e\n$st");
      rethrow;
    }
  }
}
