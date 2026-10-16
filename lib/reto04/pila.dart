/// Pila (LIFO): el último elemento que entra es el primero que sale.
/// Se apoya en una List de Dart, igual que en clase se apoya en el Array de JS.
class Pila<T> {
  final List<T> _items = [];

  /// Agrega un elemento en el tope.
  void push(T item) => _items.add(item);

  /// Saca y devuelve el elemento del tope, o null si está vacía.
  T? pop() => _items.isEmpty ? null : _items.removeLast();

  /// Devuelve el elemento del tope sin sacarlo, o null si está vacía.
  T? peek() => _items.isEmpty ? null : _items.last;

  bool isEmpty() => _items.isEmpty;

  int size() => _items.length;

  /// Elementos desde el tope hasta la base.
  List<T> toList() => _items.reversed.toList();

  String printStack() => toList().join('\n');
}
