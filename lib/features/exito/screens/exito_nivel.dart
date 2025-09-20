import 'package:flutter/material.dart';
import 'package:proyectomanu/features/exito/widgets/barra_progreso.dart';
import 'package:proyectomanu/features/exito/widgets/boton_continuar.dart';
import 'package:proyectomanu/features/exito/widgets/estrellas.dart';
import 'package:proyectomanu/features/exito/widgets/imagen_victoria.dart';
import 'package:proyectomanu/features/exito/widgets/texto_motivacional.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class ExitoNivelLayout extends StatelessWidget {
  const ExitoNivelLayout({
    super.key,
    required this.mensaje,
    required this.imagenPath,
    this.totalEstrellas = 3,
  });

  final String mensaje;
  final String imagenPath;
  final int totalEstrellas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Título
              Text(
                "¡Nivel Completado!",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .apply(color: TColors.primaryColor),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              BarraProgresoOvalada(),

              const SizedBox(height: TSizes.spaceBtwSections),

              EstrellasAnimadas(totalEstrellas: totalEstrellas),

              const SizedBox(height: TSizes.spaceBtwSections),

              TextoMotivacional(mensaje: mensaje),

              const SizedBox(height: TSizes.spaceBtwSections),

              ImagenVictoria(imagenPath: imagenPath),

              const SizedBox(height: TSizes.spaceBtwSections),

              BotonContinuar(
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
