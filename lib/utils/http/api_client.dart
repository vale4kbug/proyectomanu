import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://10.0.2.2:7285/api",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  static bool _isInitialized = false;

  static Dio get instance {
    // Solo configura el cliente la primera vez que se llama
    if (!_isInitialized) {
      print("--- CONFIGURANDO DIO CLIENT POR PRIMERA VEZ ---");

      // Configuración del gestor de cookies
      _dio.interceptors.add(CookieManager(CookieJar()));

      // Configuración para aceptar certificados de desarrollo
      if (_dio.httpClientAdapter is IOHttpClientAdapter) {
        (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
          print("--- Creando HttpClient con badCertificateCallback ---");
          final client = HttpClient();
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) =>
                  true; // Acepta todos
          return client;
        };
      }
      _isInitialized = true;
    }
    return _dio;
  }
}
