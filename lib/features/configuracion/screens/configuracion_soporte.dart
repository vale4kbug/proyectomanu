import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class ConfiguracionAyudaScreen extends StatelessWidget {
  const ConfiguracionAyudaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text(TTexts.configAyudaTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(title: TTexts.configFAQ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text(TTexts.configFAQ1),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text(TTexts.configFAQ2),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text(TTexts.configFAQ3),
                onTap: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2.5),
            ],
          ),
        ),
      ),
    );
  }
}
