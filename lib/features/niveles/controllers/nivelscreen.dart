import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/features/exito/screens/exito_nivel.dart';
import 'package:proyectomanu/features/niveles/models/tipoejercicio.dart';
import 'package:proyectomanu/features/niveles/screens/cuestionario.dart';
import 'package:proyectomanu/features/niveles/screens/relacionar_columnas.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelScreen extends StatefulWidget {
  const NivelScreen({super.key, required this.ejercicios});

  final List<Ejercicio> ejercicios;

  @override
  State<NivelScreen> createState() => _NivelScreenState();
}

class _NivelScreenState extends State<NivelScreen> {
  int _indiceActual = 0;
  int _puntaje = 0;

  void _siguiente({bool correcto = false}) {
    if (correcto) _puntaje++;

    if (_indiceActual < widget.ejercicios.length - 1) {
      setState(() => _indiceActual++);
    } else {
      final data = widget.ejercicios.first.data;
      Get.off(
        () => ExitoNivelLayout(
          mensaje: TTexts.obtenerMensajePorEstrellas(_puntaje),
          imagenPath: data["imagenPath"],
          estrellasGanadas: _puntaje,
          onPressed: () => Get.back(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ejercicio = widget.ejercicios[_indiceActual];

    switch (ejercicio.tipo) {
      case TipoEjercicio.cuestionario:
        return NivelCuestionarioScreen(
          key: ValueKey(_indiceActual),
          pregunta: ejercicio.data["pregunta"],
          imagenPath: ejercicio.data["imagenPath"],
          opciones: List<String>.from(ejercicio.data["opciones"]),
          respuestaCorrecta: ejercicio.data["respuestaCorrecta"],
          onNext: (correcto) => _siguiente(correcto: correcto),
        );
      case TipoEjercicio.relacionar:
        return NivelRelacionScreen(
          key: ValueKey(_indiceActual),
          imagenes: List<String>.from(ejercicio.data["imagenes"]),
          palabras: List<String>.from(ejercicio.data["palabras"]),
          respuestasCorrectas:
              Map<String, String>.from(ejercicio.data["respuestasCorrectas"]),
          onNext: (correcto) => _siguiente(correcto: correcto),
        );
      case TipoEjercicio.finalizacion:
        return ExitoNivelLayout(
          mensaje: TTexts.nivelCompleto,
          imagenPath: ejercicio.data["imagenPath"],
          estrellasGanadas: _puntaje,
          onPressed: () => Get.back(),
        );

      default:
        return Scaffold(
          body: Center(
            child: Text("Error 0-o"),
          ),
        );
    }
  }
}
