import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:proyectomanu/features/configuracion/screens/configuracion.dart';
import 'package:proyectomanu/features/perfil/widgets/achievement_card.dart';
import 'package:proyectomanu/features/perfil/widgets/circular_image.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      TCircularImage(
                        image: TImages.imagenperfil,
                        width: 110,
                        height: 110,
                      ),
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

                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Iconsax.setting5, color: TColors.light),
                      onPressed: () =>
                          Get.to(() => const ConfiguracionScreen()),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Text(
                TTexts.perfilEstadisticaTitle,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: TColors.primarioBoton),
              ),
            ),

            TStatUsuarioContainer(
              dark: dark,
              title: TTexts.perfilEstrellas,
              subtitle: TTexts.perfilUsuarioResultado,
              icon: Iconsax.magic_star5,
              iconColor: Color.fromARGB(255, 255, 186, 58),
            ),
            TStatUsuarioContainer(
              dark: dark,
              title: TTexts.perfilNiveles,
              subtitle: TTexts.perfilUsuarioResultado,
              icon: Iconsax.game5,
              iconColor: Color.fromARGB(255, 61, 58, 255),
            ),
            TStatUsuarioContainer(
              dark: dark,
              title: TTexts.perfilLogros,
              subtitle: TTexts.perfilUsuarioResultado,
              icon: Iconsax.medal_star5,
              iconColor: Color.fromARGB(255, 133, 58, 255),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Center(
              child: Text(
                TTexts.perfilLogrosTitle,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: TColors.primarioBoton),
              ),
            ),

            //CUADRICULA CON LOGROS QUE SERIA UNA IMAGEN, DESCRIPCION Y UNA FORMA DE SABER QUE SI LO HA OBTENIDO
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: const [
                TAchievementCard(
                  image: 'assets/images/logro1.png',
                  title: 'Buen comienzo',
                  subtitle: 'Completa un nivel.',
                  locked: false,
                ),
                TAchievementCard(
                  image: 'assets/images/logro2.png',
                  title: 'Perfeccionista',
                  subtitle: 'Completa un nivel con 3 estrellas.',
                  locked: true,
                ),
                TAchievementCard(
                  image: 'assets/images/logro3.png',
                  subtitle: 'Comparte tu progreso.',
                  title: 'Creador de Tendencias',
                  locked: false,
                ),
                TAchievementCard(
                  image: 'assets/images/logro4.png',
                  subtitle: 'Completa tu primer sesión de ejercicios.',
                  title: 'Amarillo Amarillo el Plátano',
                  locked: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
