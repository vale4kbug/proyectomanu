import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class ApiClient {
  // 1. Llama a una función privada para crear y configurar la instancia.
  static final Dio instance = _createDio();

  // 2. Esta función se ejecuta UNA SOLA VEZ cuando la app se inicia.
  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://192.168.1.76:7285/api",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        // Ya no se necesita 'withCredentials' aquí.
      ),
    );

    // 3. Añadimos el gestor de cookies. Se encargará de guardar y enviar las cookies.
    dio.interceptors.add(CookieManager(CookieJar()));

    // 4. Añadimos la configuración para aceptar el certificado SSL de desarrollo.
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }
}
