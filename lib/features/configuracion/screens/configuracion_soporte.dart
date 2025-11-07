import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfiguracionAyudaScreen extends StatelessWidget {
  const ConfiguracionAyudaScreen({super.key});

  // --- Método para abrir enlaces externos
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text(TTexts.configAyudaTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- FAQ ----
            TSectionHeading(title: TTexts.configFAQ),
            const Divider(),

            ExpansionTile(
              leading: const Icon(Icons.help_outline),
              title: const Text(TTexts.configFAQ1),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    TTexts.configRespuestaFAQ1,
                  ),
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.help_outline),
              title: const Text(TTexts.configFAQ2),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(TTexts.configRespuestaFAQ2),
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.help_outline),
              title: const Text(TTexts.configFAQ3),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(TTexts.configRespuestaFAQ3),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // ---- Soporte
            TSectionHeading(title: "¿Necesitas más ayuda?"),
            const Divider(),
            ListTile(
              leading:
                  const Icon(Icons.email_outlined, color: TColors.teciaryColor),
              title: const Text("Contactar al soporte"),
              subtitle: const Text("manolingolsm@gmail.com"),
              onTap: () => _launchUrl(
                  "mailto:manolingolsm@gmail.com?subject=Ayuda%20Manolingo"),
            ),
            ListTile(
              leading: const Icon(Icons.launch_outlined,
                  color: TColors.primarioBoton),
              title: const Text("Dependencia de Innovacion"),
              onTap: () => _launchUrl(
                  "https://heroicanogales.gob.mx/dependencia/direccion-de-innovacion-y-proyectos-especiales"),
            ),
            ListTile(
              leading:
                  const Icon(Icons.email_outlined, color: TColors.teciaryColor),
              title: const Text("Programador"),
              onTap: () => _launchUrl(
                  "mailto:chavirava@outlook.com?subject=Servicio%20Requerido"),
            ),
          ],
        ),
      ),
    );
  }
}
