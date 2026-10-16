/// Nodo de un árbol N-ario: un valor y una lista de hijos (cualquier cantidad).
class NodoNario<T> {
  T value;
  final List<NodoNario<T>> children = [];

  NodoNario(this.value);

  /// Crea un hijo con [value], lo agrega a este nodo y lo devuelve.
  NodoNario<T> addChild(T value) {
    final hijo = NodoNario(value);
    children.add(hijo);
    return hijo;
  }

  bool isLeaf() => children.isEmpty;
}

class ArbolNario<T> {
  final NodoNario<T> root;

  ArbolNario(T valorRaiz) : root = NodoNario(valorRaiz);

  /// DFS: baja lo más profundo posible por cada rama antes de seguir.
  List<T> dfs() {
    final resultado = <T>[];
    void visitar(NodoNario<T> nodo) {
      resultado.add(nodo.value);
      for (final hijo in nodo.children) {
        visitar(hijo);
      }
    }

    visitar(root);
    return resultado;
  }

  /// BFS: nivel por nivel, de izquierda a derecha.
  List<T> bfs() {
    final resultado = <T>[];
    final pendientes = <NodoNario<T>>[root];
    var i = 0;
    while (i < pendientes.length) {
      final nodo = pendientes[i];
      i++;
      resultado.add(nodo.value);
      pendientes.addAll(nodo.children);
    }
    return resultado;
  }
}
