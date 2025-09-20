import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

class TextoMotivacional extends StatelessWidget {
  const TextoMotivacional({super.key, required this.mensaje});

  final String mensaje;

  @override
  Widget build(BuildContext context) {
    return Text(
      mensaje,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .apply(color: TColors.primarioBoton),
      textAlign: TextAlign.center,
    );
  }
}
