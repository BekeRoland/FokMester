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

    await tester.tap(find.byTooltip('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Română'));
    await tester.pumpAndSettle();
    expect(find.text('Corectarea concentrației alcoolice'), findsOneWidget);
    expect(find.text('Diluare'), findsOneWidget);
  });
}
