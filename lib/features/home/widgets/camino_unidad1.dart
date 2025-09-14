import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/home/widgets/boton_camino.dart';
import 'package:proyectomanu/features/home/widgets/etiqueta_camino.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

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
      },
      {
        'level': 2,
        'x': screenWidth * 0.7,
        'y': 400.0,
        'stars': 1,
        'special': false,
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
                    onPressed: () {},
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
