import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelHistoriaScreen extends StatefulWidget {
  const NivelHistoriaScreen({
    super.key,
    required this.dialogos,
    required this.onNext,
  });

  final List<Map<String, String>> dialogos;
  final VoidCallback onNext;

  @override
  State<NivelHistoriaScreen> createState() => _NivelHistoriaScreenState();
}

class _NivelHistoriaScreenState extends State<NivelHistoriaScreen> {
  int _indice = 0;
  String _textoVisible = "";
  Timer? _timer;
  bool _completo = false; // Si ya se terminó de mostrar el texto

  @override
  void initState() {
    super.initState();
    _iniciarAnimacion();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _iniciarAnimacion() {
    _textoVisible = "";
    _completo = false;
    final texto = widget.dialogos[_indice]["texto"] ?? "";

    int i = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (i < texto.length) {
        setState(() {
          _textoVisible += texto[i];
        });
        i++;
      } else {
        _completo = true;
        timer.cancel();
      }
    });
  }

  void _siguiente() {
    if (!_completo) {
      // Si aún no terminó, mostrar todo el texto de golpe
      setState(() {
        _textoVisible = widget.dialogos[_indice]["texto"] ?? "";
        _completo = true;
      });
      _timer?.cancel();
    } else if (_indice < widget.dialogos.length - 1) {
      setState(() {
        _indice++;
      });
      _iniciarAnimacion();
    } else {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final actual = widget.dialogos[_indice];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// Fondo
          Image.asset(
            actual["fondo"]!,
            fit: BoxFit.cover,
          ),

          /// Personaje
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              actual["personaje"]!,
              height: 500,
              fit: BoxFit.contain,
            ),
          ),

          /// Cuadro de diálogo
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(127, 255, 186, 58),
                borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    actual["nombre"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: TSizes.fontSizeMD,
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),

                  /// Texto con efecto máquina de escribir
                  Text(
                    _textoVisible,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: TSizes.fontSizeSM,
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: _siguiente,
                        child: _completo
                            ? Text(TTexts.botonSiguiente)
                            : const Icon(Iconsax.arrow_right_3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
