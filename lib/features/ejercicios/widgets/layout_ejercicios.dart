import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/imagen_container.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/features/ejercicios/widgets/dialogo_burbuja.dart';

import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class TContenidoLayout extends StatefulWidget {
  const TContenidoLayout({
    super.key,
    required this.titulo,
    required this.textos,
    required this.imagenesSmall,
    required this.imagenesBig,
    this.colorBurbuja = Colors.blue,
    this.tailPosition = BubbleTailPosition.left,
  });

  final String titulo;
  final List<String> textos;
  final List<String> imagenesSmall;
  final List<String> imagenesBig;
  final Color colorBurbuja;
  final BubbleTailPosition tailPosition;

  @override
  State<TContenidoLayout> createState() => _TContenidoLayoutState();
}

class _TContenidoLayoutState extends State<TContenidoLayout> {
  int currentIndex = 0;

  void _siguiente() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.textos.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text(widget.titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            DialogoBurbujaPersonaje(
              texto: widget.textos[currentIndex],
              imagenSmall: widget.imagenesSmall[currentIndex],
              colorburbuja: widget.colorBurbuja,
              tailPosition: widget.tailPosition,
            ),
            const SizedBox(height: TSizes.spaceBtwSections / 2),
            ImagenContainer(
              imagen: widget.imagenesBig[currentIndex],
              height: 450,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _siguiente,
                icon: const Icon(Iconsax.play),
                label: Text(TTexts.botonSiguiente),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
