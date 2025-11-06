class UsuarioModel {
  final int id;
  final String nombre;
  final String nombreUsuario;
  final String email;
  final String? fotoUrl;
  final int estrellas;
  final int nivelesCompletados;
  final List<LogroModel> logros;

  UsuarioModel({
    required this.id,
    required this.nombre,
    required this.nombreUsuario,
    required this.email,
    this.fotoUrl,
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
      fotoUrl: json['fotoUrl'],
      nivelesCompletados: json['nivelesCompletados'] ?? 0,
      logros: logrosList
          .map((logroJson) => LogroModel.fromJson(logroJson))
          .toList(),
    );
  }
  UsuarioModel copyWith({
    int? id,
    String? nombre,
    String? nombreUsuario,
    String? email,
    String? fotoUrl,
    int? estrellas,
    int? nivelesCompletados,
    List<LogroModel>? logros,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      nombreUsuario: nombreUsuario ?? this.nombreUsuario,
      email: email ?? this.email,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      estrellas: estrellas ?? this.estrellas,
      nivelesCompletados: nivelesCompletados ?? this.nivelesCompletados,
      logros: logros ?? this.logros,
    );
  }
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
