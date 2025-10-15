import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart';
import 'package:iconsax/iconsax.dart';
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
                  left: (level['x'] as double? ?? 0) - 40,
                  top: (level['y'] as double? ?? 0) - 40,
                  child: TBotonCamino(
                    stars: level['stars'] as int? ?? 0,
                    onPressed: level['onPressed'] as void Function()?,
                    isSpecial: level['special'] as bool? ?? false,
                    child: (level['special'] as bool? ?? false)
                        ? const Icon(Iconsax.star,
                            color: Color.fromARGB(255, 255, 186, 58), size: 60)
                        : Text(
                            "${level['level']}",
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: TColors.light),
                          ),
                  ),
                );
              }),
              Positioned(
                top: 650,
                left: 0,
                right: 0,
                child: Center(child: TUnidadEtiqueta(titulo: tituloUnidad)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGET DE BOTÓN FINAL USANDO ChicletOutlinedAnimatedButton con tus ajustes ---
class TBotonCamino extends StatelessWidget {
  const TBotonCamino({
    super.key,
    this.onPressed,
    required this.child,
    required this.isSpecial,
    required this.stars,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isSpecial;
  final int stars;

  @override
  Widget build(BuildContext context) {
    final bool isLocked = onPressed == null;

    // Define los colores para el estado DESBLOQUEADO
    final Color colorBajoEnabled = isSpecial
        ? TColors.teciaryColor
        : const Color.fromARGB(255, 74, 139, 252);
    final Color colorArribaEnabled =
        isSpecial ? TColors.superBoton : TColors.primarioBoton;

    // Define los colores para el estado BLOQUEADO
    final Color colorBajoDisabled = Colors.grey[700]!;
    final Color colorArribaDisabled = Colors.grey[600]!;

    return ChicletOutlinedAnimatedButton(
      height: 80,
      width: 80,
      onPressed:
          onPressed, // El widget se deshabilita automáticamente si onTap es null

      // --- PARÁMETROS AJUSTADOS SEGÚN TU IMAGEN ---
      borderColor: colorBajoEnabled,
      buttonColor: colorArribaEnabled,
      foregroundColor: colorArribaEnabled,
      disabledBorderColor: colorBajoDisabled,
      disabledBackgroundColor: colorArribaDisabled,

      buttonHeight: 4, // <-- Ajustado para un contorno más delgado (era 8)
      borderWidth: 2, // <-- Este también define el grosor del contorno
      borderRadius: 40, // Para asegurar que sea circular (radius = height/2)
      buttonType:
          ChicletButtonTypes.circle, // Asegura que el botón sea un círculo

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Muestra el candado o el contenido principal (número/estrella)
          isLocked
              ? Icon(Iconsax.lock,
                  color: Colors.white.withOpacity(0.7), size: 40)
              : child,

          // Muestra las estrellas debajo si no está bloqueado y tiene estrellas
          if (!isLocked && stars > 0)
            Padding(
              padding: const EdgeInsets.only(
                  top:
                      8.0), // <-- Aumentado el padding para bajar las estrellas
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(stars, (index) {
                  return Icon(
                    Iconsax
                        .star1, // Usa star1 para estrellas rellenas, star para solo el contorno
                    color: index < stars
                        ? Colors.yellow
                        : Colors.grey.withOpacity(
                            0.5), // Rellenas para las ganadas, contorno para las vacías
                    size: 16,
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
