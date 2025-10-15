import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart'; // <-- USAMOS EL PAQUETE CORRECTO
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
                  // Centramos el Column que contiene el botón y las estrellas
                  left: (level['x'] as double? ?? 0) -
                      45, // Ancho del Column es aprox 90
                  top: (level['y'] as double? ?? 0) - 40,
                  child: TBotonCamino(
                    stars: level['stars'] as int? ?? 0,
                    totalStars: 3, // Asumimos 3 estrellas por nivel
                    onPressed: level['onPressed'] as void Function()?,
                    isSpecial: level['special'] as bool? ?? false,
                    child: (level['special'] as bool? ?? false)
                        ? const Icon(Iconsax.star,
                            color: Color.fromARGB(255, 255, 186, 58), size: 50)
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

// --- WIDGET DE BOTÓN FINAL CON ESTILO CHICLET Y ESTRELLAS DEBAJO ---
class TBotonCamino extends StatelessWidget {
  const TBotonCamino({
    super.key,
    this.onPressed,
    required this.child,
    required this.isSpecial,
    required this.stars,
    this.totalStars = 3,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isSpecial;
  final int stars;
  final int totalStars;

  @override
  Widget build(BuildContext context) {
    final bool isLocked = onPressed == null;

    final Color colorBajo = isLocked
        ? Colors.grey[700]!
        : (isSpecial
            ? TColors.teciaryColor
            : const Color.fromARGB(255, 74, 139, 252));
    final Color colorArriba = isLocked
        ? Colors.grey[600]!
        : (isSpecial ? TColors.superBoton : TColors.primarioBoton);

    return Column(
      // Envolvemos todo en una Columna para separar botón y estrellas
      mainAxisSize: MainAxisSize.min,
      children: [
        // El Botón Chiclet
        ChicletAnimatedButton(
          buttonType: ChicletButtonTypes.circle,
          height: 80,
          width: 80,
          onPressed: onPressed,
          backgroundColor: colorArriba,
          buttonColor: colorBajo,
          disabledBackgroundColor: colorBajo,
          disabledForegroundColor: colorArriba,
          child: isLocked
              ? Icon(Iconsax.lock,
                  color: Colors.white.withOpacity(0.7), size: 40)
              : child,
        ),

        const SizedBox(height: 4), // Espacio entre el botón y las estrellas

        // Contenedor para las estrellas
        SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Mostramos las estrellas solo si el nivel no está bloqueado
            children: isLocked
                ? []
                : List.generate(totalStars, (index) {
                    final bool isFilled = index < stars;
                    return Icon(
                      isFilled
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: isFilled
                          ? Colors.yellow.shade700
                          : Colors.grey.shade400,
                      // --- LÓGICA DE TAMAÑO ---
                      size: isFilled
                          ? 26
                          : 18, // Estrellas rellenas son más grandes
                    );
                  }),
          ),
        ),
      ],
    );
  }
}
