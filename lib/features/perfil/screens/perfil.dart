import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/features/configuracion/screens/configuracion.dart';
import 'package:proyectomanu/features/perfil/services/logros_service.dart';
import 'package:proyectomanu/features/perfil/widgets/circular_image.dart';
import 'package:proyectomanu/features/perfil/widgets/stat_usuario_container.dart';
import 'package:proyectomanu/features/perfil/widgets/achievement_card.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/helpers/helper_functions.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:proyectomanu/features/authentication/screens/login/models/usuario_model.dart';
import 'package:proyectomanu/features/perfil/widgets/perfil_banner.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  List<dynamic> logros = [];
  bool cargando = true;

  final _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    final controller = Get.find<UserController>();
    controller.recargarUsuario(); //
    cargarLogros();
  }

  Future<void> cargarLogros() async {
    try {
      final data = await LogrosService.obtenerLogrosUsuario();
      setState(() {
        logros = data;
        cargando = false;
      });
    } catch (e) {
      setState(() => cargando = false);
    }
  }

// --- FUNCIÓN DE COMPARTIR CORREGIDA ---
  Future<void> _compartirBanner(UsuarioModel usuario) async {
    // Muestra un spinner mientras se genera la imagen
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final int logrosDesbloqueados =
          logros.where((l) => l['desbloqueado'] == true).length;
      final int logrosTotales = logros.length;

      final String fotoParaBanner;
      if (usuario.fotoUrl != null && usuario.fotoUrl!.isNotEmpty) {
        fotoParaBanner = usuario.fotoUrl!;
      } else {
        fotoParaBanner = TImages.imagenperfil;
      }

      final banner = PerfilBannerWidget(
        nombre: usuario.nombre,
        usuario: usuario.nombreUsuario,
        fotoUrl: fotoParaBanner,
        estrellas: usuario.estrellas,
        niveles: usuario.nivelesCompletados,
        logrosTotales: logrosTotales,
        logrosDesbloqueados: logrosDesbloqueados,
      );

      final Uint8List? imageBytes =
          await _screenshotController.captureFromWidget(
        Theme(
          data: Theme.of(context),
          child: banner,
        ),
        delay: const Duration(milliseconds: 1000),
      );

      if (imageBytes == null) throw Exception("No se pudo generar la imagen.");

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/perfil_banner.png')
          .writeAsBytes(imageBytes);

      Get.back();

      await Share.shareXFiles(
        [XFile(file.path)],
        text: "¡Mira mi progreso en Manolingo ᗧ(｡◝‿◜｡)ᗤ!",
      );
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "No se pudo generar el banner: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.find<UserController>();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value && controller.usuario.value == null) {
          return const Center(
            heightFactor: 15,
            child: CircularProgressIndicator(),
          );
        }

        if (controller.usuario.value == null) {
          return const Center(
            heightFactor: 15,
            child: Text("No se pudo cargar el perfil."),
          );
        }

        final usuario = controller.usuario.value!;

        return SingleChildScrollView(
          child: Column(
            children: [
              TPrimaryHeaderContainer(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        TCircularImage(
                          image: usuario.fotoUrl ?? TImages.imagenperfil,
                          width: 135,
                          height: 135,
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections / 3),
                        Center(
                          child: Text(
                            usuario.nombreUsuario,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .apply(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: IconButton(
                        icon:
                            const Icon(Iconsax.setting5, color: TColors.light),
                        onPressed: () =>
                            Get.to(() => const ConfiguracionScreen()),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections / 2),
              Center(
                child: Text(
                  TTexts.perfilEstadisticaTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.primarioBoton),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // === Estadísticas del usuario ===
              TStatUsuarioContainer(
                dark: dark,
                title: TTexts.perfilEstrellas,
                subtitle: usuario.estrellas.toString(),
                icon: Iconsax.magic_star5,
                iconColor: const Color.fromARGB(255, 255, 186, 58),
              ),
              TStatUsuarioContainer(
                dark: dark,
                title: TTexts.perfilNiveles,
                subtitle: usuario.nivelesCompletados.toString(),
                icon: Iconsax.game5,
                iconColor: const Color.fromARGB(255, 61, 58, 255),
              ),
              TStatUsuarioContainer(
                dark: dark,
                title: TTexts.perfilLogros,
                subtitle:
                    '${logros.where((l) => l['desbloqueado'] == true).length} / ${logros.length}',
                icon: Iconsax.medal_star5,
                iconColor: const Color.fromARGB(255, 133, 58, 255),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              // === Sección de Logros ===
              Center(
                child: Text(
                  TTexts.perfilLogrosTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.primarioBoton),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              if (cargando)
                const Center(child: CircularProgressIndicator())
              else if (logros.isEmpty)
                const Center(child: Text("No tienes logros aún 😢"))
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: logros.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final logro = logros[index];
                    return TAchievementCard(
                      image: logro['img'] ?? 'assets/images/logros/default.png',
                      title: logro['nombre'] ?? 'Sin título',
                      subtitle: logro['descripcion'] ?? '',
                      locked: !(logro['desbloqueado'] ?? false),
                    );
                  },
                ),

              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    // --- 3. CONECTA EL BOTÓN ---
                    onPressed: () async {
                      await _compartirBanner(usuario);
                    },
                    label: const Text(TTexts.perfilCompartir),
                    icon: const Icon(Iconsax.send_2),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
