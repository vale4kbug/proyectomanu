import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

class EjercicioAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EjercicioAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Iconsax.close_circle, size: 28),
          onPressed: () => mostrarAlertaSalida(context),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  static Future<bool> mostrarAlertaSalida(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "¿Salir del nivel?",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: TColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        content: Text(
          "Perderás tu progreso si sales ahora. ¿Estás seguro?",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              "Cancelar",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Salir", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      Get.back();
      return true;
    }
    return false;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
