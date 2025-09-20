import 'dart:math' as math;
import 'package:flutter/material.dart';

/// ---------- WIDGET: Estrellas Animadas ----------
class EstrellasAnimadas extends StatefulWidget {
  const EstrellasAnimadas({super.key, this.totalEstrellas = 3});

  final int totalEstrellas;

  @override
  State<EstrellasAnimadas> createState() => _EstrellasAnimadasState();
}

class _EstrellasAnimadasState extends State<EstrellasAnimadas>
    with TickerProviderStateMixin {
  late AnimationController _estrellaController;
  int estrellasLlenas = 0;

  @override
  void initState() {
    super.initState();
    _estrellaController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {
          if (_estrellaController.value > 0.3) estrellasLlenas = 1;
          if (_estrellaController.value > 0.6) estrellasLlenas = 2;
          if (_estrellaController.value > 0.9) estrellasLlenas = 3;
        });
      });

    _estrellaController.forward();
  }

  @override
  void dispose() {
    _estrellaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.totalEstrellas, (i) {
        final llena = i < estrellasLlenas;
        return AnimatedBuilder(
          animation: _estrellaController,
          builder: (context, child) {
            double scale = 1.0;
            double rotation = 0.0;
            if (llena) {
              scale = 1 + 0.2 * math.sin(_estrellaController.value * 10);
              rotation = 0.1 * math.sin(_estrellaController.value * 6);
            }
            return Transform.rotate(
              angle: rotation,
              child: Transform.scale(
                scale: scale,
                child: Icon(
                  llena ? Icons.star : Icons.star_border,
                  color: const Color.fromARGB(255, 255, 186, 58),
                  size: 50,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
