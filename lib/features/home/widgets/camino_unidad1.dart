import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/utils/http/nivel_service.dart';
import 'package:proyectomanu/features/home/widgets/camino_botones_estilo.dart';
import 'package:proyectomanu/features/niveles/controllers/nivelscreen.dart';
// Importa tus nuevos modelos
import 'package:proyectomanu/features/home/models/unidad_model.dart';

class TCaminoScreen extends StatefulWidget {
  const TCaminoScreen({super.key, required this.unidad});
  final UnidadData unidad; // Ahora recibe los datos de la unidad

  @override
  State<TCaminoScreen> createState() => _TCaminoScreenState();
}

class _TCaminoScreenState extends State<TCaminoScreen> {
  Future<List<Map<String, Object?>>>? futureLevels;

  @override
  void initState() {
    super.initState();
    _cargarNiveles();
  }

  Future<void> _cargarNiveles() async {
    setState(() {
      futureLevels = NivelService.getCamino().then((nivelesDesdeApi) {
        if (!mounted) return [];
        final screenWidth = MediaQuery.of(context).size.width;

        // Combina los datos de la API con las posiciones de nuestra unidad
        for (int i = 0; i < nivelesDesdeApi.length; i++) {
          if (i < widget.unidad.posicionesNiveles.length) {
            final posicion = widget.unidad.posicionesNiveles[i];
            nivelesDesdeApi[i]['x'] = posicion.xFactor * screenWidth;
            nivelesDesdeApi[i]['y'] = posicion.y;
          }
        }
        return nivelesDesdeApi;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, Object?>>>(
      future: futureLevels,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
              body: Center(child: Text("No se encontraron niveles.")));
        }

        final levels = snapshot.data!;

        return CaminoBotones(
          levels: levels.map((level) {
            final bool estaDesbloqueado =
                level['desbloqueado'] as bool? ?? false;
            final String? requisito = level['requisitoDesbloqueo'] as String?;

            return {
              'level': level['level'], 'x': level['x'], 'y': level['y'],
              'stars': level['stars'], 'special': level['special'],
              'isLocked': !estaDesbloqueado, // Pasamos el estado de bloqueo
              'onPressed': () {
                if (estaDesbloqueado) {
                  Get.to(() => NivelScreen(nivelId: level['level'] as int))
                      ?.then((_) => _cargarNiveles());
                } else if (requisito != null) {
                  Get.snackbar(
                    "Nivel Bloqueado",
                    requisito,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blueGrey[800],
                    colorText: Colors.white,
                  );
                }
              },
            };
          }).toList(),
          unidad: widget.unidad,
        );
      },
    );
  }
}
