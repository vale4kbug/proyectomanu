import 'package:flutter/material.dart';

enum BubbleTailPosition { left, right, top, bottom }

class ColitaPosicion extends StatelessWidget {
  final Widget child;
  final Color color;
  final BubbleTailPosition tailPosition;

  const ColitaPosicion({
    super.key,
    required this.child,
    required this.color,
    this.tailPosition = BubbleTailPosition.left,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(color: color, tailPosition: tailPosition),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: EdgeInsets.only(
          left: tailPosition == BubbleTailPosition.left ? 10 : 0,
          right: tailPosition == BubbleTailPosition.right ? 10 : 0,
          top: tailPosition == BubbleTailPosition.top ? 10 : 0,
          bottom: tailPosition == BubbleTailPosition.bottom ? 10 : 0,
        ),
        child: child,
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  final Color color;
  final BubbleTailPosition tailPosition;

  _BubblePainter({required this.color, required this.tailPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final rrect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(16),
    );
    canvas.drawRRect(rrect, paint);

    final path = Path();
    switch (tailPosition) {
      case BubbleTailPosition.left:
        path.moveTo(0, 20);
        path.lineTo(-10, 25);
        path.lineTo(0, 30);
        break;
      case BubbleTailPosition.right:
        path.moveTo(size.width, 20);
        path.lineTo(size.width + 10, 25);
        path.lineTo(size.width, 30);
        break;
      case BubbleTailPosition.top:
        path.moveTo(20, 0);
        path.lineTo(25, -10);
        path.lineTo(30, 0);
        break;
      case BubbleTailPosition.bottom:
        path.moveTo(20, size.height);
        path.lineTo(25, size.height + 10);
        path.lineTo(30, size.height);
        break;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
