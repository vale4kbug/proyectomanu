import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/features/exito/screens/exito_nivel.dart';
import 'package:proyectomanu/features/niveles/models/tipoejercicio.dart';
import 'package:proyectomanu/features/niveles/screens/camara.dart';
import 'package:proyectomanu/features/niveles/screens/cuestionario.dart';
import 'package:proyectomanu/features/niveles/screens/escribe.dart';
import 'package:proyectomanu/features/niveles/screens/historia.dart';
import 'package:proyectomanu/features/niveles/screens/lectura.dart';
import 'package:proyectomanu/features/niveles/screens/presentacion_sena.dart';
import 'package:proyectomanu/features/niveles/screens/relacionar_columnas.dart';
import 'package:proyectomanu/features/niveles/screens/relacionar_texto.dart';
import 'package:proyectomanu/utils/http/nivel_service.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/navigation_menu.dart';

class NivelScreen extends StatefulWidget {
  const NivelScreen({super.key, required this.nivelId});
  final int nivelId;

  @override
  State<NivelScreen> createState() => _NivelScreenState();
}

class _NivelScreenState extends State<NivelScreen> {
  late Future<List<Ejercicio>> futureEjercicios;
  int _indiceActual = 0;
  int _puntaje = 0;

  @override
  void initState() {
    super.initState();
    futureEjercicios = NivelService.getEjercicios(widget.nivelId);
  }

  void _siguiente(List<Ejercicio> ejercicios, {bool? correcto}) {
    if (correcto == true) {
      _puntaje++;
      print(
          "DEBUG: _siguiente -> Se aumentó _puntaje a $_puntaje (correcto == true)");
    } else {
      print(
          "DEBUG: _siguiente -> correcto == $correcto, _puntaje sigue = $_puntaje");
    }

    if (_indiceActual < ejercicios.length - 1) {
      setState(() => _indiceActual++);
    } else {
      final int ejerciciosEvaluables = ejercicios.where((ej) {
        return ej.tipo != TipoEjercicio.historia &&
            ej.tipo != TipoEjercicio.presentacion &&
            ej.tipo != TipoEjercicio.lectura;
      }).length;
      print(
          "DEBUG: Finalizando nivel. ejerciciosEvaluables = $ejerciciosEvaluables, puntaje local = $_puntaje");

      int estrellasCalculadas = 0;
      if (ejerciciosEvaluables > 0) {
        double porcentaje = _puntaje / ejerciciosEvaluables;
        if (porcentaje >= 0.95) {
          estrellasCalculadas = 3;
        } else if (porcentaje >= 0.60) {
          estrellasCalculadas = 2;
        } else if (_puntaje > 0) {
          estrellasCalculadas = 1;
        }
      }

      NivelService.finalizarNivel(widget.nivelId, _puntaje).then((_) async {
        final userController = Get.find<UserController>();
        await userController.recargarUsuario();
        Get.off(() => ExitoNivelLayout(
              mensaje: TTexts.obtenerMensajePorEstrellas(estrellasCalculadas),
              imagenPath: TImages.imagenPorEstrellas(estrellasCalculadas),
              estrellasGanadas: estrellasCalculadas,
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            ));
      }).catchError((error) {
        print("ERROR al finalizar nivel: $error");
        Get.snackbar(
          'Error',
          'No se pudo finalizar el nivel. Intenta nuevamente.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ejercicio>>(
      future: futureEjercicios,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error al cargar ejercicios: ${snapshot.error}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureEjercicios =
                            NivelService.getEjercicios(widget.nivelId);
                      });
                    },
                    child: const Text("Reintentar"),
                  ),
                ],
              ),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
              body: Center(
                  child:
                      Text("No se encontraron ejercicios para este nivel.")));
        }

        final ejercicios = snapshot.data!;
        final ejercicio = ejercicios[_indiceActual];

        try {
          switch (ejercicio.tipo) {
            case TipoEjercicio.camara:
              return NivelCamaraScreen(
                key: ValueKey(_indiceActual),
                senaObjetivo: ejercicio.data["senaObjetivo"],
                onNext: (correcto) =>
                    _siguiente(ejercicios, correcto: correcto),
              );
            case TipoEjercicio.cuestionario:
              return NivelCuestionarioScreen(
                key: ValueKey(_indiceActual),
                pregunta: ejercicio.data["pregunta"],
                imagenPath: ejercicio.data["imagenPath"],
                opciones: List<String>.from(ejercicio.data["opciones"]),
                respuestaCorrecta: ejercicio.data["respuestaCorrecta"],
                onNext: (correcto) =>
                    _siguiente(ejercicios, correcto: correcto),
              );
            case TipoEjercicio.relacionar:
              return NivelRelacionScreen(
                key: ValueKey(_indiceActual),
                imagenes: List<String>.from(ejercicio.data["imagenes"]),
                palabras: List<String>.from(ejercicio.data["palabras"]),
                respuestasCorrectas: Map<String, String>.from(
                    ejercicio.data["respuestasCorrectas"]),
                onNext: (correcto) =>
                    _siguiente(ejercicios, correcto: correcto),
              );
            case TipoEjercicio.escritura:
              return NivelEscrituraScreen(
                key: ValueKey(_indiceActual),
                pregunta: ejercicio.data["pregunta"],
                imagenPath: ejercicio.data["imagenPath"],
                respuestaCorrecta: ejercicio.data["respuestaCorrecta"],
                onNext: (correcto) =>
                    _siguiente(ejercicios, correcto: correcto),
              );
            case TipoEjercicio.presentacion:
              return NivelPresentacionScreen(
                key: ValueKey(_indiceActual),
                textos: List<String>.from(ejercicio.data["textos"]),
                imagenesSmall:
                    List<String>.from(ejercicio.data["imagenesSmall"]),
                imagenesBig: List<String>.from(ejercicio.data["imagenesBig"]),
                onNext: () => _siguiente(ejercicios), // No cuenta como puntaje
              );
            case TipoEjercicio.lectura:
              return NivelLecturaScreen(
                key: ValueKey(_indiceActual),
                titulo: ejercicio.data["titulo"],
                texto: ejercicio.data["texto"],
                onNext: () => _siguiente(ejercicios), // No cuenta como puntaje
              );
            case TipoEjercicio.historia:
              return NivelHistoriaScreen(
                key: ValueKey(_indiceActual),
                dialogos: (ejercicio.data["dialogos"] as List)
                    .map((item) => Map<String, String>.from(item))
                    .toList(),
                onNext: () => _siguiente(ejercicios), // No cuenta como puntaje
              );
            case TipoEjercicio.opcionmultiple:
              return NivelOpcionMultipleScreen(
                key: ValueKey(_indiceActual),
                instruccion: ejercicio.data["instruccion"],
                imagenSena: ejercicio.data["imagenSena"],
                opciones: List<String>.from(ejercicio.data["opciones"]),
                respuestaCorrecta: ejercicio.data["respuestaCorrecta"],
                onNext: (correcto) =>
                    _siguiente(ejercicios, correcto: correcto),
              );

            default:
              return const Scaffold(
                  body: Center(child: Text("Tipo de ejercicio no reconocido")));
          }
        } catch (e) {
          return Scaffold(
              body:
                  Center(child: Text("Error en los datos del ejercicio: $e")));
        }
      },
    );
  }
}
