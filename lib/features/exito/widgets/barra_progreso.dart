import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

// 1. Convertido a StatelessWidget, ya que no maneja su propia animación
class BarraProgresoOvalada extends StatelessWidget {
  const BarraProgresoOvalada({
    super.key,
    required this.progreso, // 2. Recibe el progreso como parámetro
  });

  final double progreso;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30), // Ovalada
      child: CustomPaint(
        // 3. Pasa el valor de progreso al pintor
        painter: _BarraProgresoPainter(progreso),
        child: const SizedBox(
          height: TSizes.spaceBtwSections,
          width: double.infinity,
        ),
      ),
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
