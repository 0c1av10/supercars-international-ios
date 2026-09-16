import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:supercars_international/main.dart';
import 'package:supercars_international/models.dart';

void main() {
  testWidgets('App boots into the catalog tab', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperCarsApp());
    await tester.pumpAndSettle();

    expect(find.text('Catálogo'), findsWidgets);
    expect(find.text('CHINA → VENEZUELA · IMPORTACIÓN MUNDIAL'), findsOneWidget);
    expect(find.text('Corolla Levin 1.5L'), findsOneWidget);
  });

  testWidgets('Catalog filters by condition', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperCarsApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Usado').first);
    await tester.pumpAndSettle();

    // Only the featured used vehicle remains.
    expect(find.text('Corolla Levin 1.5L'), findsOneWidget);
    expect(find.text('Camry Sport'), findsNothing);
  });

  testWidgets('Vehicle card opens detail with price', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperCarsApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Corolla Levin 1.5L'));
    await tester.pumpAndSettle();

    // Scroll the pushed detail route so the pricing block builds.
    await tester.drag(find.byType(ListView).last, const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('US\$ 7.850'), findsWidgets);
    expect(find.text('US\$ 22.850'), findsWidgets);
    await tester.drag(find.byType(ListView).last, const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('Cotizar este vehículo'), findsWidgets);
  });

  testWidgets('Bottom nav switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperCarsApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nosotros'));
    await tester.pumpAndSettle();
    expect(find.image(const AssetImage('assets/images/logo.png')), findsWidgets);
    expect(find.text('Nuestra historia'), findsOneWidget);

    await tester.tap(find.text('Cotizar'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).last, const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(find.text('Enviar cotización por WhatsApp'), findsWidgets);
  });

  test('Catalog data is coherent', () {
    expect(Catalog.vehicles, isNotEmpty);
    expect(Catalog.vehicles.where((v) => v.featured).length, 1);
    for (final v in Catalog.vehicles) {
      expect(v.vehiclePrice, startsWith('US\$'));
      expect(v.landedPrice, startsWith('US\$'));
      expect(v.highlights, isNotEmpty);
    }
  });
}
