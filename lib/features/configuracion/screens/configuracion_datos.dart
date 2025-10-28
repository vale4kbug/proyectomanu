import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/configuracion/widgets/configuracion_datos_menu.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class ConfiguracionDatosScreen extends StatelessWidget {
  const ConfiguracionDatosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
          showBackArrow: true, title: Text(TTexts.configDatosTitle1)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSectionHeading(title: TTexts.configDatosTitle),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TConfigDatosMenu(
                title: TTexts.name,
                subTitle: 'Manu el mono',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: TTexts.username,
                subTitle: 'xXManuMonitoXx',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: TTexts.configDatosFoto,
                subTitle: '',
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSectionHeading(title: TTexts.configDatosTitle2),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TConfigDatosMenu(
                title: TTexts.configDatosID,
                subTitle: '1234',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: 'Correo',
                subTitle: 'manu@gmail.com',
                onPressed: () {},
              ),
              TConfigDatosMenu(
                title: 'Contraseña',
                subTitle: '********',
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems * 4),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    TTexts.eliminarCuentaBoton,
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
