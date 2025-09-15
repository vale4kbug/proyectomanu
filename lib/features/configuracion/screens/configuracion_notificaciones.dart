import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class ConfiguracionNotificacionesScreen extends StatefulWidget {
  const ConfiguracionNotificacionesScreen({super.key});

  @override
  State<ConfiguracionNotificacionesScreen> createState() =>
      _ConfiguracionNotificacionesScreenState();
}

class _ConfiguracionNotificacionesScreenState
    extends State<ConfiguracionNotificacionesScreen> {
  bool _general = true;
  bool _recordatorios = true;
  bool _logros = true;
  bool _novedades = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text(TTexts.configNotificacionesTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(title: TTexts.configNotificacionesSubTitle),
              const Divider(),

              SwitchListTile(
                title: Text(
                  TTexts.configNotificacionesGen,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  TTexts.configNotificacionesAlertas,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                activeColor: TColors.primarioBoton,
                inactiveThumbColor: TColors.intermediofuerteAzul,

                value: _general,
                onChanged: (value) => setState(() => _general = value),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              SwitchListTile(
                title: Text(
                  TTexts.configNotificacionesReminder,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  TTexts.configNotificacionesReminderSub,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                activeColor: TColors.primarioBoton,
                inactiveThumbColor: TColors.intermediofuerteAzul,
                value: _recordatorios,
                onChanged: (value) => setState(() => _recordatorios = value),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              SwitchListTile(
                title: Text(
                  TTexts.configNotificacionesLogro,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  TTexts.configNotificacionesLogroSub,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                activeColor: TColors.primarioBoton,
                inactiveThumbColor: TColors.intermediofuerteAzul,

                value: _logros,
                onChanged: (value) => setState(() => _logros = value),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              SwitchListTile(
                title: Text(
                  TTexts.configNotificacionesNov,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  TTexts.configNotificacionesNovSub,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                activeColor: TColors.primarioBoton,
                inactiveThumbColor: TColors.intermediofuerteAzul,

                value: _novedades,
                onChanged: (value) => setState(() => _novedades = value),
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2.5),
            ],
          ),
        ),
      ),
    );
  }
}
