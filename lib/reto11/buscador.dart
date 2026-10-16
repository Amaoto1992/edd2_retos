import 'heap.dart';
import 'trie.dart';

class Producto {
  final String name;
  final int popularity;

  const Producto(this.name, this.popularity);

  @override
  String toString() => '{ name: "$name", popularity: $popularity }';
}

/// Buscador: guarda los productos en un Trie para buscar por prefijo y usa un
/// Heap (max heap por popularidad) para sacar los K más populares.
class BuscadorProductos {
  final trie = Trie();
  int cantidad = 0;

  void insert(String name, int popularity) {
    if (!trie.search(name)) cantidad++;
    trie.insert(name, popularity);
  }

  List<Producto> searchTopK(String prefix, int k) {
    final candidatos = [
      for (final p in trie.wordsWithPrefix(prefix)) Producto(p.name, p.popularity),
    ];
    final heap = Heap<Producto>((a, b) => b.popularity - a.popularity)
      ..heapify(candidatos);

    final top = <Producto>[];
    while (top.length < k && !heap.isEmpty()) {
      top.add(heap.pop()!);
    }
    return top;
  }

  /// Cuántos productos empiezan por el prefijo (sin límite de K).
  int coincidencias(String prefix) => trie.wordsWithPrefix(prefix).length;
}

/// Datos simulados (los cuatro primeros son los del ejemplo de clase).
BuscadorProductos crearBuscador() {
  return BuscadorProductos()
    ..insert('air max', 90)
    ..insert('air force', 95)
    ..insert('air jordan', 85)
    ..insert('adidas boost', 80)
    ..insert('adidas superstar', 88)
    ..insert('air zoom', 78)
    ..insert('nike pegasus', 92)
    ..insert('nike cortez', 75)
    ..insert('new balance 574', 83)
    ..insert('puma suede', 70);
}
