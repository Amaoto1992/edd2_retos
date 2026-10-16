import 'package:flutter/material.dart';

import 'datos.dart';
import 'lista_enlazada.dart';

/// Reproduce las canciones en orden recorriendo la lista enlazada con next.
class ReproductorPage extends StatefulWidget {
  const ReproductorPage({super.key});

  @override
  State<ReproductorPage> createState() => _ReproductorPageState();
}

class _ReproductorPageState extends State<ReproductorPage> {
  final lista = ListaEnlazada<Cancion>();
  Nodo<Cancion>? actual;

  @override
  void initState() {
    super.initState();
    for (final cancion in canciones) {
      lista.append(cancion);
    }
    actual = lista.head;
    debugPrint('Playlist: ${lista.printList()}');
  }

  void siguiente() {
    setState(() => actual = actual?.next);
  }

  void reiniciar() {
    setState(() => actual = lista.head);
  }

  List<Nodo<Cancion>> nodos() {
    final resultado = <Nodo<Cancion>>[];
    var nodo = lista.head;
    while (nodo != null) {
      resultado.add(nodo);
      nodo = nodo.next;
    }
    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    final sonando = actual;
    return Scaffold(
      appBar: AppBar(title: const Text('Reto 03 · Lista enlazada')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              leading: Icon(
                sonando == null ? Icons.stop_circle : Icons.play_circle,
                size: 40,
              ),
              title: Text(sonando?.value.titulo ?? 'Fin de la lista'),
              subtitle: Text(
                sonando == null
                    ? 'Presiona reiniciar para volver a la primera canción'
                    : '${sonando.value.artista} · ${sonando.value.duracion}',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: reiniciar,
                icon: const Icon(Icons.replay),
                label: const Text('Reiniciar'),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: sonando == null ? null : siguiente,
                icon: const Icon(Icons.skip_next),
                label: const Text('Siguiente'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Canciones en la lista: ${lista.size()}'),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final nodo in nodos())
                  ListTile(
                    selected: identical(nodo, sonando),
                    leading: Icon(
                      identical(nodo, sonando)
                          ? Icons.volume_up
                          : Icons.music_note,
                    ),
                    title: Text(nodo.value.titulo),
                    subtitle: Text(nodo.value.artista),
                    trailing: Text(
                      nodo.next == null ? 'next: null' : 'next →',
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
