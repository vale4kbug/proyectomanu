import 'package:flutter/material.dart';
import 'package:proyectomanu/features/perfil/widgets/achievement_card.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class TLogrosDisplayPerfil extends StatelessWidget {
  const TLogrosDisplayPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,

      childAspectRatio: .85,
      children: const [
        TAchievementCard(
          image: TImages.logro1,
          title: TTexts.logroTitulo1,
          subtitle: TTexts.logroSubTitulo1,
          locked: false,
        ),
        TAchievementCard(
          image: TImages.logro2,
          title: TTexts.logroTitulo2,
          subtitle: TTexts.logroSubTitulo2,
          locked: true,
        ),
        TAchievementCard(
          image: TImages.logro3,
          title: TTexts.logroTitulo3,
          subtitle: TTexts.logroSubTitulo3,

          locked: false,
        ),
        TAchievementCard(
          image: TImages.logro4,
          title: TTexts.logroTitulo4,
          subtitle: TTexts.logroSubTitulo4,

          locked: false,
        ),
      ],
    );
  }
}
