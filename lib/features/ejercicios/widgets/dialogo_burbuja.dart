import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/texts/efecto_typewriter.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class DialogoBurbujaPersonaje extends StatelessWidget {
  const DialogoBurbujaPersonaje({
    super.key,
    required this.texto,
    required this.imagenSmall,
    required this.colorburbuja,
    this.tailPosition = BubbleTailPosition.left,
  });

  final String texto;
  final String imagenSmall;
  final Color colorburbuja;
  final BubbleTailPosition tailPosition;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: TSizes.spaceBtwItems / 2),
        // avatar pequeño
        Padding(
          padding: const EdgeInsets.only(left: 1, top: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagenSmall,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        // la burbuja con colita
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: ColitaPosicion(
              color: colorburbuja,
              tailPosition: tailPosition,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                child: TypewriterText(
                  key: ValueKey(texto),
                  text: texto,
                  speed: const Duration(
                      milliseconds: 40), // velocidad de escritura
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
