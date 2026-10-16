/// Nodo de una lista doblemente enlazada: apunta al siguiente y al anterior.
class NodoDoble<T> {
  T value;
  NodoDoble<T>? next;
  NodoDoble<T>? prev;

  NodoDoble(this.value);
}

/// Lista doblemente enlazada: se puede recorrer de head a tail y al revés.
class ListaDoble<T> {
  NodoDoble<T>? head;
  NodoDoble<T>? tail;
  int length = 0;

  /// Agrega un nodo al final y lo conecta con el anterior (prev).
  void append(T value) {
    final nuevo = NodoDoble(value);
    if (head == null) {
      head = nuevo;
      tail = nuevo;
    } else {
      nuevo.prev = tail;
      tail!.next = nuevo;
      tail = nuevo;
    }
    length++;
  }

  /// Devuelve el primer nodo cuyo valor cumple [cumple], o null si no hay.
  NodoDoble<T>? peek(bool Function(T value) cumple) {
    var actual = head;
    while (actual != null) {
      if (cumple(actual.value)) return actual;
      actual = actual.next;
    }
    return null;
  }

  int size() => length;

  /// Quita el primer nodo cuyo valor cumple [cumple] y une el anterior con el
  /// siguiente en ambas direcciones. Devuelve true si encontró el nodo.
  bool remove(bool Function(T value) cumple) {
    var actual = head;
    while (actual != null) {
      if (cumple(actual.value)) {
        final anterior = actual.prev;
        final siguiente = actual.next;
        if (anterior == null) {
          head = siguiente;
        } else {
          anterior.next = siguiente;
        }
        if (siguiente == null) {
          tail = anterior;
        } else {
          siguiente.prev = anterior;
        }
        length--;
        return true;
      }
      actual = actual.next;
    }
    return false;
  }

  /// Valores de head a tail.
  List<T> toList() {
    final valores = <T>[];
    var actual = head;
    while (actual != null) {
      valores.add(actual.value);
      actual = actual.next;
    }
    return valores;
  }

  /// Valores de tail a head, usando prev.
  List<T> toListReversed() {
    final valores = <T>[];
    var actual = tail;
    while (actual != null) {
      valores.add(actual.value);
      actual = actual.prev;
    }
    return valores;
  }

  String printList() => toList().join(' <-> ');
}
