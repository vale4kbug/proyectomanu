import 'package:flutter/material.dart';
import 'package:proyectomanu/features/authentication/screens/login/models/usuario_model.dart'; // <-- IMPORTA TU MODELO
import 'package:proyectomanu/features/perfil/widgets/achievement_card.dart';

class TLogrosDisplayPerfil extends StatelessWidget {
  const TLogrosDisplayPerfil({super.key, required this.logros});
  final List<LogroModel> logros;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: .75,
      ),
      itemCount: logros.length,
      itemBuilder: (context, index) {
        final logro = logros[index];
        return TAchievementCard(
          image: logro.imagen ?? '',
          title: logro.titulo,
          subtitle: logro.descripcion ?? '',
          locked: !logro.desbloqueado,
        );
      },
    );
  }
}
