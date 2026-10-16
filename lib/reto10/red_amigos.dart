import 'grafo.dart';

/// Un vértice del grafo puede ser una persona o una ciudad.
sealed class Vertice {
  String get nombre;
}

class Amigo extends Vertice {
  @override
  final String nombre;
  final int edad;

  Amigo(this.nombre, this.edad);

  @override
  String toString() => '$nombre ($edad)';
}

class Ciudad extends Vertice {
  @override
  final String nombre;

  Ciudad(this.nombre);

  @override
  String toString() => nombre;
}

/// Grafo de amigos y ciudades. Cada persona queda conectada a una ciudad
/// (donde vive) y a las personas que son sus amigos.
class RedAmigos {
  final grafo = Grafo<Vertice>();

  void agregarCiudad(Ciudad ciudad) => grafo.addNode(ciudad);

  /// Agrega a la persona y la conecta con su ciudad.
  void agregarPersona(Amigo persona, Ciudad ciudad) {
    grafo.addEdge(persona, ciudad);
  }

  void agregarAmistad(Amigo a, Amigo b) => grafo.addEdge(a, b);

  List<Ciudad> get ciudades => grafo.nodos.whereType<Ciudad>().toList();

  List<Amigo> get personas => grafo.nodos.whereType<Amigo>().toList();

  /// Personas que viven en [ciudad]: sus vecinos en el grafo que son personas.
  List<Amigo> personasEn(Ciudad ciudad) =>
      grafo.neighbors(ciudad).whereType<Amigo>().toList();

  Ciudad? ciudadDe(Amigo persona) {
    for (final vecino in grafo.neighbors(persona)) {
      if (vecino is Ciudad) return vecino;
    }
    return null;
  }

  List<Amigo> amigosDe(Amigo persona) =>
      grafo.neighbors(persona).whereType<Amigo>().toList();
}

/// Datos simulados.
RedAmigos crearRedAmigos() {
  final red = RedAmigos();
  final cali = Ciudad('Cali');
  final bogota = Ciudad('Bogotá');
  final medellin = Ciudad('Medellín');
  for (final ciudad in [cali, bogota, medellin]) {
    red.agregarCiudad(ciudad);
  }

  final ana = Amigo('Ana', 21);
  final luis = Amigo('Luis', 24);
  final sofia = Amigo('Sofía', 19);
  final mateo = Amigo('Mateo', 22);
  final valentina = Amigo('Valentina', 27);
  final camilo = Amigo('Camilo', 30);
  final daniela = Amigo('Daniela', 23);

  red.agregarPersona(ana, cali);
  red.agregarPersona(luis, cali);
  red.agregarPersona(sofia, cali);
  red.agregarPersona(mateo, bogota);
  red.agregarPersona(valentina, bogota);
  red.agregarPersona(camilo, medellin);
  red.agregarPersona(daniela, medellin);

  red.agregarAmistad(ana, luis);
  red.agregarAmistad(ana, mateo);
  red.agregarAmistad(sofia, camilo);
  red.agregarAmistad(valentina, daniela);
  red.agregarAmistad(luis, valentina);

  return red;
}
