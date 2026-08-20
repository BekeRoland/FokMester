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
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    final calculateButton = find.text('Számítás');
    await Scrollable.ensureVisible(
      tester.element(calculateButton),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.tap(calculateButton);
    await tester.pumpAndSettle();

    expect(find.text('20.0 g'), findsOneWidget);
    expect(find.text('5.0–15.0 ml'), findsOneWidget);
    expect(find.text('6.2–7.3 %'), findsOneWidget);
    expect(find.text('14–28 nap'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    final continueButton = find.text('Folytatás a főzéssel');
    await tester.scrollUntilVisible(
      continueButton,
      250,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.drag(find.byType(ListView), const Offset(0, 140));
    await tester.pumpAndSettle();
    await tester.tap(continueButton);
    await tester.pumpAndSettle();
    expect(find.text('Főzési útmutató'), findsOneWidget);
    expect(find.text('A cefretervből átvéve: 100 kg'), findsOneWidget);
  });

  testWidgets('a cefreterv elmenthető és megnyitható a cefrenaplóban', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const PalinkaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cefre'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), '100');
    await tester.enterText(find.byType(TextField).at(1), '20');
    await tester.enterText(find.byType(TextField).at(2), '18');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await Scrollable.ensureVisible(
      tester.element(find.text('Számítás')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Számítás'));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    await Scrollable.ensureVisible(
      tester.element(find.text('Mentés a cefrenaplóba')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mentés a cefrenaplóba'));
    await tester.pumpAndSettle();
    expect(find.text('Elmentve a cefrenaplóba'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Cefrenapló'),
      -300,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.tap(find.text('Cefrenapló'));
    await tester.pumpAndSettle();
    expect(find.textContaining('1 elmentett tétel'), findsNothing);
    expect(find.text('Alma'), findsOneWidget);
    expect(find.textContaining('18 °Bx'), findsOneWidget);
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
    await tester.scrollUntilVisible(
      find.text('78–72%'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('kétszeri szakaszos'), findsOneWidget);
    expect(find.text('78–72%'), findsOneWidget);
    expect(find.text('56–50%'), findsOneWidget);
    expect(find.textContaining('78% értékénél'), findsOneWidget);
    expect(find.textContaining('56% értékénél'), findsOneWidget);
    expect(find.text('Tiszta középpárlat'), findsOneWidget);
    expect(find.textContaining('Tiszta, friss vagy érett alma'), findsWidgets);

    await tester.fling(find.byType(ListView), const Offset(0, 2200), 2500);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tornyos').first);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('88–82%'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('egy menetben főz és finomít'), findsOneWidget);
    expect(find.text('88–82%'), findsOneWidget);
    expect(find.text('74–66%'), findsOneWidget);
    expect(find.textContaining('88% értékénél'), findsOneWidget);
    expect(find.textContaining('74% értékénél'), findsOneWidget);
  });
}
