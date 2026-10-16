import 'package:flutter/material.dart';

import 'reto03/historial_page.dart';
import 'reto03/reproductor_page.dart';

/// Un reto del curso: título, descripción y la página que lo muestra.
class Reto {
  final String titulo;
  final String descripcion;
  final WidgetBuilder pagina;

  const Reto(this.titulo, this.descripcion, this.pagina);
}

final List<Reto> retos = [
  Reto(
    'Reto 03 · Lista enlazada',
    'Reproductor de canciones en orden',
    (context) => const ReproductorPage(),
  ),
  Reto(
    'Reto 03 · Lista doblemente enlazada',
    'Historial del navegador: atrás y adelante',
    (context) => const HistorialPage(),
  ),
];
