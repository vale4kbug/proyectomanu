import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:proyectomanu/features/diccionario/models/glosario_model.dart';
import 'package:proyectomanu/features/diccionario/widgets/diccionario_tarjeta_individual_base.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class TDiccionarioCardVertical extends StatelessWidget {
  const TDiccionarioCardVertical({super.key, required this.item});
  final GlosarioItem item;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Get.to(() => DiccionarioTarjetaIndividual(
            titulo: item.nombre,
            gifArriba: item.img ?? TImages.imagenperfil,
            texto: item.descripcion ?? "No hay descripción.",
            gifAbajo: TImages.anaLeyendo, //estatic
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
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.thumbnail != null &&
                        item.thumbnail!.startsWith('assets/')
                    ? Image.asset(
                        item.thumbnail!,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        item.thumbnail ?? TImages.imagenperfil,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(TImages.imagenperfil,
                              fit: BoxFit.cover);
                        },
                      ),
              ),
            ),
            const SizedBox(height: 8),
            AutoSizeText(
              item.nombre,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
