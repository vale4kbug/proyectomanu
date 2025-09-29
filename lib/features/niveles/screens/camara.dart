import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

//PENDIENTE
class NivelCamaraScreen extends StatefulWidget {
  const NivelCamaraScreen({
    super.key,
    required this.senaObjetivo,
    required this.onNext,
  });

  final String senaObjetivo;
  final void Function(bool correcto) onNext;

  @override
  State<NivelCamaraScreen> createState() => _NivelCamaraScreenState();
}

class _NivelCamaraScreenState extends State<NivelCamaraScreen> {
  CameraController? _controller;
  bool _detectando = true;
  bool _detectadoCorrecto = false;
  bool _mostrarGifAyuda = false;

  @override
  void initState() {
    super.initState();
    _inicializarCamara();

    // Mostrar ayuda si después de 5 segundos no detecta nada
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !_detectadoCorrecto) {
        setState(() => _mostrarGifAyuda = true);
      }
    });
  }

  Future<void> _inicializarCamara() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    _controller = CameraController(camera, ResolutionPreset.medium);

    await _controller!.initialize();
    if (mounted) {
      setState(() {});
    }

    // Aquí normalmente conectas el stream de imágenes al modelo
    // _controller!.startImageStream((image) {
    //   procesarFrame(image);
    // });
  }

  //  modelo de reconocimiento
  void procesarFrame(CameraImage image) {
    // TODO: Enviar imagen al modelo de reconocimiento de señas
    // Si el modelo devuelve que la seña es la correcta:
    // setState(() {
    //   _detectadoCorrecto = true;
    //   _detectando = false;
    // });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Título
            Text(
              "Replica la siguiente seña:",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Texto de la seña
            Text(
              widget.senaObjetivo,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Recomendación
            Text(
              "📷 Recuerda centrar la cámara",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Cámara
            Expanded(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// GIF de ayuda
            if (_mostrarGifAyuda)
              Image.asset(
                "assets/gifs/${widget.senaObjetivo.toLowerCase()}.gif",
                height: 120,
              ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Botón continuar cuando detecte la seña
            if (_detectadoCorrecto)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => widget.onNext(true),
                  child: Text(TTexts.botonSiguiente),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
