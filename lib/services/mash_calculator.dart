import '../models/mash_fruit_profile.dart';

class MashCalculatorException implements Exception {
  final String code;
  const MashCalculatorException(this.code);
}

class MashCalculationResult {
  final double yeastGrams;
  final double enzymeMinMl;
  final double enzymeMaxMl;
  final double nutrientMinGrams;
  final double nutrientMaxGrams;
  final double potentialAbvMin;
  final double potentialAbvMax;

  const MashCalculationResult({
    required this.yeastGrams,
    required this.enzymeMinMl,
    required this.enzymeMaxMl,
    required this.nutrientMinGrams,
    required this.nutrientMaxGrams,
    required this.potentialAbvMin,
    required this.potentialAbvMax,
  });
}

class MashCalculator {
  // Erbslöh Distizym FM-Top reference ranges at 15 °C, mL/100 kg mash.
  static const Map<MashFruitCategory, (double, double)> enzymeDoseMlPer100Kg = {
    MashFruitCategory.soft: (2, 5),
    MashFruitCategory.stone: (3, 5),
    MashFruitCategory.pome: (5, 15),
  };

  // Erbslöh distilling guide range for cool fruit-mash fermentation.
  static const (double, double) nutrientDoseGramsPer100Kg = (25, 40);

  // Penn State Extension's published approximate °Brix conversion range.
  static const (double, double) brixToPotentialAbv = (0.52, 0.61);

  static MashCalculationResult calculate({
    required MashFruitProfile fruit,
    required double mashKg,
    required double yeastDoseGramsPer100Kg,
    required double brix,
  }) {
    if (mashKg <= 0 || mashKg > 100000) {
      throw const MashCalculatorException('mash.error.amount');
    }
    if (yeastDoseGramsPer100Kg <= 0 || yeastDoseGramsPer100Kg > 500) {
      throw const MashCalculatorException('mash.error.yeastDose');
    }
    if (brix <= 0 || brix > 40) {
      throw const MashCalculatorException('mash.error.brix');
    }

    final scale = mashKg / 100;
    final enzymeDose = enzymeDoseMlPer100Kg[fruit.category]!;
    return MashCalculationResult(
      yeastGrams: yeastDoseGramsPer100Kg * scale,
      enzymeMinMl: enzymeDose.$1 * scale,
      enzymeMaxMl: enzymeDose.$2 * scale,
      nutrientMinGrams: nutrientDoseGramsPer100Kg.$1 * scale,
      nutrientMaxGrams: nutrientDoseGramsPer100Kg.$2 * scale,
      potentialAbvMin: brix * brixToPotentialAbv.$1,
      potentialAbvMax: brix * brixToPotentialAbv.$2,
    );
  }
}
