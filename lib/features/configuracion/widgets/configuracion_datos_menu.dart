import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class TConfigDatosMenu extends StatelessWidget {
  const TConfigDatosMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    required this.title,
    required this.subTitle,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: Icon(icon, size: 18)),
          ],
        ),
      ),
    );
  }
}
