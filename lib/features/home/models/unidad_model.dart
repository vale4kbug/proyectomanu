import 'package:flutter/material.dart';

class UnidadData {
  final String categoriaId;
  final String titulo;
  final double
      etiquetaY; // (Ya no es estrictamente necesaria con el ListView, pero la dejamos)

  final Color colorPrimario;
  final Color colorSombra;

  const UnidadData({
    required this.categoriaId,
    required this.titulo,
    required this.etiquetaY,
    required this.colorPrimario,
    required this.colorSombra,
  });
}
