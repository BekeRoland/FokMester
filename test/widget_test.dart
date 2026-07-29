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
    expect(find.text('Főzés'), findsOneWidget);
    expect(find.text('Továbbiak'), findsOneWidget);
  });

  testWidgets('angol és román nyelvre vált', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const PalinkaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Továbbiak'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Magyar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('More'), findsWidgets);
    expect(find.text('Mash'), findsOneWidget);
    expect(find.text('Distilling'), findsOneWidget);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Română'));
    await tester.pumpAndSettle();
    expect(find.text('Borhot'), findsOneWidget);
    expect(find.text('Distilare'), findsOneWidget);
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

    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    final continueButton = find.text('Folytatás a főzéssel');
    await tester.tap(continueButton);
    await tester.pumpAndSettle();
    expect(find.text('Főzési útmutató'), findsOneWidget);
    expect(find.text('A cefretervből átvéve: 100 kg'), findsOneWidget);
  });

  testWidgets('a főzés módja kisüsti és tornyos között váltható', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const PalinkaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Főzés'));
    await tester.pumpAndSettle();
    expect(find.text('Kisüsti'), findsWidgets);
    await tester.drag(find.byType(ListView), const Offset(0, -650));
    await tester.pumpAndSettle();
    expect(find.textContaining('kétszeri szakaszos'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, 650));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tornyos').first);
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -650));
    await tester.pumpAndSettle();
    expect(find.textContaining('egy menetben főz és finomít'), findsOneWidget);
  });
}
