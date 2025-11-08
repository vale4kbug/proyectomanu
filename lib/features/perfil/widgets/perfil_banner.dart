import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart'; // Importa tus imágenes

class PerfilBannerWidget extends StatelessWidget {
  final String nombre;
  final String usuario;
  final String fotoUrl;
  final int estrellas;
  final int niveles;
  final int logrosTotales;
  final int logrosDesbloqueados;

  const PerfilBannerWidget({
    super.key,
    required this.nombre,
    required this.usuario,
    required this.fotoUrl,
    required this.estrellas,
    required this.niveles,
    required this.logrosTotales,
    required this.logrosDesbloqueados,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage =
        fotoUrl.startsWith('http') || fotoUrl.startsWith('https');

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              TColors.primaryColor,
              TColors.primarioBoton,
              TColors.textSecondary
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey.shade300,
                child: isNetworkImage
                    ? Image.network(
                        fotoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => _ErrorAvatar(),
                      )
                    : Image.asset(
                        fotoUrl.isNotEmpty ? fotoUrl : TImages.imagenperfil,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => _ErrorAvatar(),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            Text(nombre,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none)),
            Text('@$usuario',
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    decoration: TextDecoration.none)),
            const SizedBox(height: 20),
            const Divider(color: Colors.white38, thickness: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                    icon: Iconsax.magic_star5,
                    label: "Estrellas",
                    value: estrellas.toString(),
                    color: const Color.fromARGB(255, 255, 186, 58)),
                _StatItem(
                    icon: Iconsax.game5,
                    label: "Niveles",
                    value: niveles.toString(),
                    color: const Color.fromARGB(255, 61, 58, 255)),
                _StatItem(
                    icon: Iconsax.medal_star5,
                    label: "Logros",
                    value: "$logrosDesbloqueados/$logrosTotales",
                    color: const Color.fromARGB(255, 133, 58, 255)),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              "Compartido desde Manolingo ᗧ(｡◝‿◜｡)ᗤ",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      TImages.imagenperfil, // Carga la imagen por defecto
      fit: BoxFit.cover,
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none)),
        Text(label,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                decoration: TextDecoration.none)),
      ],
    );
  }
}
