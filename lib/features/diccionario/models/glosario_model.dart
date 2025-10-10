class GlosarioItem {
  final int idGlosario;
  final String nombre;
  final String? descripcion;
  final String? img;
  final int idCategoria;

  GlosarioItem({
    required this.idGlosario,
    required this.nombre,
    this.descripcion,
    this.img,
    required this.idCategoria,
  });

  // Convierte un JSON a un objeto GlosarioItem
  factory GlosarioItem.fromJson(Map<String, dynamic> json) {
    return GlosarioItem(
      idGlosario: json['idGlosario'], // Asegúrate que coincida con el JSON
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      img: json['img'],
      idCategoria: json['idCategoria'],
    );
  }
}
