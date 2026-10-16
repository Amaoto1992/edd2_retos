import 'dart:math';

import 'package:flutter/material.dart';

import 'red_amigos.dart';

/// Dibuja el grafo: las ciudades van en un círculo grande y cada persona
/// alrededor de su ciudad. Las líneas grises unen persona-ciudad y las de
/// color unen a dos amigos.
class GrafoPainter extends CustomPainter {
  final RedAmigos red;
  final Ciudad? ciudadSeleccionada;
  final Color colorCiudad;
  final Color colorPersona;
  final Color colorResaltado;
  final Color colorAmistad;
  final Color colorTexto;

  GrafoPainter({
    required this.red,
    required this.ciudadSeleccionada,
    required this.colorCiudad,
    required this.colorPersona,
    required this.colorResaltado,
    required this.colorAmistad,
    required this.colorTexto,
  });

  Map<Vertice, Offset> calcularPosiciones(Size size) {
    final posiciones = <Vertice, Offset>{};
    final centro = Offset(size.width / 2, size.height / 2);
    final lado = min(size.width, size.height);
    final radioCiudades = lado * 0.30;
    final radioPersonas = lado * 0.15;
    final ciudades = red.ciudades;

    for (var i = 0; i < ciudades.length; i++) {
      final angulo = 2 * pi * i / ciudades.length - pi / 2;
      final posCiudad =
          centro + Offset(cos(angulo), sin(angulo)) * radioCiudades;
      posiciones[ciudades[i]] = posCiudad;

      final personas = red.personasEn(ciudades[i]);
      for (var j = 0; j < personas.length; j++) {
        final anguloPersona = angulo + 2 * pi * j / personas.length;
        posiciones[personas[j]] = posCiudad +
            Offset(cos(anguloPersona), sin(anguloPersona)) * radioPersonas;
      }
    }
    return posiciones;
  }

  void escribir(Canvas canvas, String texto, Offset centro, Color color) {
    final pintor = TextPainter(
      text: TextSpan(
        text: texto,
        style: TextStyle(color: color, fontSize: 12),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    pintor.paint(canvas, centro - Offset(pintor.width / 2, pintor.height / 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final posiciones = calcularPosiciones(size);
    final lineaCiudad = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.5;
    final lineaAmistad = Paint()
      ..color = colorAmistad
      ..strokeWidth = 2.5;

    // Aristas: se dibujan primero para que queden debajo de los nodos.
    for (final persona in red.personas) {
      final desde = posiciones[persona];
      if (desde == null) continue;
      final ciudad = red.ciudadDe(persona);
      if (ciudad != null && posiciones[ciudad] != null) {
        canvas.drawLine(desde, posiciones[ciudad]!, lineaCiudad);
      }
      for (final amigo in red.amigosDe(persona)) {
        final hasta = posiciones[amigo];
        if (hasta != null) canvas.drawLine(desde, hasta, lineaAmistad);
      }
    }

    // Nodos.
    for (final entrada in posiciones.entries) {
      final punto = entrada.value;
      switch (entrada.key) {
        case Ciudad ciudad:
          final rect = Rect.fromCenter(center: punto, width: 90, height: 34);
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, const Radius.circular(8)),
            Paint()..color = colorCiudad,
          );
          escribir(canvas, ciudad.nombre, punto, colorTexto);
        case Amigo persona:
          final vive = red.ciudadDe(persona);
          final resaltar =
              ciudadSeleccionada != null && identical(vive, ciudadSeleccionada);
          canvas.drawCircle(
            punto,
            30,
            Paint()..color = resaltar ? colorResaltado : colorPersona,
          );
          escribir(
            canvas,
            '${persona.nombre}\n${persona.edad} años',
            punto,
            colorTexto,
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant GrafoPainter oldDelegate) =>
      oldDelegate.ciudadSeleccionada != ciudadSeleccionada;
}
