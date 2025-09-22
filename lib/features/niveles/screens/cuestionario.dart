import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelCuestionarioScreen extends StatefulWidget {
  const NivelCuestionarioScreen({
    super.key,
    required this.pregunta,
    required this.imagenPath,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.nextScreen,
  });

  final String pregunta;
  final String imagenPath;
  final List<String> opciones;
  final String respuestaCorrecta;
  final Widget nextScreen;

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

    return Scaffold(
      appBar: AppBar(title: const Text("Nivel - Pregunta")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(widget.pregunta,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),

            const SizedBox(height: 20),
            Image.asset(widget.imagenPath, height: 180),

            const SizedBox(height: 20),

            /// Opciones
            Column(
              children: widget.opciones.map((opcion) {
                final seleccionada = opcion == respuestaSeleccionada;
                final color = !respondido
                    ? Colors.blue
                    : (opcion == widget.respuestaCorrecta
                        ? Colors.green
                        : (seleccionada ? Colors.red : Colors.grey));

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => _seleccionarRespuesta(opcion),
                    child: Text(opcion),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            if (respondido)
              AnimatedOpacity(
                opacity: respondido ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: AnimatedScale(
                  scale: respondido ? 1.0 : 0.8,
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    esCorrecta ? "✅ ¡Correcto!" : "❌ Incorrecto",
                    style: TextStyle(
                      fontSize: 18,
                      color: esCorrecta ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            const Spacer(),

            if (respondido)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => widget.nextScreen),
                  child: const Text("Siguiente"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
