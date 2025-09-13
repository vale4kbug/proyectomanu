import 'package:flutter/material.dart';
import 'package:proyectomanu/features/home/widgets/level_button.dart';
import 'package:proyectomanu/features/home/widgets/path_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  // Lista para definir las propiedades de cada nivel
  final List<Map<String, dynamic>> levels = List.generate(11, (index) {
    return {
      'level': index + 1,
      'stars': (index % 4), // Ejemplo: 0, 1, 2, 3, 0, 1... estrellas
      'isSpecial': (index + 1) == 11, // El nivel 11 es especial
    };
  });

  @override
  void initState() {
    super.initState();

    // Controlador para la animación de la estrella flotante
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Listener para el efecto de parallax del fondo
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Altura total del área de desplazamiento. Ajústala según necesites.
    const double totalPathHeight = 1800;

    return Scaffold(
      body: Stack(
        children: [
          // --- FONDO CON EFECTO PARALLAX ---
          // El fondo se moverá más lento que el scroll
          Positioned(
            top: -_scrollOffset * 0.3, // Controla la velocidad del parallax
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/background.png', // <-- RECUERDA AÑADIR TU IMAGEN DE FONDO
              fit: BoxFit.cover,
              height:
                  MediaQuery.of(context).size.height +
                  200, // Altura extra para cubrir el scroll
            ),
          ),

          // --- CAMINO DE NIVELES (SCROLLABLE) ---
          SingleChildScrollView(
            controller: _scrollController,
            child: SizedBox(
              height: totalPathHeight,
              width: screenWidth,
              child: Stack(
                children: [
                  // --- DIBUJO DEL CAMINO (la línea) ---
                  CustomPaint(
                    size: Size(screenWidth, totalPathHeight),
                    painter: PathPainter(levelCount: levels.length),
                  ),

                  // --- GENERACIÓN DE BOTONES Y ANIMACIONES ---
                  ..._buildLevelButtons(screenWidth),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLevelButtons(double screenWidth) {
    List<Widget> widgets = [];

    for (var levelData in levels) {
      final int level = levelData['level'];

      // Lógica para la posición en forma de "S"
      final double top = 120.0 * level;
      double horizontalPosition;
      // Las filas pares van a la izquierda, las impares a la derecha
      if (((level - 1) ~/ 3) % 2 == 0) {
        horizontalPosition = (screenWidth / 5) * ((level - 1) % 3 + 1);
      } else {
        horizontalPosition =
            screenWidth - (screenWidth / 5) * (((level - 1) % 3) + 1);
      }

      // Añadir el botón del nivel
      widgets.add(
        Positioned(
          top: top,
          left: horizontalPosition - 40, // Centrar el botón
          child: LevelButton(
            levelNumber: level,
            stars: levelData['stars'],
            isSpecial: levelData['isSpecial'],
            onPressed: () {
              print('Nivel $level presionado!');
            },
          ),
        ),
      );

      // Añadir una animación de ejemplo al lado del nivel 3
      if (level == 3) {
        widgets.add(
          Positioned(
            top: top + 20,
            left: horizontalPosition + 20, // Posición al lado del botón
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: const Icon(Icons.star, color: Colors.amber, size: 30),
            ),
          ),
        );
      }
    }
    return widgets;
  }
}
