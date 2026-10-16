import 'package:flutter/material.dart';

import 'buscador.dart';

/// Buscador inteligente: escribe un prefijo y muestra los K más populares.
class BuscadorPage extends StatefulWidget {
  const BuscadorPage({super.key});

  @override
  State<BuscadorPage> createState() => _BuscadorPageState();
}

class _BuscadorPageState extends State<BuscadorPage> {
  final buscador = crearBuscador();
  final prefijoCtrl = TextEditingController(text: 'air');
  final nombreCtrl = TextEditingController();
  final popularidadCtrl = TextEditingController();
  int k = 2;

  @override
  void initState() {
    super.initState();
    debugPrint('searchTopK("air", 2): ${buscador.searchTopK('air', 2)}');
  }

  @override
  void dispose() {
    prefijoCtrl.dispose();
    nombreCtrl.dispose();
    popularidadCtrl.dispose();
    super.dispose();
  }

  void agregarProducto() {
    final nombre = nombreCtrl.text.trim();
    final popularidad = int.tryParse(popularidadCtrl.text.trim());
    if (nombre.isEmpty || popularidad == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Escribe el nombre y una popularidad numérica'),
        ),
      );
      return;
    }
    setState(() => buscador.insert(nombre, popularidad));
    nombreCtrl.clear();
    popularidadCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final prefijo = prefijoCtrl.text.trim();
    final resultados = buscador.searchTopK(prefijo, k);
    final total = buscador.coincidencias(prefijo);

    return Scaffold(
      appBar: AppBar(title: const Text('Reto 11 · Trie + Heap')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: prefijoCtrl,
            decoration: const InputDecoration(
              labelText: 'Buscar por prefijo',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Top K: '),
              for (final opcion in [1, 2, 3, 5])
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text('$opcion'),
                    selected: k == opcion,
                    onSelected: (_) => setState(() => k = opcion),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$total productos empiezan por "$prefijo" · '
            'mostrando los ${resultados.length} más populares',
          ),
          const SizedBox(height: 8),
          if (resultados.isEmpty) const Text('Sin resultados'),
          for (var i = 0; i < resultados.length; i++)
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(resultados[i].name),
                trailing: Text('Popularidad ${resultados[i].popularity}'),
              ),
            ),
          const Divider(height: 32),
          Text(
            'Agregar producto (${buscador.cantidad} en el Trie)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: nombreCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: popularidadCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Popularidad',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: agregarProducto,
            icon: const Icon(Icons.add),
            label: const Text('Insertar en el Trie'),
          ),
        ],
      ),
    );
  }
}
