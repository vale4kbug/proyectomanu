// imagen_container.dart
import 'package:flutter/material.dart';

// Contenedor reutilizable para imagen grande.
// Ten en cuenta darle una altura finita (no double.infinity) cuando esté dentro de ScrollView.
class ImagenContainer extends StatelessWidget {
  const ImagenContainer({
    super.key,
    required this.imagen,
    this.height = 220,
    this.fit = BoxFit.cover,
  });

  final String imagen;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.black12,
        child: Image.asset(
          imagen,
          fit: fit,
          width: double.infinity,
          height: height,
        ),
      ),
    );
  }
}
