/// Heap guardado en un arreglo. El padre de i está en (i - 1) ~/ 2 y sus
/// hijos en 2i + 1 y 2i + 2.
///
/// [compare] decide quién sube: si compare(a, b) < 0, a va más arriba que b.
/// Con (a, b) => a - b es un min heap; con (a, b) => b - a es un max heap.
class Heap<T> {
  final List<T> _items = [];
  final int Function(T a, T b) compare;

  Heap(this.compare);

  int size() => _items.length;

  bool isEmpty() => _items.isEmpty;

  /// El elemento de la cima sin sacarlo.
  T? peek() => _items.isEmpty ? null : _items.first;

  /// Inserta al final y lo hace subir hasta su lugar.
  void push(T value) {
    _items.add(value);
    percolateUp(_items.length - 1);
  }

  /// Saca la cima, pone el último en su lugar y lo hace bajar.
  T? pop() {
    if (_items.isEmpty) return null;
    final cima = _items.first;
    final ultimo = _items.removeLast();
    if (_items.isNotEmpty) {
      _items[0] = ultimo;
      percolateDown(0);
    }
    return cima;
  }

  /// Convierte un arreglo cualquiera en heap, bajando cada padre desde el
  /// último hasta la raíz.
  void heapify(List<T> valores) {
    _items
      ..clear()
      ..addAll(valores);
    for (var i = _items.length ~/ 2 - 1; i >= 0; i--) {
      percolateDown(i);
    }
  }

  void percolateUp(int indice) {
    var i = indice;
    while (i > 0) {
      final padre = (i - 1) ~/ 2;
      if (compare(_items[i], _items[padre]) >= 0) return;
      swap(i, padre);
      i = padre;
    }
  }

  void percolateDown(int indice) {
    var i = indice;
    while (true) {
      final izquierdo = 2 * i + 1;
      final derecho = 2 * i + 2;
      var mejor = i;
      if (izquierdo < _items.length &&
          compare(_items[izquierdo], _items[mejor]) < 0) {
        mejor = izquierdo;
      }
      if (derecho < _items.length &&
          compare(_items[derecho], _items[mejor]) < 0) {
        mejor = derecho;
      }
      if (mejor == i) return;
      swap(i, mejor);
      i = mejor;
    }
  }

  void swap(int a, int b) {
    final temporal = _items[a];
    _items[a] = _items[b];
    _items[b] = temporal;
  }

  List<T> toArray() => List.of(_items);
}
