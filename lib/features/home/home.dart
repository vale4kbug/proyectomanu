import 'package:flutter/material.dart';
import 'package:proyectomanu/features/home/widgets/camino_unidad1.dart';
import 'package:proyectomanu/features/home/widgets/mapa_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // PageView nos permite crear una lista de pantallas deslizables
    return PageView.builder(
      // El número de páginas es igual al número de unidades que tengas
      itemCount: MapaData.unidades.length,

      // itemBuilder construye cada página (cada TCaminoScreen)
      itemBuilder: (context, index) {
        // Para cada página, le pasamos la unidad correspondiente a su índice
        final unidad = MapaData.unidades[index];
        return TCaminoScreen(unidad: unidad);
      },
    );
  }
}
