import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/common/widgets/image_Text_widgets/vertical_image_text.dart';
import 'package:proyectomanu/features/diccionario/controllers/glosario_controller.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class TDiccionarioCategories extends StatelessWidget {
  const TDiccionarioCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GlosarioController>();

    return Obx(() {
      if (controller.isLoadingCategorias.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.categoriasList.length + 1,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: TSizes.defaultSpace),
          itemBuilder: (_, index) {
            Widget categoryWidget;

            if (index == 0) {
              final isSelected = controller.selectedCategoryId.value == null;
              return TVerticalImageText(
                image: TImages.imagenperfil,
                title: 'Todos',
                textColor: isSelected
                    ? Colors.blue
                    : const Color.fromARGB(255, 15, 114, 88),
                onTap: () => controller.fetchGlosarioItems(),
              );
            } else {
              final categoria = controller.categoriasList[index - 1];
              final isSelected =
                  controller.selectedCategoryId.value == categoria.idCategoria;
              categoryWidget = TVerticalImageText(
                image: categoria.img ?? TImages.imagenperfil,
                title: categoria.nombre,
                textColor: isSelected
                    ? Colors.blue
                    : const Color.fromARGB(255, 15, 114, 88),
                onTap: () => controller.fetchGlosarioItems(
                    categoriaId: categoria.idCategoria),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.spaceBtwItems / 2),
              child: categoryWidget,
            );
          },
        ),
      );
    });
  }
}
