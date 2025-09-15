import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class ConfiguracionRetroalimentacionScreen extends StatefulWidget {
  const ConfiguracionRetroalimentacionScreen({super.key});

  @override
  State<ConfiguracionRetroalimentacionScreen> createState() =>
      _ConfiguracionRetroalimentacionScreenState();
}

class _ConfiguracionRetroalimentacionScreenState
    extends State<ConfiguracionRetroalimentacionScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text(TTexts.configRetroTitle),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(title: TTexts.configRetroSubTitle),
              const Divider(),
              const Text(TTexts.configRetroSubTitle2),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: TTexts.configRetroDecoracion,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_feedbackController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(TTexts.configRetroGracias),
                        ),
                      );
                      _feedbackController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text(TTexts.configRetroEnviar),
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
