import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/imagen_container.dart';
import 'package:proyectomanu/features/ejercicios/widgets/dialogo_burbuja.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class NivelPresentacionScreen extends StatefulWidget {
  const NivelPresentacionScreen({
    super.key,
    required this.textos,
    required this.imagenesSmall,
    required this.imagenesBig,
    required this.onNext,
    this.colorBurbuja = Colors.blue,
    this.tailPosition = BubbleTailPosition.left,
  });

  final List<String> textos;
  final List<String> imagenesSmall;
  final List<String> imagenesBig;
  final VoidCallback onNext;
  final Color colorBurbuja;
  final BubbleTailPosition tailPosition;

  @override
  State<NivelPresentacionScreen> createState() =>
      _NivelPresentacionScreenState();
}

class _NivelPresentacionScreenState extends State<NivelPresentacionScreen> {
  int currentIndex = 0;

  // 1. Variable para guardar la altura calculada
  double? _alturaEstimadaBurbuja;

  @override
  void initState() {
    super.initState();
    // No calculamos la altura aquí
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 2. Calcula la altura máxima solo una vez, cuando el contexto esté listo
    if (_alturaEstimadaBurbuja == null) {
      _calcularAlturaMaxima();
    }
  }

  /// 3. Encuentra el texto más largo y calcula su altura
  void _calcularAlturaMaxima() {
    if (widget.textos.isEmpty) {
      setState(() => _alturaEstimadaBurbuja = 150.0); // Altura de fallback
      return;
    }

    // Encuentra el texto más largo de la lista
    String textoMasLargo =
        widget.textos.reduce((a, b) => a.length > b.length ? a : b);

    // Calcula la altura para ese texto
    final altura = _calcularAlturaEstimadaTexto(context, textoMasLargo);

    setState(() {
      _alturaEstimadaBurbuja = altura;
    });
  }

  /// 4. Método de cálculo de altura (adaptado de tu otra clase)
  /// NOTA: Esta función asume el estilo de texto DENTRO de DialogoBurbujaPersonaje.
  /// Si el estilo es diferente, deberás ajustarlo aquí.
  double _calcularAlturaEstimadaTexto(BuildContext context, String texto) {
    // ASUME el estilo de texto usado dentro de DialogoBurbujaPersonaje
    final textStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white);
    if (textStyle == null) {
      return 150.0; // Altura de fallback
    }

    final screenWidth = MediaQuery.of(context).size.width;

    // Ancho de la pantalla MENOS el padding de esta pantalla (12*2)
    // MENOS el padding horizontal INTERNO de la burbuja (asumimos TSizes.md * 2)
    // MENOS el ancho de la imagen 'small' (asumimos 60) y su padding
    final double anchoImagenSmall = 60.0;
    final double paddingTotal =
        (12.0 * 2) + (TSizes.md * 2) + anchoImagenSmall + (TSizes.sm * 2);
    final textMaxWidth = screenWidth - paddingTotal;

    final textPainter = TextPainter(
      text: TextSpan(text: texto, style: textStyle),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: textMaxWidth);

    // Devuelve la altura del texto + padding vertical (asumimos TSizes.md * 2)
    // o un mínimo de 80 (altura de la imagen)
    final double alturaTextoCalculada = textPainter.height + (TSizes.md * 2);
    return alturaTextoCalculada > 80.0 ? alturaTextoCalculada : 80.0;
  }

  // --- FIN DE LA LÓGICA DE ALTURA ---

  void _siguiente() {
    if (currentIndex < widget.textos.length - 1) {
      setState(() => currentIndex++);
    } else {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: _alturaEstimadaBurbuja,
              child: DialogoBurbujaPersonaje(
                texto: widget.textos[currentIndex],
                imagenSmall: widget.imagenesSmall[currentIndex],
                colorburbuja: widget.colorBurbuja,
                tailPosition: widget.tailPosition,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 3),
            ImagenContainer(
              imagen: widget.imagenesBig[currentIndex],
              height: 450,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _siguiente,
                label: Text(
                  currentIndex < widget.textos.length - 1
                      ? TTexts.botonSiguiente
                      : TTexts.botonContinuar,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
