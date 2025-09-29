import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/imagen_container.dart';
import 'package:proyectomanu/features/ejercicios/widgets/dialogo_burbuja.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelPresentacionScreen extends StatefulWidget {
  const NivelPresentacionScreen({
    super.key,
    required this.textos,
    required this.imagenesSmall,
    required this.imagenesBig,
    required this.onNext,
    this.colorBurbuja = Colors.blue,
    this.tailPosition = BubbleTailPosition.left,
  });

  final List<String> textos;
  final List<String> imagenesSmall;
  final List<String> imagenesBig;
  final VoidCallback onNext;
  final Color colorBurbuja;
  final BubbleTailPosition tailPosition;

  @override
  State<NivelPresentacionScreen> createState() =>
      _NivelPresentacionScreenState();
}

class _NivelPresentacionScreenState extends State<NivelPresentacionScreen> {
  int currentIndex = 0;

  void _siguiente() {
    if (currentIndex < widget.textos.length - 1) {
      setState(() => currentIndex++);
    } else {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
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
              fit: BoxFit.contain,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _siguiente,
                label: Text(
                  currentIndex < widget.textos.length - 1
                      ? TTexts.botonSiguiente
                      : TTexts.botonContinuar,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
