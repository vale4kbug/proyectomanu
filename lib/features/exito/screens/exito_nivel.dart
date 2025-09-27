import 'package:flutter/material.dart';
import 'package:proyectomanu/features/exito/widgets/barra_progreso.dart';
import 'package:proyectomanu/features/exito/widgets/boton_continuar.dart';
import 'package:proyectomanu/features/exito/widgets/estrellas.dart';
import 'package:proyectomanu/features/exito/widgets/imagen_victoria.dart';
import 'package:proyectomanu/features/exito/widgets/texto_motivacional.dart';

import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

// 1. Convertido a StatefulWidget para manejar las animaciones
class ExitoNivelLayout extends StatefulWidget {
  const ExitoNivelLayout({
    super.key,
    required this.mensaje,
    required this.imagenPath,
    required this.estrellasGanadas,
    required this.onPressed,
    this.maxEstrellas = 3,
  });

  final String mensaje;
  final String imagenPath;
  final int estrellasGanadas;
  final int maxEstrellas;
  final VoidCallback onPressed;

  @override
  State<ExitoNivelLayout> createState() => _ExitoNivelLayoutState();
}

class _ExitoNivelLayoutState extends State<ExitoNivelLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    // 2. Se crea un único controlador para sincronizar ambas animaciones
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 3. La animación se configura para llegar al valor correcto
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.estrellasGanadas / widget.maxEstrellas,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                TTexts.nivelCompleto,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // 4. Se pasa el controlador y las estrellas ganadas al widget de estrellas
              EstrellasAnimadas(
                controller: _controller,
                estrellasGanadas: widget.estrellasGanadas,
                maxEstrellas: widget.maxEstrellas,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // 5. La barra de progreso se actualiza usando el valor de la animación
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return BarraProgresoOvalada(
                    progreso: _progressAnimation.value,
                  );
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              TextoMotivacional(mensaje: widget.mensaje),
              const SizedBox(height: TSizes.spaceBtwItems),
              ImagenVictoria(imagenPath: widget.imagenPath),

              const Spacer(),

              BotonContinuar(
                onPressed: widget.onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
