import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';

class TPerfilAppBar extends StatelessWidget {
  const TPerfilAppBar({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.apply(color: Colors.white),
          ),
        ],
      ),
      actions: const [], // 👈 ya vacío
    );
  }
}
