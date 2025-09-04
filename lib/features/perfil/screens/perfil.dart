import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:proyectomanu/features/perfil/widgets/perfil_appbar.dart';
import 'package:proyectomanu/features/perfil/widgets/perfil_foto.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Header verde
          TPrimaryHeaderContainer(
            child: Column(
              children: const [
                TPerfilAppBar(text: TTexts.perfilAppBarSubTitle),
              ],
            ),
          ),

          // Foto y nombre centrados
          Positioned(
            top: 70,
            child: Column(
              children: const [
                TPerfilFoto(imageUrl: TImages.imagenperfil, onEdit: null),
                SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
