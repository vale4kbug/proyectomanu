import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar_ejercicios.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelEscrituraScreen extends StatefulWidget {
  const NivelEscrituraScreen({
    super.key,
    required this.pregunta,
    required this.imagenPath,
    required this.respuestaCorrecta,
    required this.onNext,
  });

  final String pregunta;
  final String imagenPath;
  final String respuestaCorrecta;
  final void Function(bool correcto) onNext;

  @override
  State<NivelEscrituraScreen> createState() => _NivelEscrituraScreenState();
}

class _NivelEscrituraScreenState extends State<NivelEscrituraScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _respondido = false;
  bool _esCorrecto = false;

  String _normalizar(String texto) {
    final withDecomposed = texto.toLowerCase().characters.toString();
    //  RegExp para quitar diacríticos
    final normalized = withDecomposed
        .replaceAll(RegExp(r'[áàäâ]'), 'a')
        .replaceAll(RegExp(r'[éèëê]'), 'e')
        .replaceAll(RegExp(r'[íìïî]'), 'i')
        .replaceAll(RegExp(r'[óòöô]'), 'o')
        .replaceAll(RegExp(r'[úùüû]'), 'u');
    return normalized;
  }

  void _validarRespuesta() {
    final respuesta = _normalizar(_controller.text.trim());
    final correcta = _normalizar(widget.respuestaCorrecta.trim());

    setState(() {
      _esCorrecto = respuesta == correcta;
      _respondido = true;
    });
  }

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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            children: [
              Text(
                widget.pregunta,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 3),
              Image.asset(widget.imagenPath, height: 300),
              const SizedBox(height: TSizes.spaceBtwSections * 3),
              TextField(
                controller: _controller,
                enabled: !_respondido,
                decoration: InputDecoration(
                  labelText: TTexts.nivelEscribirInstruccion,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                  ),
                ),
                onSubmitted: (_) => _validarRespuesta(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              if (!_respondido)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _validarRespuesta,
                    child: const Text(TTexts.nivelEscribirBoton),
                  ),
                ),
              if (_respondido)
                Column(
                  children: [
                    Text(
                      _esCorrecto
                          ? TTexts.obtenerMensajeCorrecto()
                          : TTexts.obtenerMensajeIncorrecto(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _esCorrecto ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => widget.onNext(_esCorrecto),
                        child: Text(TTexts.botonSiguiente),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
