import 'package:flutter/material.dart';

class LevelButton extends StatelessWidget {
  final int levelNumber;
  final int stars;
  final bool isSpecial;
  final VoidCallback onPressed;

  const LevelButton({
    super.key,
    required this.levelNumber,
    required this.stars,
    this.isSpecial = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- CÍRCULO PRINCIPAL ---
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: isSpecial
                  ? const Icon(
                      Icons.star_rounded,
                      color: Colors.yellow,
                      size: 50,
                    )
                  : Text(
                      levelNumber.toString(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // --- ESTRELLAS DE CALIFICACIÓN ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Icon(
              index < stars ? Icons.star_rounded : Icons.star_border_rounded,
              color: Colors.yellow.shade700,
              size: 24,
            );
          }),
        ),
      ],
    );
  }
}
