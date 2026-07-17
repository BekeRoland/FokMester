import 'package:flutter_test/flutter_test.dart';
import 'package:fokmester/services/alcohol_calculator.dart';

void main() {
  group('hőmérséklet-korrekció', () {
    test('pontos táblázati pontot visszaad', () {
      expect(AlcoholCalculator.correctAlcohol(40, 20), 40);
    });

    test('két dimenzióban interpolál', () {
      expect(AlcoholCalculator.correctAlcohol(41, 20.5), closeTo(40.8, .0001));
    });

    test('elutasítja a tartományon kívüli adatot', () {
      expect(
        () => AlcoholCalculator.correctAlcohol(9, 20),
        throwsA(isA<CalculatorException>()),
      );
      expect(
        () => AlcoholCalculator.correctAlcohol(40, 31),
        throwsA(isA<CalculatorException>()),
      );
    });

    test('nem ad nullát a hiányos 98%-os sorból', () {
      expect(
        () => AlcoholCalculator.correctAlcohol(98, 5),
        throwsA(isA<CalculatorException>()),
      );
    });
  });

  test('hígítás', () {
    final result = AlcoholCalculator.calculateDilution(
      currentAbv: 50,
      volumeLiters: 10,
      targetAbv: 40,
    );
    expect(result.waterLiters, closeTo(2.5, .0001));
    expect(result.finalVolume, closeTo(12.5, .0001));
  });

  test('kívánt végtérfogat', () {
    final result = AlcoholCalculator.calculateForFinalVolume(
      sourceAbv: 80,
      targetAbv: 40,
      finalVolumeLiters: 10,
    );
    expect(result.spiritLiters, 5);
    expect(result.waterLiters, 5);
  });

  test('két folyadék keverése', () {
    final result = AlcoholCalculator.mix(
      firstAbv: 60,
      firstVolumeLiters: 2,
      secondAbv: 40,
      secondVolumeLiters: 2,
    );
    expect(result.finalAbv, 50);
    expect(result.finalVolume, 4);
  });
}
