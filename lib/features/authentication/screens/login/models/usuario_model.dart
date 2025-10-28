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

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    var logrosList = json['logros'] as List<dynamic>? ?? [];

    return UsuarioModel(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      nombreUsuario: json['nombreUsuario'] ?? '',
      email: json['email'] ?? '',
      estrellas: json['estrellas'] ?? 0,
      nivelesCompletados: json['nivelesCompletados'] ?? 0,
      logros: logrosList
          .map((logroJson) => LogroModel.fromJson(logroJson))
          .toList(),
    );
  }

  get fotoUrl => null;
}

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
