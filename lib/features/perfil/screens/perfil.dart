import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/features/configuracion/screens/configuracion.dart';
import 'package:proyectomanu/features/perfil/widgets/circular_image.dart';
import 'package:proyectomanu/features/perfil/widgets/logros_display.dart';
import 'package:proyectomanu/features/perfil/widgets/stat_usuario_container.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/helpers/helper_functions.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.find<UserController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.isLoading.value && controller.usuario.value == null) {
            return const Center(
                heightFactor: 15, child: CircularProgressIndicator());
          }

          if (controller.usuario.value == null) {
            return const Center(
                heightFactor: 15, child: Text("No se pudo cargar el perfil."));
          }

          final usuario = controller.usuario.value!;

          return Column(
            children: [
              TPrimaryHeaderContainer(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        const TCircularImage(
                            image: TImages.imagenperfil,
                            width: 135,
                            height: 135),
                        const SizedBox(height: TSizes.spaceBtwSections / 3),
                        Center(
                          child: Text(
                            usuario.nombreUsuario, // <-- DATO REAL
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .apply(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: IconButton(
                        icon:
                            const Icon(Iconsax.setting5, color: TColors.light),
                        onPressed: () =>
                            Get.to(() => const ConfiguracionScreen()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              Center(
                child: Text(
                  TTexts.perfilEstadisticaTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.primarioBoton),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TStatUsuarioContainer(
                dark: dark,
                title: TTexts.perfilEstrellas,
                subtitle: usuario.estrellas.toString(),
                icon: Iconsax.magic_star5,
                iconColor: const Color.fromARGB(255, 255, 186, 58),
              ),
              TStatUsuarioContainer(
                dark: dark,
                title: TTexts.perfilNiveles,
                subtitle: usuario.nivelesCompletados.toString(),
                icon: Iconsax.game5,
                iconColor: const Color.fromARGB(255, 61, 58, 255),
              ),
              TStatUsuarioContainer(
                dark: dark,
                title: TTexts.perfilLogros,
                subtitle:
                    '${usuario.logros.where((l) => l.desbloqueado).length} / ${usuario.logros.length}',
                icon: Iconsax.medal_star5,
                iconColor: const Color.fromARGB(255, 133, 58, 255),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Center(
                child: Text(
                  TTexts.perfilLogrosTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.primarioBoton),
                ),
              ),
              TLogrosDisplayPerfil(logros: usuario.logros),
              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    label: const Text(TTexts.perfilCompartir),
                    icon: const Icon(Iconsax.send_2),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
