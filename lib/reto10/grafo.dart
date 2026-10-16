/// Grafo no dirigido con una lista de nodos y un objeto de adyacencia:
/// cada nodo apunta a la lista de nodos con los que está conectado.
class Grafo<T> {
  final List<T> nodos = [];
  final Map<T, List<T>> adyacencia = {};

  /// Agrega un nodo si todavía no existe.
  void addNode(T nodo) {
    if (adyacencia.containsKey(nodo)) return;
    nodos.add(nodo);
    adyacencia[nodo] = [];
  }

  /// Conecta dos nodos en ambas direcciones (grafo no dirigido).
  void addEdge(T a, T b) {
    addNode(a);
    addNode(b);
    if (!adyacencia[a]!.contains(b)) adyacencia[a]!.add(b);
    if (!adyacencia[b]!.contains(a)) adyacencia[b]!.add(a);
  }

  /// Busca un nodo en la lista de nodos.
  T? searchNode(bool Function(T nodo) cumple) {
    for (final nodo in nodos) {
      if (cumple(nodo)) return nodo;
    }
    return null;
  }

  /// Busca la lista de adyacencia de un nodo.
  List<T> neighbors(T nodo) => adyacencia[nodo] ?? [];

  String printGraph() =>
      nodos.map((nodo) => '$nodo -> ${neighbors(nodo).join(', ')}').join('\n');
}
