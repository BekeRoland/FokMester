import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokmester/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('megjeleníti a FokMester fő funkcióit', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const PalinkaApp());
    await tester.pumpAndSettle();
    expect(find.text('Szeszfok-korrekció'), findsOneWidget);
    expect(find.text('Hígítás'), findsOneWidget);
    expect(find.text('Cefre'), findsOneWidget);
    expect(find.text('Útmutató'), findsOneWidget);
    expect(find.text('Előzmény'), findsOneWidget);
  });

  testWidgets('angol és román nyelvre vált', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const PalinkaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Nyelv'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Alcohol strength correction'), findsOneWidget);
    expect(find.text('Dilution'), findsOneWidget);
    expect(find.text('Mash'), findsOneWidget);

    await tester.tap(find.byTooltip('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Română'));
    await tester.pumpAndSettle();
    expect(find.text('Corectarea concentrației alcoolice'), findsOneWidget);
    expect(find.text('Diluare'), findsOneWidget);
    expect(find.text('Borhot'), findsOneWidget);
  });

  testWidgets('cefrét számol és gyümölcsspecifikus útmutatót mutat', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const PalinkaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cefre'));
    await tester.pumpAndSettle();
    expect(find.text('Cefretervező'), findsOneWidget);
    expect(find.text('Alma'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '100');
    await tester.enterText(find.byType(TextField).at(1), '20');
    await tester.enterText(find.byType(TextField).at(2), '12');
    final calculateButton = find.text('Számítás');
    await tester.ensureVisible(calculateButton);
    await tester.tap(calculateButton);
    await tester.pumpAndSettle();

    expect(find.text('20.0 g'), findsOneWidget);
    expect(find.text('5.0–15.0 ml'), findsOneWidget);
    expect(find.text('6.2–7.3 %'), findsOneWidget);
  });
}
