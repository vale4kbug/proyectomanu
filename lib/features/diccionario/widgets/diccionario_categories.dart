import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/image_Text_widgets/vertical_image_text.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';

class TDiccionarioCategories extends StatelessWidget {
  const TDiccionarioCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            image: TImages.imagenperfil,
            title: 'ABCdario',
            textColor: const Color.fromARGB(255, 15, 114, 88),
            onTap: () {},
          );
        },
      ),
    );
  }
}
