import 'package:flutter/material.dart';

import 'grafo_painter.dart';
import 'red_amigos.dart';

/// Muestra el grafo de amigos y ciudades, y lista las personas que viven en
/// la ciudad elegida.
class GrafoPage extends StatefulWidget {
  const GrafoPage({super.key});

  @override
  State<GrafoPage> createState() => _GrafoPageState();
}

class _GrafoPageState extends State<GrafoPage> {
  final red = crearRedAmigos();
  Ciudad? ciudad;

  @override
  void initState() {
    super.initState();
    ciudad = red.ciudades.first;
    debugPrint('Grafo:\n${red.grafo.printGraph()}');
  }

  void elegirCiudad(Ciudad nueva) {
    setState(() => ciudad = nueva);
    final nombres = red.personasEn(nueva).map((p) => p.nombre).join(', ');
    debugPrint('Viven en ${nueva.nombre}: $nombres');
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final elegida = ciudad;
    final habitantes = elegida == null ? <Amigo>[] : red.personasEn(elegida);

    return Scaffold(
      appBar: AppBar(title: const Text('Reto 10 · Grafo de amigos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Elige una ciudad',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final c in red.ciudades)
                ChoiceChip(
                  label: Text(c.nombre),
                  selected: identical(c, elegida),
                  onSelected: (_) => elegirCiudad(c),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Personas que viven en ${elegida?.nombre ?? '-'}:'),
          for (final persona in habitantes)
            ListTile(
              dense: true,
              leading: const Icon(Icons.person),
              title: Text(persona.nombre),
              subtitle: Text(
                '${persona.edad} años · amigos: '
                '${red.amigosDe(persona).map((a) => a.nombre).join(', ')}',
              ),
            ),
          const SizedBox(height: 12),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Card(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomPaint(
                    painter: GrafoPainter(
                      red: red,
                      ciudadSeleccionada: elegida,
                      colorCiudad: colores.primary,
                      colorPersona: colores.secondary,
                      colorResaltado: Colors.orange,
                      colorAmistad: colores.tertiary,
                      colorTexto: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Línea gris: vive en · Línea de color: son amigos · '
            'Naranja: vive en la ciudad elegida',
          ),
        ],
      ),
    );
  }
}
