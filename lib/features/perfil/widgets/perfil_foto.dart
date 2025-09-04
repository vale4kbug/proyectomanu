import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TPerfilFoto extends StatelessWidget {
  const TPerfilFoto({super.key, this.imageUrl, this.onEdit});

  final String? imageUrl;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            child: imageUrl == null
                ? const Icon(Iconsax.user, size: 50, color: Colors.white)
                : null,
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEdit,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue, // fondo del botón
                child: const Icon(
                  Iconsax.edit_2,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
