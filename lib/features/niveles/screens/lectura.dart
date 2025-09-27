import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelLecturaScreen extends StatelessWidget {
  const NivelLecturaScreen({
    super.key,
    required this.titulo,
    required this.texto,
    required this.onNext,
  });

  final String titulo;
  final String texto;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// titulo
            Text(
              titulo,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Texto
            Text(
              texto,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            ///  continuar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onNext,
                child: const Text(TTexts.botonSiguiente),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
