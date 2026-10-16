import 'package:flutter/material.dart';

import 'arbol_binario.dart';

/// Dibuja el árbol binario: la columna de cada nodo es su posición en
/// inorder y la fila es su nivel (distancia a la raíz).
class ArbolPainter extends CustomPainter {
  final ArbolBinario arbol;
  final Color colorNodo;
  final Color colorTexto;
  final Color colorLinea;
  final int? resaltado;

  static const double espacioX = 56;
  static const double espacioY = 72;
  static const double radio = 20;

  ArbolPainter({
    required this.arbol,
    required this.colorNodo,
    required this.colorTexto,
    required this.colorLinea,
    this.resaltado,
  });

  /// Tamaño que necesita el dibujo según la cantidad de nodos y la altura.
  static Size tamano(ArbolBinario arbol) {
    final total = arbol.inOrder().length;
    final altura = _altura(arbol.root);
    return Size(
      (total == 0 ? 1 : total) * espacioX,
      (altura == 0 ? 1 : altura) * espacioY,
    );
  }

  static int _altura(NodoArbol? nodo) {
    if (nodo == null) return 0;
    final izq = _altura(nodo.left);
    final der = _altura(nodo.right);
    return 1 + (izq > der ? izq : der);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final posiciones = <NodoArbol, Offset>{};
    var columna = 0;

    void ubicar(NodoArbol? nodo, int nivel) {
      if (nodo == null) return;
      ubicar(nodo.left, nivel + 1);
      posiciones[nodo] = Offset(
        columna * espacioX + espacioX / 2,
        nivel * espacioY + espacioY / 2,
      );
      columna++;
      ubicar(nodo.right, nivel + 1);
    }

    ubicar(arbol.root, 0);

    final linea = Paint()
      ..color = colorLinea
      ..strokeWidth = 2;
    for (final entrada in posiciones.entries) {
      final nodo = entrada.key;
      for (final hijo in [nodo.left, nodo.right]) {
        if (hijo != null) {
          canvas.drawLine(entrada.value, posiciones[hijo]!, linea);
        }
      }
    }

    for (final entrada in posiciones.entries) {
      final esResaltado = entrada.key.value == resaltado;
      canvas.drawCircle(
        entrada.value,
        radio,
        Paint()..color = esResaltado ? Colors.orange : colorNodo,
      );
      final texto = TextPainter(
        text: TextSpan(
          text: '${entrada.key.value}',
          style: TextStyle(color: colorTexto, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      texto.paint(
        canvas,
        entrada.value - Offset(texto.width / 2, texto.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
