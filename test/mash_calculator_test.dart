import 'package:flutter_test/flutter_test.dart';
import 'package:fokmester/models/mash_fruit_profile.dart';
import 'package:fokmester/services/mash_calculator.dart';

void main() {
  group('MashCalculator', () {
    test('scales yeast, pome enzyme and nutrient ranges by mash mass', () {
      final result = MashCalculator.calculate(
        fruit: mashFruitProfiles.firstWhere((fruit) => fruit.id == 'apple'),
        mashKg: 100,
        yeastDoseGramsPer100Kg: 20,
        brix: 12,
      );

      expect(result.yeastGrams, 20);
      expect(result.enzymeMinMl, 5);
      expect(result.enzymeMaxMl, 15);
      expect(result.nutrientMinGrams, 25);
      expect(result.nutrientMaxGrams, 40);
      expect(result.potentialAbvMin, closeTo(6.24, 0.0001));
      expect(result.potentialAbvMax, closeTo(7.32, 0.0001));
    });

    test('uses the stone-fruit enzyme range', () {
      final result = MashCalculator.calculate(
        fruit: mashFruitProfiles.firstWhere((fruit) => fruit.id == 'plum'),
        mashKg: 250,
        yeastDoseGramsPer100Kg: 22,
        brix: 18,
      );

      expect(result.yeastGrams, 55);
      expect(result.enzymeMinMl, 7.5);
      expect(result.enzymeMaxMl, 12.5);
    });

    test('uses the soft-fruit enzyme range', () {
      final result = MashCalculator.calculate(
        fruit: mashFruitProfiles.firstWhere((fruit) => fruit.id == 'raspberry'),
        mashKg: 50,
        yeastDoseGramsPer100Kg: 20,
        brix: 10,
      );

      expect(result.enzymeMinMl, 1);
      expect(result.enzymeMaxMl, 2.5);
    });

    test('rejects invalid mash mass, yeast dose and Brix', () {
      final fruit = mashFruitProfiles.first;

      expect(
        () => MashCalculator.calculate(
          fruit: fruit,
          mashKg: 0,
          yeastDoseGramsPer100Kg: 20,
          brix: 12,
        ),
        throwsA(
          isA<MashCalculatorException>().having(
            (error) => error.code,
            'code',
            'mash.error.amount',
          ),
        ),
      );
      expect(
        () => MashCalculator.calculate(
          fruit: fruit,
          mashKg: 100,
          yeastDoseGramsPer100Kg: 0,
          brix: 12,
        ),
        throwsA(isA<MashCalculatorException>()),
      );
      expect(
        () => MashCalculator.calculate(
          fruit: fruit,
          mashKg: 100,
          yeastDoseGramsPer100Kg: 20,
          brix: 41,
        ),
        throwsA(isA<MashCalculatorException>()),
      );
    });
  });
}
