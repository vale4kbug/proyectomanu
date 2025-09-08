import 'package:flutter/material.dart';
import 'package:proyectomanu/common/styles/shadows.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class TDiccionarioCardVertical extends StatelessWidget {
  const TDiccionarioCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          boxShadow: [TShadowSyle.verticalCardShadow],
          borderRadius: BorderRadius.circular(
            12,
          ), // esquinas redondeadas suaves
          color: dark ? Colors.grey[800] : Colors.white,
          border: Border.all(
            color: const Color.fromARGB(255, 15, 114, 88),
            width: 2,
          ), // recuadro
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen recortada
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/thumbnaildactidologiaA.png',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover, // ajusta la imagen al recuadro
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Título
            Text(
              "A",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
