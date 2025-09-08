import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/card_diccionario/card_diccionario_vertical.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/diccionario_header_container.dart';
import 'package:proyectomanu/common/widgets/layouts/gridlayout.dart';
import 'package:proyectomanu/features/diccionario/containers/search_container.dart';
import 'package:proyectomanu/features/diccionario/widgets/diccionario_categories.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class DiccionarioScreen extends StatelessWidget {
  const DiccionarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TDiccionarioHeaderContainer(
              child: Column(
                children: [
                  const SizedBox(height: TSizes.spaceBtwSections),
                  //recuadro buscar
                  const TSearchContainer(text: 'Buscar'),
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: const [
                        //catagorias slide horizontal
                        SizedBox(height: TSizes.inputFieldRadius),
                        TSectionHeading(title: 'Categorías'),
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
              child: Column(
                children: [
                  TGridLayout(
                    itemCount: 16,
                    itemBuilder: (_, index) => const TDiccionarioCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
