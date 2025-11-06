import 'package:flutter/material.dart';
import 'package:proyectomanu/features/home/widgets/camino_unidad1.dart';
import 'package:proyectomanu/features/home/widgets/mapa_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: MapaData.unidades.length,
      itemBuilder: (context, index) {
        final unidad = MapaData.unidades[index];
        return TCaminoScreen(unidad: unidad);
      },
    );
  }
}
