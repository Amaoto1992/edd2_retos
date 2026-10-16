import 'package:flutter/material.dart';

import 'retos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estructuras de Datos II',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const InicioPage(),
    );
  }
}

/// Pantalla principal: lista los retos y abre la página de cada uno.
class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estructuras de Datos II')),
      body: retos.isEmpty
          ? const Center(child: Text('Todavía no hay retos'))
          : ListView.separated(
              itemCount: retos.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final reto = retos[index];
                return ListTile(
                  title: Text(reto.titulo),
                  subtitle: Text(reto.descripcion),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: reto.pagina),
                  ),
                );
              },
            ),
    );
  }
}
