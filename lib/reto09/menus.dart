import 'package:flutter/material.dart';

import 'arbol_nario.dart';

/// Cada opción del menú tiene un título, un link y un componente.
class OpcionMenu {
  final String titulo;
  final String link;
  final Widget componente;

  const OpcionMenu(this.titulo, this.link, this.componente);

  @override
  String toString() => titulo;
}

/// Componente simple que muestra en qué opción del menú estamos.
class PantallaMenu extends StatelessWidget {
  final String titulo;
  final IconData icono;

  const PantallaMenu(this.titulo, this.icono, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 64),
          const SizedBox(height: 12),
          Text(titulo, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}

/// Llena el árbol N-ario con menús y submenús.
ArbolNario<OpcionMenu> crearArbolMenus() {
  final arbol = ArbolNario(
    const OpcionMenu('Menú', '/', PantallaMenu('Menú', Icons.menu)),
  );
  final raiz = arbol.root;

  raiz.addChild(
    const OpcionMenu('Inicio', '/inicio', PantallaMenu('Inicio', Icons.home)),
  );

  final productos = raiz.addChild(
    const OpcionMenu(
      'Productos',
      '/productos',
      PantallaMenu('Productos', Icons.inventory),
    ),
  );
  productos.addChild(
    const OpcionMenu(
      'Catálogo',
      '/productos/catalogo',
      PantallaMenu('Catálogo', Icons.store),
    ),
  );
  productos.addChild(
    const OpcionMenu(
      'Categorías',
      '/productos/categorias',
      PantallaMenu('Categorías', Icons.category),
    ),
  );

  final ventas = raiz.addChild(
    const OpcionMenu('Ventas', '/ventas', PantallaMenu('Ventas', Icons.sell)),
  );
  ventas.addChild(
    const OpcionMenu(
      'Pedidos',
      '/ventas/pedidos',
      PantallaMenu('Pedidos', Icons.shopping_cart),
    ),
  );
  final reportes = ventas.addChild(
    const OpcionMenu(
      'Reportes',
      '/ventas/reportes',
      PantallaMenu('Reportes', Icons.bar_chart),
    ),
  );
  reportes.addChild(
    const OpcionMenu(
      'Diarios',
      '/ventas/reportes/diarios',
      PantallaMenu('Reportes diarios', Icons.today),
    ),
  );
  reportes.addChild(
    const OpcionMenu(
      'Mensuales',
      '/ventas/reportes/mensuales',
      PantallaMenu('Reportes mensuales', Icons.calendar_month),
    ),
  );

  final configuracion = raiz.addChild(
    const OpcionMenu(
      'Configuración',
      '/configuracion',
      PantallaMenu('Configuración', Icons.settings),
    ),
  );
  configuracion.addChild(
    const OpcionMenu(
      'Perfil',
      '/configuracion/perfil',
      PantallaMenu('Perfil', Icons.person),
    ),
  );
  configuracion.addChild(
    const OpcionMenu(
      'Seguridad',
      '/configuracion/seguridad',
      PantallaMenu('Seguridad', Icons.lock),
    ),
  );

  return arbol;
}
