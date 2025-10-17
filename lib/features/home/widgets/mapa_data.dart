import 'package:proyectomanu/features/home/models/unidad_model.dart'; // Ajusta la ruta

class MapaData {
  // Aquí defines todos tus mundos o unidades
  static final List<UnidadData> unidades = [
    // --- UNIDAD 1 ---
    UnidadData(
      titulo: "Unidad 1: Dactilología",
      etiquetaY: 650.0,
      posicionesNiveles: [
        NivelPosicion(xFactor: 0.25, y: 550.0), // Nivel 1
        NivelPosicion(xFactor: 0.7, y: 400.0), // Nivel 2
        NivelPosicion(xFactor: 0.3, y: 300.0), // Nivel 3
        NivelPosicion(xFactor: 0.65, y: 150.0), // Nivel 4 (especial)
      ],
    ),

    // --- UNIDAD 2  ---
    UnidadData(
      titulo: "Unidad 2: Saludos",
      etiquetaY: 650.0,
      posicionesNiveles: [
        NivelPosicion(xFactor: 0.25, y: 550.0), // Nivel 5
        NivelPosicion(xFactor: 0.7, y: 400.0), // Nivel 6
      ],
    ),
  ];
}
