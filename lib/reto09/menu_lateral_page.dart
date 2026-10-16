import 'package:flutter/material.dart';

import 'arbol_nario.dart';
import 'menus.dart';

/// Arma el menú lateral recorriendo el árbol N-ario: los nodos con hijos son
/// submenús desplegables y las hojas abren su componente.
class MenuLateralPage extends StatefulWidget {
  const MenuLateralPage({super.key});

  @override
  State<MenuLateralPage> createState() => _MenuLateralPageState();
}

class _MenuLateralPageState extends State<MenuLateralPage> {
  final arbol = crearArbolMenus();
  late NodoNario<OpcionMenu> seleccionado = arbol.root.children.first;

  @override
  void initState() {
    super.initState();
    debugPrint('DFS: ${arbol.dfs().join(' > ')}');
    debugPrint('BFS: ${arbol.bfs().join(' > ')}');
  }

  void seleccionar(NodoNario<OpcionMenu> nodo, {required bool cerrarDrawer}) {
    setState(() => seleccionado = nodo);
    if (cerrarDrawer) Navigator.pop(context);
  }

  /// Convierte un nodo del árbol (y sus hijos, de forma recursiva) en widgets.
  Widget construirItem(NodoNario<OpcionMenu> nodo, bool enDrawer) {
    if (nodo.isLeaf()) {
      return ListTile(
        title: Text(nodo.value.titulo),
        subtitle: Text(nodo.value.link),
        selected: identical(nodo, seleccionado),
        onTap: () => seleccionar(nodo, cerrarDrawer: enDrawer),
      );
    }
    return ExpansionTile(
      title: Text(nodo.value.titulo),
      subtitle: Text(nodo.value.link),
      childrenPadding: const EdgeInsets.only(left: 16),
      children: [
        for (final hijo in nodo.children) construirItem(hijo, enDrawer),
      ],
    );
  }

  Widget menuLateral(bool enDrawer) {
    return ListView(
      children: [
        for (final nodo in arbol.root.children) construirItem(nodo, enDrawer),
      ],
    );
  }

  Widget contenido() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Link: ${seleccionado.value.link}'),
        ),
        Expanded(child: seleccionado.value.componente),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pantallaAncha = constraints.maxWidth >= 700;
        return Scaffold(
          appBar: AppBar(title: const Text('Reto 09 · Menú con árbol N-ario')),
          drawer: pantallaAncha ? null : Drawer(child: menuLateral(true)),
          body: pantallaAncha
              ? Row(
                  children: [
                    SizedBox(width: 280, child: menuLateral(false)),
                    const VerticalDivider(width: 1),
                    Expanded(child: contenido()),
                  ],
                )
              : contenido(),
        );
      },
    );
  }
}
