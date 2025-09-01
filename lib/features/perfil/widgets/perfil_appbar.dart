import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';

class TPerfilAppBar extends StatelessWidget {
  const TPerfilAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.perfilAppBarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: Colors.blueGrey),
          ),
          Text(
            TTexts.perfilAppBarSubTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
