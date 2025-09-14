import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

class TUnidadEtiqueta extends StatelessWidget {
  final String titulo;

  const TUnidadEtiqueta({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: TColors.intermediofuerteAzul,
                thickness: 2,
                endIndent: 8,
              ),
            ),
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: TColors.intermediofuerteAzul,
              ),
            ),
            const Expanded(
              child: Divider(
                color: TColors.intermediofuerteAzul,
                thickness: 2,
                indent: 8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
