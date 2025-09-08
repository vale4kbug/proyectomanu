import 'package:flutter/material.dart';

class TShadowSyle {
  static final verticalCardShadow = BoxShadow(
    color: const Color.fromARGB(212, 15, 114, 88), // menos opaco
    blurRadius: 6, // difuminado más pequeño
    spreadRadius: 1, // control de expansión
    offset: const Offset(0, 3), // ligera sombra hacia abajo
  );
}
