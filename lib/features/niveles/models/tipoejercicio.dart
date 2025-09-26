enum TipoEjercicio {
  presentacion,
  cuestionario,
  relacionar,
  escribir,
  camara,
  finalizacion
}

class Ejercicio {
  final TipoEjercicio tipo;
  final Map<String, dynamic> data;

  Ejercicio({required this.tipo, required this.data});
}
