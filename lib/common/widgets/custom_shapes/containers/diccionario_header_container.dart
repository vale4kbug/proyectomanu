import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';

class TDiccionarioHeaderContainer extends StatelessWidget {
  const TDiccionarioHeaderContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        width: double.infinity,
        height: 240,
        color: const Color.fromARGB(188, 133, 255, 144),
        child: Stack(children: [child]),
      ),
    );
  }
}
