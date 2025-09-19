import 'package:flutter/material.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/features/ejercicios/widgets/layout_ejercicios.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';

class FluidezClaridadScreen extends StatelessWidget {
  const FluidezClaridadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TContenidoLayout(
      titulo: "Ejercicios",
      textos: [
        "Hola, ¿cómo estas",
        "Abre la mano ",
        "Muy bien",
        "¿Quieres repetir?"
      ],
      imagenesSmall: [
        TImages.imagenperfil,
        TImages.google,
        TImages.facebook,
        TImages.imagenperfil,
      ],
      imagenesBig: [
        TImages.imagenperfil,
        TImages.facebook,
        TImages.google,
        TImages.imagenperfil,
      ],
      colorBurbuja: TColors.primarioBoton,
      tailPosition: BubbleTailPosition.left,
    );
  }
}
