import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/common/widgets/card_diccionario/card_diccionario_vertical.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/diccionario_header_container.dart';
import 'package:proyectomanu/common/widgets/layouts/gridlayout.dart';
import 'package:proyectomanu/features/diccionario/containers/search_container.dart';
import 'package:proyectomanu/features/diccionario/controllers/glosario_controller.dart';
import 'package:proyectomanu/features/diccionario/widgets/diccionario_categories.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class DiccionarioScreen extends StatelessWidget {
  const DiccionarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GlosarioController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TDiccionarioHeaderContainer(
              child: Column(
                children: [
                  const SizedBox(height: TSizes.spaceBtwSections),
                  //recuadro buscar
                  TSearchContainer(
                    hintText: TTexts.diccionarioBuscador,
                    controller: controller.searchController,
                    onChanged: controller.onSearchQueryChanged,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: const [
                        //catagorias slide horizontal
                        SizedBox(height: TSizes.inputFieldRadius),
                        TSectionHeading(
                          title: TTexts.diccionarioCategorias,
                          textColor: Color.fromARGB(255, 15, 114, 88),
                        ),
                        SizedBox(height: TSizes.inputFieldRadius),
                        TDiccionarioCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //grid
            Padding(
              padding: const EdgeInsets.fromLTRB(
                TSizes.defaultSpace, // left
                TSizes.sm, // top
                TSizes.defaultSpace, // right
                TSizes.defaultSpace, // bottom
              ),
              child: Obx(() {
                if (controller.isLoadingItems.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.glosarioList.isEmpty) {
                  return const Center(
                      child: Text("No se encontraron elementos."));
                }
                return TGridLayout(
                  itemCount: controller.glosarioList.length,
                  itemBuilder: (_, index) => TDiccionarioCardVertical(
                    item: controller.glosarioList[index],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
