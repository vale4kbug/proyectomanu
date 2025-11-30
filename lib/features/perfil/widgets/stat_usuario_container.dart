import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class TStatUsuarioContainer extends StatelessWidget {
  const TStatUsuarioContainer({
    super.key,
    required this.dark,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor,
    this.backgroundColor = const Color.fromARGB(255, 214, 238, 251),
  });

  final bool dark;
  final IconData icon;
  final String title, subtitle;
  final Color? iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      margin: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems / 2,
      ),
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: dark ? TColors.fantasmaBoton : backgroundColor,
      borderColor: TColors.primarioBoton,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              TSectionHeading(
                title: title,
                showActionButton: false,
                textColor: dark ? Colors.white : TColors.primaryColor,
              ),
            ],
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: dark ? Colors.white : TColors.primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
