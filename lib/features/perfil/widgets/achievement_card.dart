import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class TAchievementCard extends StatelessWidget {
  const TAchievementCard({
    super.key,
    required this.image,
    required this.title,
    this.locked = false,
    required this.subtitle,
  });

  final String image;
  final String title, subtitle;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    height: 90, // 🔹 Reducido para dar más espacio al texto
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (locked)
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(80, 0, 0, 0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      const Icon(Iconsax.lock, color: Colors.white, size: 26),
                ),
            ],
          ),

          const SizedBox(height: 4),

          /// 🔥 Este bloque ya NO hace overflow
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 2),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
