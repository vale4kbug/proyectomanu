import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/diccionario_header_container.dart';
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
                  const TSearchContainer(text: 'Buscar'),
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: const [
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
          ],
        ),
      ),
    );
  }
}
