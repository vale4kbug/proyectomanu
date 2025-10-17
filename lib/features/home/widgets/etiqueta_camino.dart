import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

class TUnidadEtiqueta extends StatelessWidget {
  const TUnidadEtiqueta({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla para darle un tamaño al widget
    final screenWidth = MediaQuery.of(context).size.width;

    // Usamos un SizedBox para darle al Row un ancho definido y evitar errores de layout.
    return SizedBox(
      width: screenWidth, // Ocupará el 90% del ancho de la pantalla
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Línea izquierda
          const Expanded(
              child: Divider(color: TColors.primaryColor, thickness: 1)),

          // Padding para separar el texto de las líneas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              titulo,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.apply(color: TColors.primaryColor),
            ),
          ),

          // Línea derecha
          const Expanded(
              child: Divider(color: TColors.primaryColor, thickness: 1)),
        ],
      ),
    );
  }
}
