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
      final errorMessage =
          e.response?.data['message'] ?? 'Error al obtener niveles.';
      throw Exception(errorMessage);
    }
  }

  static Future<List<Ejercicio>> getEjercicios(int nivelId) async {
    try {
      final response = await _dio.get("/niveles/$nivelId/ejercicios");
      List<dynamic> ejerciciosJson = response.data;

      return ejerciciosJson.map((json) {
        // Convierte el 'tipo' de String a tu Enum
        TipoEjercicio tipo = TipoEjercicio.values.firstWhere(
          (e) => e.name == json['tipo'],
          orElse: () => TipoEjercicio.lectura, // Valor por defecto
        );

        return Ejercicio(
          tipo: tipo,
          data: Map<String, dynamic>.from(json['data']),
        );
      }).toList();
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Error al cargar ejercicios.';
      throw Exception(errorMessage);
    }
  }

  static Future<void> finalizarNivel(int nivelId, int puntaje) async {
    try {
      await _dio.post(
        "/niveles/finalizar",
        data: {
          "nivelId": nivelId,
          "puntaje": puntaje,
        },
      );
    } catch (e) {
      print("No se pudo guardar el progreso del nivel: $e");
    }
  }
}
