import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class BotonContinuar extends StatelessWidget {
  const BotonContinuar({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          TTexts.finalizar,
        ),
      ),
    );
  }
}
