import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/configuracion/widgets/configuracion_datos_menu.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class ConfiguracionDatosScreen extends StatelessWidget {
  const ConfiguracionDatosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Mis Datos')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSectionHeading(title: 'Información del Perfil'),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              TConfigDatosMenu(
                title: 'Nombre',
                subTitle: 'Manu el mono',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: 'Usuario',
                subTitle: 'xXManuMonitoXx',
                onPressed: () {},
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Cambiar foto de perfil'),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              TSectionHeading(title: 'Información Personal'),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TConfigDatosMenu(
                title: 'ID de Usuario',
                subTitle: '1234',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: 'Correo',
                subTitle: 'manu@gmail.com',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: 'Teléfono',
                subTitle: '+52-631-1234567',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: 'Género',
                subTitle: 'Punk',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: 'Nacimiento',
                subTitle: '10 de abril de 2025',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
