import 'package:flutter/material.dart';

import 'libro.dart';
import 'pila.dart';

/// Formulario para crear libros y apilarlos. La pila se muestra desde el tope.
class PilaLibrosPage extends StatefulWidget {
  const PilaLibrosPage({super.key});

  @override
  State<PilaLibrosPage> createState() => _PilaLibrosPageState();
}

class _PilaLibrosPageState extends State<PilaLibrosPage> {
  final pila = Pila<Libro>();
  final formKey = GlobalKey<FormState>();
  final nombreCtrl = TextEditingController();
  final isbnCtrl = TextEditingController();
  final autorCtrl = TextEditingController();
  final editorialCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (final libro in librosIniciales) {
      pila.push(libro);
    }
    debugPrint('Pila de libros (tope primero):\n${pila.printStack()}');
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    isbnCtrl.dispose();
    autorCtrl.dispose();
    editorialCtrl.dispose();
    super.dispose();
  }

  String? requerido(String? valor) =>
      (valor == null || valor.trim().isEmpty) ? 'Campo obligatorio' : null;

  void agregar() {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      pila.push(
        Libro(
          nombre: nombreCtrl.text.trim(),
          isbn: isbnCtrl.text.trim(),
          autor: autorCtrl.text.trim(),
          editorial: editorialCtrl.text.trim(),
        ),
      );
    });
    for (final ctrl in [nombreCtrl, isbnCtrl, autorCtrl, editorialCtrl]) {
      ctrl.clear();
    }
  }

  void sacar() {
    final libro = pila.pop();
    setState(() {});
    if (libro != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Se sacó "${libro.nombre}" del tope')),
      );
    }
  }

  Widget campo(TextEditingController ctrl, String etiqueta) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: ctrl,
        validator: requerido,
        decoration: InputDecoration(
          labelText: etiqueta,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final libros = pila.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Reto 04 · Pila de libros')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                campo(nombreCtrl, 'Nombre'),
                campo(isbnCtrl, 'ISBN'),
                campo(autorCtrl, 'Autor'),
                campo(editorialCtrl, 'Editorial'),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: agregar,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar (push)'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: pila.isEmpty() ? null : sacar,
                  icon: const Icon(Icons.remove),
                  label: const Text('Sacar (pop)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Pila (${pila.size()} libros) · el primero es el tope',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (libros.isEmpty) const Text('La pila está vacía'),
          for (var i = 0; i < libros.length; i++)
            Card(
              child: ListTile(
                leading: Icon(i == 0 ? Icons.arrow_upward : Icons.book),
                title: Text(libros[i].nombre),
                subtitle: Text(
                  'ISBN ${libros[i].isbn}\n'
                  '${libros[i].autor} · ${libros[i].editorial}',
                ),
                isThreeLine: true,
                trailing: i == 0 ? const Text('TOPE') : null,
              ),
            ),
        ],
      ),
    );
  }
}
