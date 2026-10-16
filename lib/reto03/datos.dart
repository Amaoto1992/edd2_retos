class Cancion {
  final String titulo;
  final String artista;
  final String duracion;

  const Cancion(this.titulo, this.artista, this.duracion);

  @override
  String toString() => '$titulo - $artista';
}

/// Datos simulados para el reproductor.
const canciones = [
  Cancion('La Bicicleta', 'Carlos Vives y Shakira', '3:47'),
  Cancion('Tusa', 'Karol G y Nicki Minaj', '3:21'),
  Cancion('Robarte un Beso', 'Carlos Vives y Sebastián Yatra', '3:14'),
  Cancion('Hawái', 'Maluma', '3:19'),
  Cancion('Me Gustas Tú', 'Manu Chao', '3:59'),
  Cancion('Colombia, Mi Encanto', 'Carlos Vives', '3:09'),
];

/// Páginas visitadas (simuladas) para el historial del navegador.
const paginasVisitadas = [
  'https://www.google.com',
  'https://www.uao.edu.co',
  'https://www.uao.edu.co/estudiantes',
  'https://github.com',
  'https://docs.flutter.dev',
  'https://pub.dev',
];
