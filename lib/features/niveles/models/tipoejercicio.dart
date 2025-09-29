enum TipoEjercicio {
  presentacion,
  cuestionario, //
  relacionar, //
  opcionmultiple,
  camara, //falta
  escritura, //
  lectura, //
  historia, //
  finalizacion, //
}

class Ejercicio {
  final TipoEjercicio tipo;
  final Map<String, dynamic> data;

  Ejercicio({required this.tipo, required this.data});
}
