import 'package:flutter/material.dart';
import 'package:proyectomanu/features/home/widgets/camino_unidad1.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TCaminoScreen(), // 👈 aquí va tu camino
    );
  }
}
