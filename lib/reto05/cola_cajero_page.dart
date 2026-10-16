import 'package:flutter/material.dart';

import 'cola.dart';
import 'persona.dart';

/// Formulario para agregar personas a la cola del cajero. La cola se imprime
/// ordenada por la fecha de llegada que el sistema asigna al azar.
class ColaCajeroPage extends StatefulWidget {
  const ColaCajeroPage({super.key});

  @override
  State<ColaCajeroPage> createState() => _ColaCajeroPageState();
}

class _ColaCajeroPageState extends State<ColaCajeroPage> {
  final cola = Cola<Persona>();
  final formKey = GlobalKey<FormState>();
  final nombreCtrl = TextEditingController();
  final montoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (final persona in personasIniciales()) {
      cola.enqueue(persona);
    }
    debugPrint('Cola del cajero: ${cola.printQueue()}');
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    montoCtrl.dispose();
    super.dispose();
  }

  void agregar() {
    if (!formKey.currentState!.validate()) return;
    final persona = Persona(
      nombre: nombreCtrl.text.trim(),
      monto: int.parse(montoCtrl.text.trim()),
    );
    setState(() => cola.enqueue(persona));
    nombreCtrl.clear();
    montoCtrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${persona.nombre} llegó el ${horaTexto(persona.llegada)}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final porLlegada = cola.toList()
      ..sort((a, b) => a.llegada.compareTo(b.llegada));
    return Scaffold(
      appBar: AppBar(title: const Text('Reto 05 · Cola del cajero')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: montoCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Monto a retirar',
                    prefixText: '\$ ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final monto = int.tryParse(v?.trim() ?? '');
                    if (monto == null || monto <= 0) {
                      return 'Escribe un monto válido (solo números)';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: agregar,
            icon: const Icon(Icons.person_add),
            label: const Text('Agregar a la cola (enqueue)'),
          ),
          const SizedBox(height: 24),
          Text(
            'Cola (${cola.size()} personas) · ordenada por fecha de llegada',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < porLlegada.length; i++)
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(porLlegada[i].nombre),
                subtitle: Text('Llegó: ${horaTexto(porLlegada[i].llegada)}'),
                trailing: Text(pesos(porLlegada[i].monto)),
              ),
            ),
        ],
      ),
    );
  }
}
