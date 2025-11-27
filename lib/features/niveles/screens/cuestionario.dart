import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar_ejercicios.dart';

import 'package:proyectomanu/utils/constants/colors.dart';

import 'package:proyectomanu/utils/constants/sizes.dart';

import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelCuestionarioScreen extends StatefulWidget {
  const NivelCuestionarioScreen({
    super.key,
    required this.pregunta,
    required this.imagenPath,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.onNext,
  });

  final String pregunta;

  final String imagenPath;

  final List<String> opciones;

  final String respuestaCorrecta;

  final void Function(bool correcto) onNext;

  @override
  State<NivelCuestionarioScreen> createState() =>
      _NivelCuestionarioScreenState();
}

class _NivelCuestionarioScreenState extends State<NivelCuestionarioScreen> {
  String? respuestaSeleccionada;

  bool respondido = false;

  void _seleccionarRespuesta(String opcion) {
    if (!respondido) {
      setState(() {
        respuestaSeleccionada = opcion;

        respondido = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final esCorrecta = respuestaSeleccionada == widget.respuestaCorrecta;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        // Reutilizamos la lógica que escribimos en la AppBar
        await EjercicioAppBar.mostrarAlertaSalida(context);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// Pregunta

              Text(
                widget.pregunta,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Imagen

              Image.asset(widget.imagenPath, height: 230),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Opciones

              ...widget.opciones.map((opcion) {
                final seleccionada = opcion == respuestaSeleccionada;

                final color = !respondido
                    ? TColors.primarioBoton
                    : (opcion == widget.respuestaCorrecta
                        ? Colors.green
                        : (seleccionada ? Colors.red : Colors.grey));

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _seleccionarRespuesta(opcion),
                    child: Text(
                      opcion,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Mensaje feedback

              if (respondido)
                Text(
                  esCorrecta
                      ? TTexts.obtenerMensajeCorrecto()
                      : TTexts.obtenerMensajeIncorrecto(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: esCorrecta ? Colors.green : Colors.red,
                  ),
                ),

              const Spacer(),

              /// boton siguiente

              if (respondido)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => widget.onNext(esCorrecta),
                    child: Text(TTexts.botonSiguiente),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
