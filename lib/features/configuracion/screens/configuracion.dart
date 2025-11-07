import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/common/widgets/list_tiles/config_menu_tile.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/features/configuracion/screens/configuracion_datos.dart';
import 'package:proyectomanu/features/configuracion/screens/configuracion_notificaciones.dart';
import 'package:proyectomanu/features/configuracion/screens/configuracion_soporte.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      appBar: TAppBar(
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.close_square),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.configTitle,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: TColors.primaryColor),
              ),
              const SizedBox(height: TSizes.sm),
              Text(
                TTexts.configSubTitle,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.apply(color: TColors.primarioBoton),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TSectionHeading(
                title: TTexts.configCuenta,
                showActionButton: false,
                textColor: TColors.primaryColor,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TConfigMenuTile(
                icon: Iconsax.personalcard,
                title: TTexts.configDatos,
                subTitle: TTexts.configDatosSub,
                onTap: () => Get.to(() => const ConfiguracionDatosScreen()),
              ),
              TConfigMenuTile(
                icon: Iconsax.notification,
                title: TTexts.configNotificaciones,
                subTitle: TTexts.configNotificacionesSub,
                onTap: () =>
                    Get.to(() => const ConfiguracionNotificacionesScreen()),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              TSectionHeading(
                title: TTexts.configSoporteTitle,
                showActionButton: false,
                textColor: TColors.primaryColor,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TConfigMenuTile(
                icon: Iconsax.info_circle,
                title: TTexts.configAyuda,
                subTitle: TTexts.configAyudaSub,
                onTap: () => Get.to(() => const ConfiguracionAyudaScreen()),
              ),
              // TConfigMenuTile(
              // icon: Iconsax.refresh,
              //title: TTexts.configRetro,
              //subTitle: TTexts.configRetroSub,
              //onTap: () =>
              //  Get.to(() => const ConfiguracionRetroalimentacionScreen()),
              //),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => userController.logout(),
                  child: const Text(
                    TTexts.cerrarSesionBoton,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2.5),
            ],
          ),
        ),
      ),
    );
  }
}
