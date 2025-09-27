import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/home/widgets/boton_camino.dart';
import 'package:proyectomanu/features/home/widgets/etiqueta_camino.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

class CaminoBotones extends StatelessWidget {
  const CaminoBotones({
    super.key,
    required this.screenWidth,
    required this.levels,
    required this.tituloUnidad,
  });

  final double screenWidth;
  final List<Map<String, Object?>> levels;
  final String tituloUnidad;

  @override
  Widget build(BuildContext context) {
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
                        : const Color.fromARGB(255, 74, 139, 252),
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
                              color: TColors.light,
                            ),
                          ),
                  ),
                );
              }),
              Positioned(
                top: 650,
                left: 0,
                right: 0,
                child: Center(
                  child: TUnidadEtiqueta(titulo: tituloUnidad),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
