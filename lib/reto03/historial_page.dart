import 'package:flutter/material.dart';

import 'datos.dart';
import 'lista_doble.dart';

/// Historial del navegador: atrás usa prev y adelante usa next.
class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  final historial = ListaDoble<String>();
  NodoDoble<String>? actual;

  @override
  void initState() {
    super.initState();
    for (final pagina in paginasVisitadas) {
      historial.append(pagina);
    }
    // El navegador queda parado en la última página visitada.
    actual = historial.tail;
    debugPrint('Historial: ${historial.printList()}');
  }

  void atras() {
    setState(() => actual = actual?.prev);
  }

  void adelante() {
    setState(() => actual = actual?.next);
  }

  List<NodoDoble<String>> nodos() {
    final resultado = <NodoDoble<String>>[];
    var nodo = historial.head;
    while (nodo != null) {
      resultado.add(nodo);
      nodo = nodo.next;
    }
    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    final pagina = actual;
    return Scaffold(
      appBar: AppBar(title: const Text('Reto 03 · Lista doble')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton.filledTonal(
                  tooltip: 'Atrás',
                  onPressed: pagina?.prev == null ? null : atras,
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: 'Adelante',
                  onPressed: pagina?.next == null ? null : adelante,
                  icon: const Icon(Icons.arrow_forward),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      pagina?.value ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text('Páginas en el historial: ${historial.size()}'),
          Expanded(
            child: ListView(
              children: [
                for (final nodo in nodos())
                  ListTile(
                    selected: identical(nodo, pagina),
                    leading: Icon(
                      identical(nodo, pagina) ? Icons.location_on : Icons.public,
                    ),
                    title: Text(nodo.value),
                    subtitle: Text(
                      'prev: ${nodo.prev == null ? 'null' : '←'}   '
                      'next: ${nodo.next == null ? 'null' : '→'}',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
