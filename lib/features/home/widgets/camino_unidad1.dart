import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/exito/screens/exito_nivel.dart';
import 'package:proyectomanu/features/home/widgets/boton_camino.dart';
import 'package:proyectomanu/features/home/widgets/etiqueta_camino.dart';
import 'package:proyectomanu/features/niveles/controllers/nivelscreen.dart';
import 'package:proyectomanu/features/niveles/models/tipoejercicio.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';

class TCaminoScreen extends StatelessWidget {
  const TCaminoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    /// 🔹 Nivel 1: 2 preguntas + finalización
    final ejerciciosNivel1 = [
      Ejercicio(
        tipo: TipoEjercicio.cuestionario,
        data: {
          "pregunta": "¿Qué letra es esta en LSM?",
          "imagenPath": TImages.facebook,
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
        tipo: TipoEjercicio.cuestionario,
        data: {
          "pregunta": "¿Cuál es la letra B?",
          "imagenPath": TImages.google,
          "opciones": ["A", "B", "C"],
          "respuestaCorrecta": "B",
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

    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          height: 700,
          width: screenWidth,
          child: Stack(
            children: [
              ...levels.map((level) {
                return Positioned(
                  left: (level['x'] as double) - 40,
                  top: (level['y'] as double) - 40,
                  child: TBotonCamino(
                    stars: level['stars'] as int,
                    colorbajoboton: level['special'] == true
                        ? TColors.teciaryColor
                        : TColors.primaryColor,
                    colorarribaboton: level['special'] == true
                        ? TColors.superBoton
                        : TColors.primarioBoton,
                    onPressed: level['screen'] != null
                        ? () {
                            Get.to(() => level['screen'] as Widget);
                          }
                        : null,
                    child: level['special'] == true
                        ? const Icon(
                            Iconsax.star,
                            color: Color.fromARGB(255, 255, 186, 58),
                            size: 60,
                          )
                        : Text(
                            "${level['level']}",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 243, 204),
                            ),
                          ),
                  ),
                );
              }),
              const Positioned(
                top: 650,
                left: 0,
                right: 0,
                child: Center(
                  child: TUnidadEtiqueta(titulo: "Unidad 1: Dactilología"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
