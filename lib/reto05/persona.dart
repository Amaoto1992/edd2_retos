import 'dart:math';

class Persona {
  final String nombre;
  final int monto;
  final DateTime llegada;

  Persona({required this.nombre, required this.monto, DateTime? llegada})
      : llegada = llegada ?? fechaAleatoria();

  @override
  String toString() => '$nombre (${horaTexto(llegada)})';
}

final _random = Random();

/// Fecha de llegada aleatoria: hoy, entre las 8:00 y las 16:00.
DateTime fechaAleatoria() {
  final hoy = DateTime.now();
  final inicio = DateTime(hoy.year, hoy.month, hoy.day, 8);
  return inicio.add(Duration(seconds: _random.nextInt(8 * 60 * 60)));
}

String horaTexto(DateTime fecha) {
  String dos(int n) => n.toString().padLeft(2, '0');
  return '${dos(fecha.day)}/${dos(fecha.month)} '
      '${dos(fecha.hour)}:${dos(fecha.minute)}:${dos(fecha.second)}';
}

/// Formatea un número como pesos: 150000 -> $150.000
String pesos(int valor) {
  final texto = valor.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < texto.length; i++) {
    if (i > 0 && (texto.length - i) % 3 == 0) buffer.write('.');
    buffer.write(texto[i]);
  }
  return '\$$buffer';
}

/// Datos simulados: la fecha de llegada la asigna el sistema al azar.
List<Persona> personasIniciales() => [
      Persona(nombre: 'Laura Gómez', monto: 200000),
      Persona(nombre: 'Andrés Pérez', monto: 50000),
      Persona(nombre: 'Camila Ríos', monto: 600000),
      Persona(nombre: 'Julián Torres', monto: 120000),
    ];
