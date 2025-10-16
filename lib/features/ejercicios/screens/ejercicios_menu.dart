import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/features/ejercicios/services/practica_service.dart';
import 'package:proyectomanu/features/ejercicios/widgets/botones_menu.dart';
import 'package:proyectomanu/features/ejercicios/widgets/layout_ejercicios.dart';

class EjerciciosScreen extends StatefulWidget {
  const EjerciciosScreen({super.key});

  @override
  State<EjerciciosScreen> createState() => _EjerciciosScreenState();
}

class _EjerciciosScreenState extends State<EjerciciosScreen> {
  late Future<List<Map<String, dynamic>>> futurePracticas;

  @override
  void initState() {
    super.initState();
    futurePracticas = PracticaService.getMenuPracticas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futurePracticas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
                child: Text("Error al cargar los ejercicios de práctica."));
          }

          final practicas = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: practicas.length,
            itemBuilder: (context, index) {
              final practica = practicas[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BotonBanner(
                  imagen: practica['imagenBanner'],
                  titulo: practica['nombre'],
                  onTap: () {
                    Get.to(() => TContenidoLayout(
                          practicaId: practica['id'],
                          titulo: practica['nombre'],
                        ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
