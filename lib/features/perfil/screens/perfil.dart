import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:proyectomanu/features/perfil/widgets/perfil_foto.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Header azul
          TPrimaryHeaderContainer(
            child: Column(
              children: [
                Positioned(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      TPerfilFoto(imageUrl: TImages.imagenperfil, onEdit: null),
                      const SizedBox(height: TSizes.spaceBtwSections / 2),
                      Center(
                        child: Text(
                          TTexts.perfilAppBarTitle,
                          style: Theme.of(context).textTheme.headlineMedium!
                              .apply(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Foto y nombre centrados
        ],
      ),
    );
  }
}
