/// Nodo de una lista enlazada simple: guarda un valor y apunta al siguiente.
class Nodo<T> {
  T value;
  Nodo<T>? next;

  Nodo(this.value);
}

/// Lista enlazada simple con head, tail y length.
class ListaEnlazada<T> {
  Nodo<T>? head;
  Nodo<T>? tail;
  int length = 0;

  /// Agrega un nodo al final de la lista.
  void append(T value) {
    final nuevo = Nodo(value);
    if (head == null) {
      head = nuevo;
      tail = nuevo;
    } else {
      tail!.next = nuevo;
      tail = nuevo;
    }
    length++;
  }

  /// Devuelve el primer nodo cuyo valor cumple [cumple], o null si no hay.
  Nodo<T>? peek(bool Function(T value) cumple) {
    var actual = head;
    while (actual != null) {
      if (cumple(actual.value)) return actual;
      actual = actual.next;
    }
    return null;
  }

  int size() => length;

  /// Quita el primer nodo cuyo valor cumple [cumple] y une el anterior con el
  /// siguiente. Devuelve true si encontró el nodo.
  bool remove(bool Function(T value) cumple) {
    Nodo<T>? anterior;
    var actual = head;
    while (actual != null) {
      if (cumple(actual.value)) {
        if (anterior == null) {
          head = actual.next;
        } else {
          anterior.next = actual.next;
        }
        if (identical(actual, tail)) {
          tail = anterior;
        }
        length--;
        return true;
      }
      anterior = actual;
      actual = actual.next;
    }
    return false;
  }

  /// Recorre desde head hasta el final y devuelve los valores en orden.
  List<T> toList() {
    final valores = <T>[];
    var actual = head;
    while (actual != null) {
      valores.add(actual.value);
      actual = actual.next;
    }
    return valores;
  }

  String printList() => toList().join(' -> ');
}
