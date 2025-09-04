import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:proyectomanu/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        width: double.infinity,
        height: 250,
        color: TColors.primarioBoton,
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -150,
              child: TCircularContainer(
                backgroundColor: const Color.fromARGB(255, 255, 186, 58),
                width: 300,
                height: 300,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
