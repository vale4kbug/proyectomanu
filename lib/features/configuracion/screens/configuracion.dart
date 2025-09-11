import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/common/widgets/list_tiles/config_menu_tile.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Configuración',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: TColors.primaryColor),
              ),
              const SizedBox(height: TSizes.sm),
              Text(
                "Ajusta tu experiencia a tu medida",
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: TColors.intermediofuerteAzul,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              TSectionHeading(
                title: 'Mi cuenta',
                showActionButton: false,
                textColor: TColors.primaryColor,
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              TConfigMenuTile(
                icon: Iconsax.setting_4,
                title: 'Preferencias',
                subTitle: 'Ajusta a tu experiencia deseada.',
                onTap: () {},
              ),
              TConfigMenuTile(
                icon: Iconsax.notification,
                title: 'Notificaciones',
                subTitle: 'Elige qué notificaciones quieres ver.',
                onTap: () {},
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              TSectionHeading(
                title: 'Soporte',
                showActionButton: false,
                textColor: TColors.primaryColor,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TConfigMenuTile(
                icon: Iconsax.info_circle,
                title: 'Ayuda',
                subTitle: '¿Necesitas apoyo?',
                onTap: () {},
              ),
              TConfigMenuTile(
                icon: Iconsax.refresh,
                title: 'Retroalimentación',
                subTitle: 'Dinos qué crees que podría ser mejor.',
                onTap: () {},
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Cerrar sesión'),
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
