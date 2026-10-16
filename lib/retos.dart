import 'package:flutter/material.dart';

import 'reto03/historial_page.dart';
import 'reto03/reproductor_page.dart';
import 'reto04/pila_libros_page.dart';
import 'reto05/cola_cajero_page.dart';
import 'reto08/arbol_binario_page.dart';
import 'reto09/menu_lateral_page.dart';
import 'reto10/grafo_page.dart';

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
  Reto(
    'Reto 04 · Pila',
    'Pila de libros con formulario',
    (context) => const PilaLibrosPage(),
  ),
  Reto(
    'Reto 05 · Cola',
    'Cola del cajero ordenada por fecha de llegada',
    (context) => const ColaCajeroPage(),
  ),
  Reto(
    'Reto 08 · Árbol binario',
    'Recorridos, búsqueda y dibujo del árbol',
    (context) => const ArbolBinarioPage(),
  ),
  Reto(
    'Reto 09 · Árbol N-ario',
    'Menú lateral armado desde el árbol',
    (context) => const MenuLateralPage(),
  ),
  Reto(
    'Reto 10 · Grafo',
    'Amigos y ciudades',
    (context) => const GrafoPage(),
  ),
];
