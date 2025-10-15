// lib/features/authentication/screens/login/models/usuario_model.dart

// Este modelo representa a un solo usuario con sus estadísticas y logros.
class UsuarioModel {
  final int id;
  final String nombre;
  final String nombreUsuario;
  final String email;
  final int estrellas;
  final int nivelesCompletados;
  final List<LogroModel> logros;

  UsuarioModel({
    required this.id,
    required this.nombre,
    required this.nombreUsuario,
    required this.email,
    this.estrellas = 0,
    this.nivelesCompletados = 0,
    this.logros = const [],
  });

  /// Factory constructor para crear una instancia de UsuarioModel desde un mapa JSON.
  /// Este es el método que usa tu UserController.
  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    // Maneja el caso de que 'estadisticas' o 'logros' puedan ser nulos en la respuesta de la API.
    var estadisticas = json['estadisticas'] as Map<String, dynamic>? ?? {};
    var logrosList = json['logros'] as List<dynamic>? ?? [];

    return UsuarioModel(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      nombreUsuario: json['nombreUsuario'] ?? '',
      email: json['email'] ?? '',
      estrellas: estadisticas['estrellas'] ?? 0,
      nivelesCompletados: estadisticas['nivelesCompletados'] ?? 0,
      logros: logrosList
          .map((logroJson) => LogroModel.fromJson(logroJson))
          .toList(),
    );
  }
}

// Este modelo representa un único logro, ya sea bloqueado o desbloqueado.
class LogroModel {
  final int id;
  final String titulo;
  final String? descripcion;
  final String? imagen;
  final bool desbloqueado;

  LogroModel({
    required this.id,
    required this.titulo,
    this.descripcion,
    this.imagen,
    required this.desbloqueado,
  });

  /// Factory constructor para crear una instancia de LogroModel desde un mapa JSON.
  factory LogroModel.fromJson(Map<String, dynamic> json) {
    return LogroModel(
      id: json['id'] ?? 0,
      titulo: json['titulo'] ?? 'Sin Título',
      descripcion: json['descripcion'],
      imagen: json['imagen'],
      desbloqueado: json['desbloqueado'] ?? false,
    );
  }
}
