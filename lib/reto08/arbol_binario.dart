/// Nodo de un árbol binario: un valor y dos hijos (izquierdo y derecho).
class NodoArbol {
  int value;
  NodoArbol? left;
  NodoArbol? right;

  NodoArbol(this.value);

  bool isLeaf() => left == null && right == null;
}

/// Árbol binario de búsqueda: los menores van a la izquierda y los mayores a
/// la derecha. No admite valores repetidos.
class ArbolBinario {
  NodoArbol? root;

  /// Inserta [value] según su valor. Devuelve false si ya estaba en el árbol.
  bool insert(int value) {
    if (root == null) {
      root = NodoArbol(value);
      return true;
    }
    return _insertar(root!, value);
  }

  bool _insertar(NodoArbol nodo, int value) {
    if (value == nodo.value) return false;
    if (value < nodo.value) {
      if (nodo.left == null) {
        nodo.left = NodoArbol(value);
        return true;
      }
      return _insertar(nodo.left!, value);
    }
    if (nodo.right == null) {
      nodo.right = NodoArbol(value);
      return true;
    }
    return _insertar(nodo.right!, value);
  }

  /// N-L-R: nodo, izquierdo, derecho.
  List<int> preOrder() {
    final resultado = <int>[];
    void recorrer(NodoArbol? nodo) {
      if (nodo == null) return;
      resultado.add(nodo.value);
      recorrer(nodo.left);
      recorrer(nodo.right);
    }

    recorrer(root);
    return resultado;
  }

  /// L-N-R: izquierdo, nodo, derecho. En un árbol de búsqueda sale ordenado.
  List<int> inOrder() {
    final resultado = <int>[];
    void recorrer(NodoArbol? nodo) {
      if (nodo == null) return;
      recorrer(nodo.left);
      resultado.add(nodo.value);
      recorrer(nodo.right);
    }

    recorrer(root);
    return resultado;
  }

  /// L-R-N: izquierdo, derecho, nodo.
  List<int> postOrder() {
    final resultado = <int>[];
    void recorrer(NodoArbol? nodo) {
      if (nodo == null) return;
      recorrer(nodo.left);
      recorrer(nodo.right);
      resultado.add(nodo.value);
    }

    recorrer(root);
    return resultado;
  }

  /// Revisa si [value] está en el árbol bajando por un solo camino.
  bool contains(int value) {
    var actual = root;
    while (actual != null) {
      if (value == actual.value) return true;
      actual = value < actual.value ? actual.left : actual.right;
    }
    return false;
  }
}
