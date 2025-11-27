import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Usaremos http para la API de Python
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar_ejercicios.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

// --- SERVICIO PARA HABLAR CON LA API DE PYTHON ---
// (Puedes mover esto a su propio archivo de servicio si prefieres)
class PythonRecognitionService {
  // Asegúrate de que esta sea la URL de tu API de Python
  static const String pythonApiUrl = "http://10.0.2.2:5000/predict";

  static Future<Map<String, dynamic>> predictGesture(String base64Image) async {
    try {
      final response = await http
          .post(
            Uri.parse(pythonApiUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'image': base64Image}),
          )
          .timeout(const Duration(seconds: 15)); // Timeout de 15 segundos

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Error del servidor de IA (código: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception(
          'No se pudo conectar al servicio de IA. ¿Está corriendo?');
    }
  }
}

class NivelCamaraScreen extends StatefulWidget {
  const NivelCamaraScreen({
    super.key,
    required this.senaObjetivo,
    required this.onNext,
  });

  final String senaObjetivo;
  final void Function(bool? correcto) onNext;

  @override
  State<NivelCamaraScreen> createState() => _NivelCamaraScreenState();
}

class _NivelCamaraScreenState extends State<NivelCamaraScreen> {
  CameraController? _controller;
  XFile? _capturedImage;
  bool _isProcessing = false;
  String? _predictionResult;

  @override
  void initState() {
    super.initState();
    _inicializarCamara();
  }

  @override
  void dispose() {
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
        ResolutionPreset.high, // Usamos alta resolución para mejor precisión
        enableAudio: false,
      );

      await _controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      Get.snackbar("Error de Cámara", "No se pudo iniciar la cámara.");
    }
  }

  Future<void> _takePictureAndEvaluate() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      final image = await _controller!.takePicture();
      final imageBytes = await image.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      final result = await PythonRecognitionService.predictGesture(base64Image);
      final String detectedGesture = result['prediction'] ?? "desconocido";

      setState(() {
        _capturedImage = image;
        _predictionResult = detectedGesture;
      });
    } catch (e) {
      Get.snackbar(
          "Error de Evaluación", e.toString().replaceFirst("Exception: ", ""),
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _reset() {
    setState(() {
      _capturedImage = null;
      _predictionResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final bool isCorrect = _predictionResult?.trim().toLowerCase() ==
        widget.senaObjetivo.trim().toLowerCase();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        // Reutilizamos la lógica que escribimos en la AppBar
        await EjercicioAppBar.mostrarAlertaSalida(context);
      },
      child: Scaffold(
        appBar: const TAppBar(
            showBackArrow: true, title: Text("Ejercicio de Cámara")),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Text("Replica la siguiente seña:",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(widget.senaObjetivo,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: TColors.primaryColor)),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Contenedor para la vista previa de la cámara o la imagen capturada
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Capa 1: La cámara o la foto tomada
                      _capturedImage == null
                          ? Transform.scale(
                              scaleX:
                                  -1, // Corrige el efecto espejo de la cámara frontal
                              child: CameraPreview(_controller!),
                            )
                          : Image.file(
                              File(_capturedImage!.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),

                      // Capa 2: Overlay de feedback (Correcto/Incorrecto)
                      if (_predictionResult != null)
                        Container(
                          decoration: BoxDecoration(
                              color: (isCorrect ? Colors.green : Colors.red)
                                  .withOpacity(0.7)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                    isCorrect
                                        ? Iconsax.tick_circle
                                        : Iconsax.close_circle,
                                    color: Colors.white,
                                    size: 80),
                                const SizedBox(height: 16),
                                Text(
                                    isCorrect
                                        ? "¡Correcto!"
                                        : "Intenta de nuevo",
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                if (!isCorrect)
                                  Text(
                                    "Detectado: $_predictionResult",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // --- Lógica de Botones ---
              if (_capturedImage == null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : _takePictureAndEvaluate,
                    icon: _isProcessing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Icon(Iconsax.camera),
                    label: Text(
                        _isProcessing ? "Procesando..." : "Evaluar Mi Seña"),
                  ),
                )
              else if (isCorrect)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => widget.onNext(true),
                      child: const Text(TTexts.botonSiguiente)),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      child: const Text("Volver a Intentar")),
                ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),

              // Botón de Saltar, visible si aún no has acertado
              if (!isCorrect)
                TextButton(
                  onPressed: () => widget.onNext(null), // Envía null (neutral)
                  child: const Text("Saltar ejercicio"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
