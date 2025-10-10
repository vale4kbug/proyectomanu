class CategoriaGlosario {
  final int idCategoria;
  final String nombre;
  final String? img;

  CategoriaGlosario(
      {required this.idCategoria, required this.nombre, this.img});

  // Convierte un JSON (texto de la API) a un objeto CategoriaGlosario
  factory CategoriaGlosario.fromJson(Map<String, dynamic> json) {
    return CategoriaGlosario(
      idCategoria:
          json['idCategoria'], // Asegúrate que coincida con el JSON de tu API
      nombre: json['nombre'],
      img: json['img'],
    );
  }
}
