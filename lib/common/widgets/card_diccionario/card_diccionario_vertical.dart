import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:proyectomanu/features/diccionario/widgets/diccionario_tarjeta_individual_base.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class TDiccionarioCardVertical extends StatelessWidget {
  const TDiccionarioCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Get.to(() => const DiccionarioTarjetaIndividual(
            titulo: TTexts.diccionarioTarjetaA,
            gifArriba: TImages.imagenperfil,
            texto: TTexts.diccionarioTarjetaADesc,
            gifAbajo: TImages.onBoardingImage1,
          )),

      ///base
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ), // esquinas redondeadas suaves
          color: dark ? Colors.grey[800] : Colors.white,
          border: Border.all(
            color: const Color.fromARGB(255, 205, 184, 244),
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
                  TImages.imagenperfil,
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
