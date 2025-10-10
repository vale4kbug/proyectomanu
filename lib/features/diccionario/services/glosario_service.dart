import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyectomanu/features/diccionario/models/categoria_glosario_model.dart';
import 'package:proyectomanu/features/diccionario/models/glosario_model.dart';

class GlosarioService {
  static const String baseUrl = "http://10.0.2.2:5199/api"; // Tu IP local

  static Future<List<CategoriaGlosario>> getCategorias() async {
    final response = await http.get(Uri.parse("$baseUrl/glosario/categorias"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CategoriaGlosario.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar categorías");
    }
  }

  static Future<List<GlosarioItem>> getGlosarioItems(
      {int? categoriaId, String? busqueda}) async {
    // Construye la URL base
    var uri = Uri.parse("$baseUrl/glosario");

    // Prepara los parámetros de la query
    final Map<String, String> queryParameters = {};
    if (categoriaId != null) {
      queryParameters['categoriaId'] = categoriaId.toString();
    }
    if (busqueda != null && busqueda.isNotEmpty) {
      queryParameters['busqueda'] = busqueda;
    }

    // Añade los parámetros a la URI si existen
    if (queryParameters.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParameters);
    }

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => GlosarioItem.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar items del glosario");
    }
  }
}
