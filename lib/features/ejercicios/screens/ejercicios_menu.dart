import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:proyectomanu/features/ejercicios/screens/expresiones_faciales.dart';
import 'package:proyectomanu/features/ejercicios/screens/fluidez_claridad.dart';
import 'package:proyectomanu/features/ejercicios/widgets/botones_menu.dart';
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
                onTap: () => Get.to(() => const FluidezClaridadScreen()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BotonBanner(
                imagen: TImages.imagenperfil,
                titulo: TTexts.ejerciciosBanner3, //expresiones faciales
                onTap: () => Get.to(() => const ExpresionesFacialesScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
