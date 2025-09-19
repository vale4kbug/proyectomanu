import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class BotonBanner extends StatelessWidget {
  const BotonBanner({
    super.key,
    required this.imagen,
    required this.titulo,
    this.onTap,
  });

  final String imagen; // ruta de la imagen
  final String titulo; // texto del banner
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(TSizes.cardRadiusLG),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Imagen con degradado
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [TColors.primarioBoton, Colors.transparent],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                imagen,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 16),

            // Texto expandible
            Expanded(
              child: Text(
                titulo,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3, // <- Permite varias líneas
                overflow: TextOverflow
                    .ellipsis, // <- Opcional: puntos suspensivos si se pasa
              ),
            ),
          ],
        ),
      ),
    );
  }
}
