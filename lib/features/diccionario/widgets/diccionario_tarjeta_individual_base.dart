import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/common/widgets/texts/efecto_typewriter.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/colors.dart'; // Asegúrate de importar tus colores

class DiccionarioTarjetaIndividual extends StatelessWidget {
  const DiccionarioTarjetaIndividual({
    super.key,
    required this.titulo,
    required this.gifArriba,
    required this.texto,
    required this.gifAbajo,
  });

  final String titulo;
  final String gifArriba;
  final String texto;
  final String gifAbajo;

  @override
  Widget build(BuildContext context) {
    // Calcula una altura estimada para la burbuja de text.
    final double alturaEstimadaBurbuja =
        _calcularAlturaEstimadaTexto(context, texto);

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text(titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- IMAGEN
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: TColors.primarioBoton,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(
                    TSizes.cardRadiusLG), // Borde redondeado
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(TSizes.cardRadiusLG - 1),
                child: Image.asset(
                  gifArriba,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections / 2),

            // --- BURBUJA DE TEXTO ---
            ColitaPosicion(
              color: Colors.blue,
              tailPosition: BubbleTailPosition.bottom,
              child: SizedBox(
                width: double.infinity,
                height: alturaEstimadaBurbuja, // Altura fija
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                    child: TypewriterText(
                      text: texto,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // --- IMAGEN DE ABAJo
            Image.asset(
              gifAbajo,
              height: 200, // Altura fija para la imagen de abajo
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  // Función para estimar la altura del texto.
  double _calcularAlturaEstimadaTexto(BuildContext context, String texto) {
    final textStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white);
    if (textStyle == null) {
      return 50.0;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final textMaxWidth = screenWidth -
        (TSizes.defaultSpace * 2) -
        (14 * 2) -
        (TSizes.md * 2) -
        20;

    final textPainter = TextPainter(
      text: TextSpan(text: texto, style: textStyle),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: textMaxWidth);

    return textPainter.height + (10 * 2) + 15;
  }
}
