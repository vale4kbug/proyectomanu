import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chiclet/chiclet.dart';
import 'package:proyectomanu/utils/http/nivel_service.dart';
import 'package:proyectomanu/features/niveles/controllers/nivelscreen.dart';
import 'package:proyectomanu/features/home/models/unidad_model.dart';
import 'package:proyectomanu/features/home/widgets/mapa_data.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/features/home/widgets/etiqueta_camino.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

// --- CLASES AUXILIARES PARA LA LISTA MIXTA ---
abstract class ElementoCamino {}

class NivelElemento extends ElementoCamino {
  final Map<String, Object?> data;
  NivelElemento(this.data);
}

class EtiquetaElemento extends ElementoCamino {
  final UnidadData unidad;
  EtiquetaElemento(this.unidad);
}

class TCaminoScreen extends StatefulWidget {
  const TCaminoScreen({super.key});

  @override
  State<TCaminoScreen> createState() => _TCaminoScreenState();
}

class _TCaminoScreenState extends State<TCaminoScreen> {
  Future<List<Map<String, Object?>>>? futureLevels;
  List<ElementoCamino> listaMixta = []; // La nueva lista procesada
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _cargarNiveles() async {
    final nivelesRaw = await NivelService.getCaminoCompleto();
    setState(() {
      futureLevels = Future.value(nivelesRaw);
      _procesarListaMixta(nivelesRaw);
    });
  }

  // --- PROCESAR LA LISTA (Insertar etiquetas) ---
  void _procesarListaMixta(List<Map<String, Object?>> levels) {
    listaMixta.clear();
    if (levels.isEmpty) return;

    // Recorremos la lista original (del nivel 1 al N)
    for (int i = 0; i < levels.length; i++) {
      final nivelActual = levels[i];
      final catActual = nivelActual['categoria'] as String? ?? "Unidad 1";
      final datosUnidad = _obtenerDatosDeUnidad(catActual);

      bool esInicioUnidad = false;
      if (i == 0) {
        esInicioUnidad = true; // El primero siempre es inicio
      } else {
        final nivelAnterior = levels[i - 1];
        final catAnterior = nivelAnterior['categoria'] as String? ?? "";
        if (catActual != catAnterior) {
          esInicioUnidad = true; // Hubo cambio de categoría
        }
      }

      // Si es el inicio de una unidad, PRIMERO insertamos su etiqueta
      // (Recuerda que la lista se verá invertida)
      if (esInicioUnidad) {
        listaMixta.add(EtiquetaElemento(datosUnidad));
      }
      // LUEGO insertamos el nivel
      listaMixta.add(NivelElemento(nivelActual));
    }
  }

  UnidadData _obtenerDatosDeUnidad(String nombreCategoria) {
    final busqueda = nombreCategoria.trim().toLowerCase();
    return MapaData.unidades.firstWhere(
      (u) => u.categoriaId.trim().toLowerCase() == busqueda,
      orElse: () => MapaData.unidades[0],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userController.isLoading.value)
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      if (userController.usuario.value == null)
        return const Scaffold(body: Center(child: Text("Error de sesión.")));

      if (futureLevels == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _cargarNiveles();
        });
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        body: FutureBuilder<List<Map<String, Object?>>>(
          future: futureLevels,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return const Center(child: CircularProgressIndicator());
            if (!snapshot.hasData || snapshot.data!.isEmpty)
              return const Center(child: Text("No hay niveles."));

            // Usamos la lista procesada
            return ListView.builder(
              reverse: true, // Abajo hacia arriba
              padding: const EdgeInsets.symmetric(vertical: 60.0),
              itemCount: listaMixta.length,
              itemBuilder: (context, index) {
                final elemento = listaMixta[index];

                // --- CASO 1: ES UNA ETIQUETA ---
                if (elemento is EtiquetaElemento) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: TUnidadEtiqueta(titulo: elemento.unidad.titulo),
                  );
                }

                // --- CASO 2: ES UN NIVEL ---
                if (elemento is NivelElemento) {
                  final level = elemento.data;
                  final int levelId = level['level'] as int;
                  final String categoriaActual =
                      level['categoria'] as String? ?? "Unidad 1";
                  final bool estaDesbloqueado =
                      level['desbloqueado'] as bool? ?? false;
                  final String? requisito =
                      level['requisitoDesbloqueo'] as String?;
                  final int stars = level['stars'] as int? ?? 0;
                  final bool isSpecial = level['special'] as bool? ?? false;

                  final UnidadData datosUnidad =
                      _obtenerDatosDeUnidad(categoriaActual);

                  // --- COLORES ---
                  Color colorArriba, colorAbajo;
                  if (!estaDesbloqueado) {
                    colorArriba = Colors.grey[400]!;
                    colorAbajo = Colors.grey[600]!;
                  } else if (isSpecial) {
                    colorArriba = const Color(0xFFFFD700);
                    colorAbajo = const Color(0xFFC5A000);
                  } else {
                    colorArriba = datosUnidad.colorPrimario;
                    colorAbajo = datosUnidad.colorSombra;
                  }

                  // --- ZIGZAG ---
                  // Calculamos el índice REAL del nivel (ignorando etiquetas) para el zigzag
                  int nivelIndexReales = 0;
                  for (int i = 0; i <= index; i++) {
                    if (listaMixta[i] is NivelElemento) nivelIndexReales++;
                  }

                  double offsetX = (nivelIndexReales % 2 == 0) ? 70.0 : -70.0;

                  // Si el elemento ANTERIOR (visualmente abajo) es una etiqueta, centramos este nivel
                  if (index > 0 && listaMixta[index - 1] is EtiquetaElemento) {
                    offsetX = 0.0;
                  }

                  return Transform.translate(
                    offset: Offset(offsetX, 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: TBotonCamino(
                          stars: stars,
                          isLocked: !estaDesbloqueado,
                          isSpecial: isSpecial,
                          colorArriba: colorArriba,
                          colorAbajo: colorAbajo,
                          onPressed: () {
                            if (estaDesbloqueado) {
                              Get.to(() => NivelScreen(nivelId: levelId))
                                  ?.then((_) => _cargarNiveles());
                            } else if (requisito != null) {
                              Get.snackbar("Bloqueado", requisito,
                                  backgroundColor: Colors.grey[800],
                                  colorText: Colors.white);
                            }
                          },
                          child: !estaDesbloqueado
                              ? Icon(Iconsax.lock,
                                  color: Colors.white.withOpacity(0.6),
                                  size: 40)
                              : (isSpecial
                                  ? const Icon(Iconsax.star,
                                      color: Colors.white, size: 45)
                                  : Text("$levelId",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      );
    });
  }
}

// (Tu clase TBotonCamino sigue igual)
class TBotonCamino extends StatelessWidget {
  const TBotonCamino({
    super.key,
    required this.onPressed,
    required this.child,
    this.stars = 0,
    required this.colorAbajo,
    required this.colorArriba,
    this.isLocked = false,
    this.isSpecial = false,
  });
  final VoidCallback? onPressed;
  final Widget child;
  final int stars;
  final Color colorAbajo;
  final Color colorArriba;
  final bool isLocked;
  final bool isSpecial;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ChicletAnimatedButton(
          onPressed: onPressed,
          width: 80,
          height: 80,
          buttonType: ChicletButtonTypes.circle,
          buttonColor: colorAbajo,
          backgroundColor: colorArriba,
          child: child,
        ),
        const SizedBox(height: 8),
        if (!isLocked)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => Icon(
                      index < stars
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: Colors.yellow.shade700,
                      size: 24,
                    )),
          ),
      ],
    );
  }
}
