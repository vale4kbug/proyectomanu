import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/home/models/unidad_model.dart';
import 'package:proyectomanu/features/home/widgets/etiqueta_camino.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

class CaminoBotones extends StatelessWidget {
  const CaminoBotones({
    super.key,
    required this.levels,
    required this.unidad,
  });

  final List<Map<String, Object?>> levels;
  final UnidadData unidad;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                  left: (level['x'] as double? ?? 0) - 45,
                  top: (level['y'] as double? ?? 0) - 40,
                  child: TBotonCamino(
                    stars: level['stars'] as int? ?? 0,
                    isLocked: level['isLocked'] as bool? ?? true,
                    totalStars: 3,
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
                top: unidad.etiquetaY + 25,
                right: 0,
                child: Center(child: TUnidadEtiqueta(titulo: unidad.titulo)),
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
    required this.isLocked,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isSpecial;
  final int stars;
  final int totalStars;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final Color colorBajo = isLocked
        ? Colors.grey[700]!
        : (isSpecial
            ? TColors.teciaryColor
            : const Color.fromARGB(255, 74, 139, 252));
    final Color colorArriba = isLocked
        ? Colors.grey[600]!
        : (isSpecial ? TColors.superBoton : TColors.primarioBoton);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        const SizedBox(height: 4),
        SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: isLocked
                ? []
                : List.generate(totalStars, (index) {
                    final bool isFilled = index < stars;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        isFilled
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: isFilled
                            ? const Color(0xFFFFC107)
                            : Colors.grey.shade300,
                        size: isFilled ? 26 : 18,
                      ),
                    );
                  }),
          ),
        ),
      ],
    );
  }
}
