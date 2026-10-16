import 'package:flutter_test/flutter_test.dart';

import 'package:edd2_retos/main.dart';

void main() {
  testWidgets('La pantalla de inicio carga', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Estructuras de Datos II'), findsOneWidget);
  });
}
