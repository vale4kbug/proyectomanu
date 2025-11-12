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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              titulo,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                texto.replaceAll("\\n", "\n"),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
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
