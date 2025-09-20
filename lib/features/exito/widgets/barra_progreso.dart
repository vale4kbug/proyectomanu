import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class BarraProgresoOvalada extends StatefulWidget {
  const BarraProgresoOvalada({super.key});

  @override
  State<BarraProgresoOvalada> createState() => _BarraProgresoOvaladaState();
}

class _BarraProgresoOvaladaState extends State<BarraProgresoOvalada>
    with SingleTickerProviderStateMixin {
  late AnimationController _barraController;

  @override
  void initState() {
    super.initState();
    _barraController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  void dispose() {
    _barraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _barraController,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(30), // Ovalada
          child: CustomPaint(
            painter: _BarraProgresoPainter(_barraController.value),
            child: const SizedBox(
              height: TSizes.spaceBtwSections,
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }
}

class _BarraProgresoPainter extends CustomPainter {
  final double progreso;
  _BarraProgresoPainter(this.progreso);

  @override
  void paint(Canvas canvas, Size size) {
    final paintFondo = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final paintProgreso = Paint()
      ..shader = const LinearGradient(
        colors: [
          TColors.intermediofuerteAzul,
          TColors.primarioBoton,
          TColors.primaryColor,
          // TColors.superBoton
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Fondo
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(30)),
      paintFondo,
    );

    // Progreso
    final widthProgreso = size.width * progreso;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, widthProgreso, size.height),
          const Radius.circular(30)),
      paintProgreso,
    );

    // Divisiones
    final divisionPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    for (int i = 1; i < 3; i++) {
      final x = size.width * (i / 3);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), divisionPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarraProgresoPainter oldDelegate) {
    return oldDelegate.progreso != progreso;
  }
}
