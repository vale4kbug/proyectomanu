import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelLecturaScreen extends StatelessWidget {
  const NivelLecturaScreen({
    super.key,
    required this.titulo,
    required this.texto,
    required this.onNext,
    this.imagenPath, // <--- 1. Nuevo parámetro opcional
  });

  final String titulo;
  final String texto;
  final String? imagenPath; // <--- 2. Variable nullable
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

            // Contenedor del Texto
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
                textAlign:
                    TextAlign.justify, // Se ve mejor justificado en lecturas
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // --- 3. Lógica para mostrar la imagen si existe ---
            if (imagenPath != null && imagenPath!.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagenPath!,
                  height: 200, // Misma altura que usas en otros lados
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text("No se pudo cargar la imagen");
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],

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
