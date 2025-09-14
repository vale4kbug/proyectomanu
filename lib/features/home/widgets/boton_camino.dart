import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart';

class TBotonCamino extends StatelessWidget {
  const TBotonCamino({
    super.key,
    required this.onPressed,
    required this.child,
    this.stars = 0,
    required this.colorbajoboton,
    required this.colorarribaboton,
    this.colorborde = Colors.transparent,
  });

  final VoidCallback onPressed;
  final Widget child;
  final int stars;
  final Color colorbajoboton;
  final Color colorarribaboton;
  final Color colorborde;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ChicletOutlinedAnimatedButton(
          onPressed: onPressed,
          width: 80,
          height: 80,
          buttonType: ChicletButtonTypes.oval,
          buttonColor: colorbajoboton,
          backgroundColor: colorarribaboton,
          borderColor: colorborde,
          child: child,
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Icon(
              index < stars ? Icons.star_rounded : Icons.star_border_rounded,
              color: Colors.yellow.shade600,
              size: 24,
            );
          }),
        ),
      ],
    );
  }
}
