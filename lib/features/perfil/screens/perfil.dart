import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:proyectomanu/features/configuracion/screens/configuracion.dart';
import 'package:proyectomanu/features/perfil/widgets/perfil_foto.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Header azul
          TPrimaryHeaderContainer(
            child: Stack(
              children: [
                /// Contenido principal centrado
                Column(
                  children: [
                    const SizedBox(height: 40),
                    TPerfilFoto(imageUrl: TImages.imagenperfil, onEdit: null),
                    const SizedBox(height: TSizes.spaceBtwSections / 2),
                    Center(
                      child: Text(
                        TTexts.perfilAppBarTitle,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium!.apply(color: Colors.white),
                      ),
                    ),
                  ],
                ),

                /// Ícono flotante de configuración
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(Iconsax.setting, color: TColors.light),
                    onPressed: () => Get.to(() => const ConfiguracionScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
