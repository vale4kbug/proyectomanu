import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/utils/http/nivel_service.dart'; // Ajusta la ruta
import 'package:proyectomanu/features/home/widgets/camino_botones_estilo.dart';
import 'package:proyectomanu/features/niveles/controllers/nivelscreen.dart'; // Ajusta la ruta
import 'package:proyectomanu/utils/constants/text_strings.dart';

class TCaminoScreen extends StatefulWidget {
  const TCaminoScreen({super.key});
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
        // Estas coordenadas se asignarán a los niveles que vengan de la API
        final coordenadas = [
          {'x': screenWidth * 0.25, 'y': 550.0},
          {'x': screenWidth * 0.7, 'y': 400.0},
          {'x': screenWidth * 0.3, 'y': 300.0},
          {'x': screenWidth * 0.65, 'y': 150.0},
          // Puedes añadir más coordenadas aquí para futuros niveles
        ];
        for (int i = 0; i < nivelesDesdeApi.length; i++) {
          if (i < coordenadas.length) {
            nivelesDesdeApi[i]['x'] = coordenadas[i]['x'];
            nivelesDesdeApi[i]['y'] = coordenadas[i]['y'];
          }
        }
        return nivelesDesdeApi;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
          screenWidth: screenWidth,
          levels: levels.map((level) {
            final bool estaDesbloqueado =
                level['desbloqueado'] as bool? ?? false;
            print(
                "Procesando Nivel ${level['level']}: Desbloqueado = $estaDesbloqueado");
            return {
              'level': level['level'], 'x': level['x'], 'y': level['y'],
              'stars': level['stars'], 'special': level['special'],
              'onPressed': (level['desbloqueado'] as bool? ?? false)
                  ? () async {
                      await Get.to(
                          () => NivelScreen(nivelId: level['level'] as int));
                      _cargarNiveles(); // Recarga los niveles cuando el usuario vuelve
                    }
                  : null, // El botón estará deshabilitado si no está desbloqueado
            };
          }).toList(),
          tituloUnidad: TTexts.unidad1,
        );
      },
    );
  }
}
