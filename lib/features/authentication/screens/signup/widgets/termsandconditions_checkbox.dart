import 'package:flutter/material.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/helpers/helper_functions.dart';

class TTermsandConditionsForm extends StatelessWidget {
  const TTermsandConditionsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(value: true, onChanged: (value) {}),
            ),
            const SizedBox(width: TSizes.spaceBtwSections),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${TTexts.iAgreeTo} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: TTexts.privacyPolicy,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.light : TColors.primarioBoton,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: ' ${TTexts.and} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: TTexts.termsofUse,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.light : TColors.primarioBoton,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
