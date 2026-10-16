import 'package:flutter/material.dart';

import 'arbol_binario.dart';
import 'arbol_painter.dart';

/// Inserta una serie de números, imprime los recorridos en consola, busca un
/// valor y dibuja el árbol en pantalla.
class ArbolBinarioPage extends StatefulWidget {
  const ArbolBinarioPage({super.key});

  @override
  State<ArbolBinarioPage> createState() => _ArbolBinarioPageState();
}

class _ArbolBinarioPageState extends State<ArbolBinarioPage> {
  final arbol = ArbolBinario();
  final insertarCtrl = TextEditingController();
  final buscarCtrl = TextEditingController();
  String resultadoBusqueda = '';
  int? encontrado;

  static const serieInicial = [50, 30, 70, 20, 40, 60, 80, 35, 65];

  @override
  void initState() {
    super.initState();
    for (final numero in serieInicial) {
      arbol.insert(numero);
    }
    imprimirEnConsola();
  }

  @override
  void dispose() {
    insertarCtrl.dispose();
    buscarCtrl.dispose();
    super.dispose();
  }

  void imprimirEnConsola() {
    debugPrint('InOrder:   ${arbol.inOrder().join(', ')}');
    debugPrint('PreOrder:  ${arbol.preOrder().join(', ')}');
    debugPrint('PostOrder: ${arbol.postOrder().join(', ')}');
  }

  void insertar() {
    final valor = int.tryParse(insertarCtrl.text.trim());
    if (valor == null) return;
    final insertado = arbol.insert(valor);
    insertarCtrl.clear();
    setState(() {});
    imprimirEnConsola();
    if (!insertado) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$valor ya está en el árbol')),
      );
    }
  }

  void buscar() {
    final valor = int.tryParse(buscarCtrl.text.trim());
    if (valor == null) return;
    final esta = arbol.contains(valor);
    setState(() {
      encontrado = esta ? valor : null;
      resultadoBusqueda =
          esta ? '$valor sí está en el árbol' : '$valor no está en el árbol';
    });
  }

  Widget filaConBoton(
    TextEditingController ctrl,
    String etiqueta,
    String boton,
    VoidCallback accion,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: ctrl,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => accion(),
            decoration: InputDecoration(
              labelText: etiqueta,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        FilledButton(onPressed: accion, child: Text(boton)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Reto 08 · Árbol binario')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          filaConBoton(insertarCtrl, 'Número a insertar', 'Insertar', insertar),
          const SizedBox(height: 12),
          filaConBoton(buscarCtrl, 'Número a buscar', 'Buscar', buscar),
          if (resultadoBusqueda.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(resultadoBusqueda),
            ),
          const SizedBox(height: 16),
          Text('InOrder (L-N-R): ${arbol.inOrder().join(', ')}'),
          Text('PreOrder (N-L-R): ${arbol.preOrder().join(', ')}'),
          Text('PostOrder (L-R-N): ${arbol.postOrder().join(', ')}'),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CustomPaint(
              size: ArbolPainter.tamano(arbol),
              painter: ArbolPainter(
                arbol: arbol,
                colorNodo: colores.primary,
                colorTexto: colores.onPrimary,
                colorLinea: colores.outline,
                resaltado: encontrado,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
