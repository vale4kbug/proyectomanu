import 'package:flutter/material.dart';
import 'package:proyectomanu/features/ejercicios/screens/botones_menu.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class EjerciciosScreen extends StatelessWidget {
  const EjerciciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BotonBanner(
                imagen: TImages.imagenperfil,
                titulo: TTexts.ejerciciosBanner1,
                onTap: () {},
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BotonBanner(
                imagen: TImages.imagenperfil,
                titulo: TTexts.ejerciciosBanner2,
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BotonBanner(
                imagen: TImages.imagenperfil,
                titulo: TTexts.ejerciciosBanner3,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
