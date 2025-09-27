import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/features/exito/screens/exito_nivel.dart';
import 'package:proyectomanu/features/home/widgets/camino_botones_estilo.dart';
import 'package:proyectomanu/features/niveles/controllers/nivelscreen.dart';
import 'package:proyectomanu/features/niveles/models/tipoejercicio.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class TCaminoScreen extends StatelessWidget {
  const TCaminoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final ejerciciosNivel1 = [
      Ejercicio(
        tipo: TipoEjercicio.lectura,
        data: {
          "titulo": "Bienvenido al nivel 1",
          "texto":
              "En este nivel aprenderás a reconocer la seña de la letra A.",
        },
      ),
      Ejercicio(
        tipo: TipoEjercicio.cuestionario,
        data: {
          "pregunta": "¿Qué letra es esta en LSM?",
          "imagenPath": TImages.google,
          "opciones": ["A", "B", "C"],
          "respuestaCorrecta": "A",
        },
      ),
      Ejercicio(
        tipo: TipoEjercicio.relacionar,
        data: {
          "imagenes": [TImages.facebook, TImages.google],
          "palabras": ["Facebook", "Google"],
          "respuestasCorrectas": {
            TImages.facebook: "Facebook",
            TImages.google: "Google",
          },
        },
      ),
      Ejercicio(
        tipo: TipoEjercicio.escritura,
        data: {
          "pregunta": "¿Qué seña representa esta imagen?",
          "imagenPath": TImages.facebook,
          "respuestaCorrecta": "A",
        },
      ),
    ];

    final levels = [
      {
        'level': 1,
        'x': screenWidth * 0.25,
        'y': 550.0,
        'stars': 0,
        'special': false,
        'screen': NivelScreen(ejercicios: ejerciciosNivel1),
      },
      {
        'level': 2,
        'x': screenWidth * 0.7,
        'y': 400.0,
        'stars': 0,
        'special': false,
        'screen': ExitoNivelLayout(
          mensaje: '¡Este es un nivel de demostración!',
          imagenPath: TImages.imagenperfil,
          estrellasGanadas: 1,
          onPressed: () => Get.back(),
        ),
      },
      {
        'level': 3,
        'x': screenWidth * 0.3,
        'y': 300.0,
        'stars': 0,
        'special': false,
        'screen': null,
      },
      {
        'level': 4,
        'x': screenWidth * 0.65,
        'y': 150.0,
        'stars': 0,
        'special': true,
        'screen': null,
      },
    ];

    return CaminoBotones(
      screenWidth: screenWidth,
      levels: levels,
      tituloUnidad: TTexts.unidad1,
    );
  }
}
