import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/utils/http/nivel_service.dart';
import 'package:proyectomanu/features/home/widgets/camino_botones_estilo.dart';
import 'package:proyectomanu/features/niveles/controllers/nivelscreen.dart';
import 'package:proyectomanu/features/home/models/unidad_model.dart';

// --- ¡IMPORTANTE! Importa tu UserController ---
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';

class TCaminoScreen extends StatefulWidget {
  const TCaminoScreen({super.key, required this.unidad});
  final UnidadData unidad;

  @override
  State<TCaminoScreen> createState() => _TCaminoScreenState();
}

class _TCaminoScreenState extends State<TCaminoScreen> {
  Future<List<Map<String, Object?>>>? futureLevels;

  // --- 1. Obtén la instancia del UserController ---
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    // No llames a _cargarNiveles() aquí.
    // Lo llamaremos desde el 'build' cuando sepamos que hay sesión.
  }

  // Tu función _cargarNiveles está perfecta.
  // La usaremos para la carga inicial Y para refrescar.
  Future<void> _cargarNiveles() async {
    setState(() {
      futureLevels = NivelService.getCamino().then((nivelesDesdeApi) {
        // Comprobación de seguridad
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
    // --- 2. Envuelve todo en un Obx ---
    return Obx(() {
      // --- 3. Muestra un spinner MIENTRAS se inicia sesión ---
      if (userController.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      // --- 4. Si terminó y NO hay usuario, muestra error de login ---
      if (userController.usuario.value == null) {
        return const Scaffold(
            body: Center(child: Text("Error: No has iniciado sesión.")));
      }

      // --- 5. ¡HAY USUARIO! Ahora sí podemos cargar niveles ---

      // Si 'futureLevels' es nulo, es la primera carga.
      if (futureLevels == null) {
        // --- ¡ESTA ES LA SOLUCIÓN! ---
        // Programamos _cargarNiveles para que se ejecute
        // DESPUÉS de que este 'build' termine.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _cargarNiveles();
          }
        });

        // Muestra un spinner MIENTRAS _cargarNiveles se prepara
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      // --- 6. El usuario está logueado Y la API ya fue llamada ---
      // Ahora sí usamos el FutureBuilder.
      return FutureBuilder<List<Map<String, Object?>>>(
        future: futureLevels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasError) {
            // Este era el error original de 401
            return Scaffold(
                body: Center(child: Text("Error: ${snapshot.error}")));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Scaffold(
                body: Center(child: Text("No se encontraron niveles.")));
          }

          final levels = snapshot.data!;

          // Tu lógica de 'CaminoBotones' estaba perfecta.
          return CaminoBotones(
            levels: levels.map((level) {
              final bool estaDesbloqueado =
                  level['desbloqueado'] as bool? ?? false;
              final String? requisito = level['requisitoDesbloqueo'] as String?;

              return {
                'level': level['level'],
                'x': level['x'],
                'y': level['y'],
                'stars': level['stars'],
                'special': level['special'],
                'isLocked': !estaDesbloqueado,
                'onPressed': () {
                  if (estaDesbloqueado) {
                    Get.to(() => NivelScreen(nivelId: level['level'] as int))
                        // ¡Perfecto! Esto refresca las estrellas cuando vuelves.
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
    });
  }
}
