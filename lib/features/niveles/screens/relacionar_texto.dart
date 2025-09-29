import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelOpcionMultipleScreen extends StatefulWidget {
  const NivelOpcionMultipleScreen({
    super.key,
    required this.instruccion,
    required this.imagenSena,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.onNext,
  });

  final String instruccion;
  final String imagenSena;
  final List<String> opciones;
  final String respuestaCorrecta;
  final void Function(bool correcto) onNext;

  @override
  State<NivelOpcionMultipleScreen> createState() =>
      _NivelOpcionMultipleScreenState();
}

class _NivelOpcionMultipleScreenState extends State<NivelOpcionMultipleScreen> {
  String? seleccion;
  bool respondido = false;

  void _seleccionarRespuesta(String opcion) {
    if (!respondido) {
      setState(() {
        seleccion = opcion;
        respondido = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final esCorrecta = seleccion == widget.respuestaCorrecta;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Instrucción
            Text(
              widget.instruccion,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Imagen
            Image.asset(widget.imagenSena, height: 200),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Opciones en grid 3x2
            Expanded(
              child: GridView.builder(
                itemCount: widget.opciones.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  final opcion = widget.opciones[index];
                  final seleccionada = opcion == seleccion;

                  final color = !respondido
                      ? TColors.primarioBoton
                      : (opcion == widget.respuestaCorrecta
                          ? Colors.green
                          : (seleccionada ? Colors.red : Colors.grey));

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _seleccionarRespuesta(opcion),
                    child: Text(opcion, textAlign: TextAlign.center),
                  );
                },
              ),
            ),

            /// Feedback
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

            const SizedBox(height: TSizes.spaceBtwItems),

            /// Botón siguiente
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
    );
  }
}
