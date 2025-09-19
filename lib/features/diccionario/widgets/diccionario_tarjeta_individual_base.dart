import 'package:flutter/material.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/ejercicios/widgets/burbujacolita.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';

class DiccionarioTarjetaIndividual extends StatelessWidget {
  const DiccionarioTarjetaIndividual({
    super.key,
    required this.titulo,
    required this.gifArriba,
    required this.texto,
    required this.gifAbajo,
  });

  final String titulo;
  final String gifArriba;
  final String texto;
  final String gifAbajo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text(titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              gifArriba,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: TSizes.spaceBtwSections / 2),
            ColitaPosicion(
              color: Colors.blue,
              tailPosition: BubbleTailPosition.bottom,
              child: Text(
                texto,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Image.asset(
              gifAbajo,
              height: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
