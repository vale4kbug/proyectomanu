import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/utils/http/nivel_service.dart';
import 'package:proyectomanu/features/niveles/controllers/nivelscreen.dart';
import 'package:proyectomanu/features/home/models/unidad_model.dart';
import 'package:proyectomanu/features/home/widgets/camino_botones_estilo.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/features/home/widgets/etiqueta_camino.dart';

class TCaminoScreen extends StatefulWidget {
  const TCaminoScreen({super.key, required this.unidad});
  final UnidadData unidad;

  @override
  State<TCaminoScreen> createState() => _TCaminoScreenState();
}

class _TCaminoScreenState extends State<TCaminoScreen> {
  Future<List<Map<String, Object?>>>? futureLevels;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _cargarNiveles() async {
    setState(() {
      futureLevels = NivelService.getCamino(widget.unidad.categoriaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userController.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (userController.usuario.value == null) {
        return const Scaffold(
            body: Center(child: Text("Error: No has iniciado sesión.")));
      }

      if (futureLevels == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _cargarNiveles();
          }
        });
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        body: FutureBuilder<List<Map<String, Object?>>>(
          future: futureLevels,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No se encontraron niveles."));
            }

            final levels = snapshot.data!;

            return ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(
                  vertical: 40.0), // Espacio arriba y abajo
              itemCount: levels.length + 1, // +1 para la etiqueta del título
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    padding: const EdgeInsets.all(30.0),
                    alignment: Alignment.center,
                    child: TUnidadEtiqueta(titulo: widget.unidad.titulo),
                  );
                }

                final levelIndex = index - 1;
                final level = levels[levelIndex];

                final bool estaDesbloqueado =
                    level['desbloqueado'] as bool? ?? false;
                final String? requisito =
                    level['requisitoDesbloqueo'] as String?;
                final int stars = level['stars'] as int? ?? 0;
                final bool isSpecial = level['special'] as bool? ?? false;
                final int levelId = level['level'] as int;

                final bool esPar = levelIndex % 2 == 0;
                final Alignment alineacion =
                    esPar ? Alignment.centerLeft : Alignment.centerRight;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 40.0,
                  ),
                  child: Align(
                    alignment: alineacion,
                    child: TBotonCamino(
                      stars: stars,
                      isLocked: !estaDesbloqueado,
                      isSpecial: isSpecial,
                      onPressed: () {
                        if (estaDesbloqueado) {
                          Get.to(() => NivelScreen(nivelId: levelId))
                              ?.then((_) => _cargarNiveles());
                        } else if (requisito != null) {
                          Get.snackbar(
                            "Nivel Bloqueado",
                            requisito,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: isSpecial
                          ? const Icon(Iconsax.star,
                              color: Color.fromARGB(255, 255, 186, 58),
                              size: 50)
                          : Text(
                              "$levelId",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}
