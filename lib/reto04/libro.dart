class Libro {
  final String nombre;
  final String isbn;
  final String autor;
  final String editorial;

  const Libro({
    required this.nombre,
    required this.isbn,
    required this.autor,
    required this.editorial,
  });

  @override
  String toString() => '$nombre ($autor)';
}

/// Datos simulados para llenar la pila.
const librosIniciales = [
  Libro(
    nombre: 'Cien años de soledad',
    isbn: '978-0000000001',
    autor: 'Gabriel García Márquez',
    editorial: 'Sudamericana',
  ),
  Libro(
    nombre: 'La vorágine',
    isbn: '978-0000000002',
    autor: 'José Eustasio Rivera',
    editorial: 'Cromos',
  ),
  Libro(
    nombre: 'María',
    isbn: '978-0000000003',
    autor: 'Jorge Isaacs',
    editorial: 'Imprenta de Gaitán',
  ),
  Libro(
    nombre: 'Clean Code',
    isbn: '978-0000000004',
    autor: 'Robert C. Martin',
    editorial: 'Prentice Hall',
  ),
];
