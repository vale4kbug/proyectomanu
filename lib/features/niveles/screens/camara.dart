import 'dart:math' as math;
import 'dart:async'; // Necesario para el Timer
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img_lib;
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

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
  bool _detectadoCorrecto = false;
  bool _mostrarGifAyuda = false;
  bool _isProcessing = false;
  Timer? _helpTimer; // <-- MEJORA: Usamos un Timer para poder cancelarlo

  final String apiUrl = "http://10.0.2.2:5000/predict";

  @override
  void initState() {
    super.initState();
    _inicializarCamara();

    // <-- El GIF de ayuda ahora se activa después de 1 minuto
    _helpTimer = Timer(const Duration(seconds: 60), () {
      if (mounted && !_detectadoCorrecto) {
        setState(() => _mostrarGifAyuda = true);
      }
    });
  }

  @override
  void dispose() {
    _helpTimer?.cancel(); // <-- MEJORA: Cancelamos el timer para evitar errores
    _controller?.stopImageStream();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _inicializarCamara() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();
      if (!mounted) return;
      setState(() {});

      _controller!.startImageStream((image) {
        if (!_isProcessing) {
          procesarFrame(image);
        }
      });
    } catch (e) {
      print("Error al inicializar la cámara: $e");
    }
  }

  Future<void> procesarFrame(CameraImage image) async {
    _isProcessing = true;
    try {
      img_lib.Image? convertedImage;
      if (image.format.group == ImageFormatGroup.bgra8888) {
        convertedImage = img_lib.Image.fromBytes(
          width: image.width,
          height: image.height,
          bytes: image.planes[0].bytes.buffer,
          order: img_lib.ChannelOrder.bgra,
        );
      } else if (image.format.group == ImageFormatGroup.yuv420) {
        final img = img_lib.Image(width: image.width, height: image.height);
        for (int y = 0; y < image.height; y++) {
          for (int x = 0; x < image.width; x++) {
            final int uvIndex =
                image.planes[1].bytesPerRow * (y >> 1) + (x >> 1);
            final int index = y * image.width + x;
            final yp = image.planes[0].bytes[index];
            final up = image.planes[1].bytes[uvIndex];
            final vp = image.planes[2].bytes[uvIndex];
            int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
            int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
                .round()
                .clamp(0, 255);
            int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
            img.setPixelRgba(x, y, r, g, b, 255);
          }
        }
        convertedImage = img;
      }

      if (convertedImage != null) {
        List<int> jpgBytes = img_lib.encodeJpg(convertedImage);
        String base64Image = base64Encode(jpgBytes);

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'image': base64Image}),
        );

        if (mounted && response.statusCode == 200) {
          final result = jsonDecode(response.body);
          String prediccion = result['prediction'] ?? 'Error';
          print("Predicción del modelo: $prediccion");

          if (prediccion.trim().toLowerCase() ==
              widget.senaObjetivo.trim().toLowerCase()) {
            _helpTimer
                ?.cancel(); // <-- MEJORA: Si acierta, cancelamos el timer de ayuda
            setState(() {
              _detectadoCorrecto = true;
            });
            _controller?.stopImageStream();
          }
        }
      }
    } catch (e) {
      print("Error al procesar el frame: $e");
    } finally {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        _isProcessing = false;
      }
    }
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
            Text(
              "Replica la siguiente seña:",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              widget.senaObjetivo,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              "📷 Recuerda centrar la cámara",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // --- MEJORA: Envolvemos la cámara en un Stack para superponer el indicador ---
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Capa 1: La Cámara (con corrección de rotación)
                  AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: _controller!.description.lensDirection ==
                              CameraLensDirection.front
                          ? Matrix4.rotationY(
                              math.pi) // Corrige el espejo de la cámara frontal
                          : Matrix4.identity(),
                      child: CameraPreview(_controller!),
                    ),
                  ),

                  // Capa 2: El Indicador de Éxito (solo aparece si es correcto)
                  if (_detectadoCorrecto)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline,
                              color: Colors.white, size: 80),
                          SizedBox(height: 16),
                          Text(
                            "¡Correcto!",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            if (_mostrarGifAyuda)
              Image.asset(
                "assets/gifs/${widget.senaObjetivo.toLowerCase().replaceAll(' ', '_')}.gif",
                height: 120,
              ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // El botón de "Siguiente" ahora aparece debajo del indicador verde
            if (_detectadoCorrecto)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => widget.onNext(true),
                  child: const Text(TTexts.botonSiguiente),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
