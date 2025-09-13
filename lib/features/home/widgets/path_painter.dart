import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final int levelCount;

  PathPainter({required this.levelCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    List<Offset> points = [];

    // Generar los mismos puntos que en home_screen para los centros de los botones
    for (int i = 0; i < levelCount; i++) {
      final int level = i + 1;
      final double top = 120.0 * level + 40; // +40 para centrar en el botón
      double horizontalPosition;

      if ((i ~/ 3) % 2 == 0) {
        horizontalPosition = (size.width / 5) * (i % 3 + 1);
      } else {
        horizontalPosition = size.width - (size.width / 5) * ((i % 3) + 1);
      }
      points.add(Offset(horizontalPosition, top));
    }

    if (points.isEmpty) return;

    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];

      // Puntos de control para la curva de Bézier (hace el camino curvo)
      final controlPoint1 = Offset((p0.dx + p1.dx) / 2, p0.dy);
      final controlPoint2 = Offset((p0.dx + p1.dx) / 2, p1.dy);

      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    // Dibuja una sombra para el camino para darle profundidad
    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 5.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
