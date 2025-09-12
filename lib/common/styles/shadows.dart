import 'package:flutter/material.dart';

class TShadowSyle {
  static final verticalCardShadow = BoxShadow(
    color: const Color.fromARGB(80, 150, 223, 204), // menos opaco
    blurRadius: 3, // difuminado más pequeño
    spreadRadius: 1, // control de expansión
    offset: const Offset(0, 3), // ligera sombra hacia abajo
  );
}
