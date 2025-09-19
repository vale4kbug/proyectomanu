import 'package:flutter/material.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/features/ejercicios/widgets/layout_ejercicios.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';

class ExpresionesFacialesScreen extends StatelessWidget {
  const ExpresionesFacialesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TContenidoLayout(
      titulo: "Expresiones faciales",
      textos: [
        "Sonrie",
        "Levanta las cejas",
        "Haz cara de sorpresa",
      ],
      imagenesSmall: [
        TImages.imagenperfil,
        TImages.facebook,
        TImages.imagenperfil,
      ],
      imagenesBig: [
        TImages.google,
        TImages.facebook,
        TImages.imagenperfil,
      ],
      colorBurbuja: TColors.superBoton,
      tailPosition: BubbleTailPosition.left,
    );
  }
}
