import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar_ejercicios.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelRelacionScreen extends StatefulWidget {
  const NivelRelacionScreen({
    super.key,
    required this.imagenes,
    required this.palabras,
    required this.respuestasCorrectas,
    required this.onNext,
  });

  final List<String> imagenes; // paths de imágenes
  final List<String> palabras; // palabras a mostrar
  final Map<String, String>
      respuestasCorrectas; // {imagenPath: palabraCorrecta}
  final void Function(bool correcto) onNext;

  @override
  State<NivelRelacionScreen> createState() => _NivelRelacionScreenState();
}

class _NivelRelacionScreenState extends State<NivelRelacionScreen> {
  final Map<String, String?> _emparejamientos = {}; // {imagen: palabra}
  String? _palabraSeleccionada;
  bool _respondido = false;

  void _seleccionarPalabra(String palabra) {
    if (!_respondido) {
      setState(() {
        _palabraSeleccionada = palabra;
      });
    }
  }

  void _emparejar(String imagen) {
    if (_palabraSeleccionada != null && !_respondido) {
      setState(() {
        _emparejamientos[imagen] = _palabraSeleccionada;
        _palabraSeleccionada = null;
      });
    }
  }

  bool get _completo =>
      _emparejamientos.length == widget.imagenes.length &&
      !_emparejamientos.values.contains(null);

  @override
  Widget build(BuildContext context) {
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
              Text(
                TTexts.nivelRelacionarTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// columnas
              Expanded(
                child: Row(
                  children: [
                    /// palabras
                    Expanded(
                      child: ListView(
                        children: widget.palabras.map((palabra) {
                          final seleccionada = _palabraSeleccionada == palabra;
                          return GestureDetector(
                            onTap: () => _seleccionarPalabra(palabra),
                            child: Container(
                              height: 130, // altura uniforme
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: seleccionada
                                    ? Color.fromARGB(255, 249, 209, 136)
                                    : Color.fromARGB(255, 255, 230, 183),
                                border: Border.all(
                                  color: Color.fromARGB(255, 255, 186, 58),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  palabra,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(width: TSizes.spaceBtwItems),

                    /// imgs
                    Expanded(
                      child: ListView(
                        children: widget.imagenes.map((img) {
                          final palabraAsignada = _emparejamientos[img];
                          final esCorrecto = _respondido &&
                              palabraAsignada ==
                                  widget.respuestasCorrectas[img];
                          final esIncorrecto = _respondido &&
                              palabraAsignada != null &&
                              palabraAsignada !=
                                  widget.respuestasCorrectas[img];

                          return GestureDetector(
                            onTap: () => _emparejar(img),
                            child: Container(
                              height: 130,
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: esCorrecto
                                    ? Colors.green.shade100
                                    : esIncorrecto
                                        ? Colors.red.shade100
                                        : TColors.intermedioAzul,
                                border: Border.all(
                                  color: esCorrecto
                                      ? Colors.green
                                      : esIncorrecto
                                          ? Colors.red
                                          : TColors.primarioBoton,
                                  width: 2,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(img, height: 80),
                                      if (palabraAsignada != null)
                                        Text(
                                          palabraAsignada,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .apply(
                                                  color: TColors.primaryColor),
                                        ),
                                    ],
                                  ),
                                  if (esCorrecto)
                                    const Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Icon(Icons.check_circle,
                                          color: Colors.green),
                                    ),
                                  if (esIncorrecto)
                                    const Positioned(
                                      top: 4,
                                      right: 4,
                                      child:
                                          Icon(Icons.cancel, color: Colors.red),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              /// BOTÓN siguiente
              if (_completo && !_respondido)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validar
                      bool correcto = true;
                      _emparejamientos.forEach((img, palabra) {
                        if (widget.respuestasCorrectas[img] != palabra) {
                          correcto = false;
                        }
                      });

                      setState(() {
                        _respondido = true;
                      });

                      Future.delayed(const Duration(seconds: 2), () {
                        widget.onNext(correcto);
                      });
                    },
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
