/// Nodo del Trie: un mapa de hijos (letra -> nodo) y la marca de fin de
/// palabra. Si es fin de palabra también guarda la popularidad del producto.
class NodoTrie {
  final Map<String, NodoTrie> children = {};
  bool isEndOfWord = false;
  int popularity = 0;
}

/// Árbol de caracteres: la palabra no está en un nodo sino en el camino.
class Trie {
  final NodoTrie root = NodoTrie();

  /// Parte la palabra en letras, crea los nodos que falten y marca el último
  /// como fin de palabra.
  void insert(String word, int popularity) {
    var actual = root;
    for (final letra in word.toLowerCase().split('')) {
      actual = actual.children.putIfAbsent(letra, () => NodoTrie());
    }
    actual.isEndOfWord = true;
    actual.popularity = popularity;
  }

  /// Devuelve true si la palabra completa está en el Trie.
  bool search(String word) {
    final nodo = _bajarHasta(word);
    return nodo != null && nodo.isEndOfWord;
  }

  /// Todas las palabras que empiezan por [prefix], con su popularidad.
  List<({String name, int popularity})> wordsWithPrefix(String prefix) {
    final inicio = _bajarHasta(prefix);
    if (inicio == null) return [];

    final resultado = <({String name, int popularity})>[];
    void recorrer(NodoTrie nodo, String palabra) {
      if (nodo.isEndOfWord) {
        resultado.add((name: palabra, popularity: nodo.popularity));
      }
      for (final hijo in nodo.children.entries) {
        recorrer(hijo.value, palabra + hijo.key);
      }
    }

    recorrer(inicio, prefix.toLowerCase());
    return resultado;
  }

  /// Baja letra por letra desde la raíz. Devuelve null si alguna no está.
  NodoTrie? _bajarHasta(String texto) {
    var actual = root;
    for (final letra in texto.toLowerCase().split('')) {
      final siguiente = actual.children[letra];
      if (siguiente == null) return null;
      actual = siguiente;
    }
    return actual;
  }
}
