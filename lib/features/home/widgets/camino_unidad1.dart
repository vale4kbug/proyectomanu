import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/exito/screens/exito_nivel.dart';
import 'package:proyectomanu/features/home/widgets/boton_camino.dart';
import 'package:proyectomanu/features/home/widgets/etiqueta_camino.dart';
import 'package:proyectomanu/features/niveles/screens/cuestionario.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';

class TCaminoScreen extends StatelessWidget {
  const TCaminoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final levels = [
      {
        'level': 1,
        'x': screenWidth * 0.25,
        'y': 550.0,
        'stars': 2,
        'special': false,
        'screen': NivelCuestionarioScreen(
          pregunta: "¿Qué letra es esta en LSM?",
          imagenPath: TImages.imagenperfil,
          opciones: ["A", "B", "C"],
          respuestaCorrecta: "A",
          nextScreen: NivelCuestionarioScreen(
            pregunta: "¿Cuál es la letra B?",
            imagenPath: TImages.imagenperfil,
            opciones: ["A", "B", "C"],
            respuestaCorrecta: "B",
            nextScreen: const ExitoNivelLayout(
              mensaje: "¡Nivel completado!",
              imagenPath: TImages.imagenperfil,
            ),
          ),
        ),
      },
      {
        'level': 2,
        'x': screenWidth * 0.7,
        'y': 400.0,
        'stars': 1,
        'special': false,
        'screen': const ExitoNivelLayout(
          mensaje: '¡Muy bien!',
          imagenPath: TImages.imagenperfil,
        ),
      },
      {
        'level': 3,
        'x': screenWidth * 0.3,
        'y': 300.0,
        'stars': 3,
        'special': false,
      },
      {
        'level': 4,
        'x': screenWidth * 0.65,
        'y': 150.0,
        'stars': 3,
        'special': true,
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
              // 🔹 Niveles
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
                    onPressed: () => Get.to(() => level['screen'] as Widget),
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
