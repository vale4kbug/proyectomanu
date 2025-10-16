import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/imagen_container.dart';
import 'package:proyectomanu/features/ejercicios/services/practica_service.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/features/ejercicios/widgets/dialogo_burbuja.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class TContenidoLayout extends StatefulWidget {
  const TContenidoLayout({
    super.key,
    required this.practicaId,
    required this.titulo,
  });

  final int practicaId;
  final String titulo;

  @override
  State<TContenidoLayout> createState() => _TContenidoLayoutState();
}

class _TContenidoLayoutState extends State<TContenidoLayout> {
  late Future<Map<String, dynamic>> futureContenido;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureContenido = PracticaService.getPracticaDetalle(widget.practicaId);
  }

  void _siguiente(int totalPasos) {
    if (currentIndex < totalPasos - 1) {
      setState(() => currentIndex++);
    } else {
      Get.back(); // Vuelve al menú al finalizar
    }
  }

  Color _getColorFromString(String? colorName) {
    if (colorName == 'superBoton') return TColors.superBoton;
    if (colorName == 'primarioBoton') return TColors.primarioBoton;
    return Colors.blue; // Color por defecto
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: futureContenido,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(title: Text(widget.titulo)),
              body: const Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(title: Text(widget.titulo)),
              body: const Center(child: Text("Error al cargar el contenido.")));
        }

        final contenido = snapshot.data!;
        final pasos = contenido['pasos'] as List<dynamic>;
        final pasoActual = pasos[currentIndex] as Map<String, dynamic>;

        return Scaffold(
          appBar: TAppBar(showBackArrow: true, title: Text(widget.titulo)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                DialogoBurbujaPersonaje(
                  texto: pasoActual['texto'],
                  imagenSmall: pasoActual['imagenSmall'],
                  colorburbuja: _getColorFromString(contenido['colorBurbuja']),
                  tailPosition: BubbleTailPosition.left,
                ),
                const SizedBox(height: TSizes.spaceBtwSections / 2),
                ImagenContainer(
                  imagen: pasoActual['imagenBig'],
                  height: 450,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _siguiente(pasos.length),
                    icon: const Icon(Iconsax.play),
                    label: Text(TTexts.botonSiguiente),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
