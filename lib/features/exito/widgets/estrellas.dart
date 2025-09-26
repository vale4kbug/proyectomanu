import 'dart:math' as math;
import 'package:flutter/material.dart';

class EstrellasAnimadas extends StatelessWidget {
  const EstrellasAnimadas({
    super.key,
    required this.controller,
    required this.estrellasGanadas,
    this.maxEstrellas = 3,
  });

  final AnimationController controller;
  final int estrellasGanadas;
  final int maxEstrellas;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(maxEstrellas, (index) {
            // La estrella se considera "llena" si la animación ha pasado su umbral
            final umbral = (index + 1) / maxEstrellas;
            final llena =
                controller.value >= umbral && index < estrellasGanadas;

            // Animación de pulso para la estrella actual
            double scale = 1.0;
            if (controller.value >= umbral &&
                controller.value < umbral + 0.1 &&
                index < estrellasGanadas) {
              final localProgress = (controller.value - umbral) / 0.1;
              scale = 1.0 + 0.5 * math.sin(localProgress * math.pi);
            }

            return Transform.scale(
              scale: scale,
              child: Icon(
                llena ? Icons.star_rounded : Icons.star_border_rounded,
                color: const Color.fromARGB(255, 255, 186, 58),
                size: 50,
              ),
            );
          }),
        );
      },
    );
  }
}
