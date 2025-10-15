import 'package:dio/dio.dart';
// Asegúrate de que las rutas a tus modelos y al ApiClient sean correctas
import 'package:proyectomanu/features/diccionario/models/categoria_glosario_model.dart';
import 'package:proyectomanu/features/diccionario/models/glosario_model.dart';
import 'package:proyectomanu/utils/http/api_client.dart';

class GlosarioService {
  static final Dio _dio = ApiClient.instance;

  static Future<List<CategoriaGlosario>> getCategorias() async {
    try {
      final response = await _dio.get("/CategoriasGlosario");

      final List<dynamic> data = response.data;
      return data.map((json) => CategoriaGlosario.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Error al cargar categorías: ${e.message}");
    }
  }

  static Future<List<GlosarioItem>> getGlosarioItems(
      {int? categoriaId, String? busqueda}) async {
    try {
      // Prepara los parámetros de la query
      final Map<String, dynamic> queryParameters = {};
      if (categoriaId != null) {
        queryParameters['categoriaId'] = categoriaId;
      }
      if (busqueda != null && busqueda.isNotEmpty) {
        queryParameters['busqueda'] = busqueda;
      }

      final response = await _dio.get(
        "/Glosario", // Ajusta el endpoint al de tu API
        queryParameters: queryParameters,
      );

      final List<dynamic> data = response.data;
      return data.map((json) => GlosarioItem.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Error al cargar items del glosario: ${e.message}");
    }
  }
}
