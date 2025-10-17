class UnidadData {
  final String titulo;
  final double etiquetaY;
  final List<NivelPosicion> posicionesNiveles;

  const UnidadData({
    required this.titulo,
    required this.etiquetaY,
    required this.posicionesNiveles,
  });
}

class NivelPosicion {
  final double xFactor;
  final double y;

  const NivelPosicion({required this.xFactor, required this.y});
}
