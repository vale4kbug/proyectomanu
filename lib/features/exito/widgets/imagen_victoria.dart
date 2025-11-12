import 'package:flutter/material.dart';

class ImagenVictoria extends StatelessWidget {
  const ImagenVictoria({super.key, required this.imagenPath});

  final String imagenPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Image.asset(
        imagenPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
