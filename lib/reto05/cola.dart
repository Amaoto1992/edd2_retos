/// Cola (FIFO): el primer elemento que entra es el primero que sale.
class Cola<T> {
  final List<T> _items = [];

  /// Agrega un elemento al final de la cola.
  void enqueue(T item) => _items.add(item);

  /// Saca y devuelve el primer elemento, o null si está vacía.
  T? dequeue() => _items.isEmpty ? null : _items.removeAt(0);

  /// Devuelve el primer elemento sin sacarlo, o null si está vacía.
  T? peek() => _items.isEmpty ? null : _items.first;

  bool isEmpty() => _items.isEmpty;

  int size() => _items.length;

  /// Copia de los elementos en el orden de la cola.
  List<T> toList() => List.of(_items);

  String printQueue() => _items.join(' <- ');
}
