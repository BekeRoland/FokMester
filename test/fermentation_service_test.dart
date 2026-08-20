import 'package:flutter_test/flutter_test.dart';
import 'package:fokmester/models/fermentation_profile.dart';
import 'package:fokmester/models/mash_batch.dart';
import 'package:fokmester/models/mash_fruit_profile.dart';
import 'package:fokmester/services/fermentation_service.dart';

void main() {
  test('minden gyümölcshöz külön erjedési profil tartozik', () {
    expect(fermentationProfiles.length, mashFruitProfiles.length);
    expect(
      fermentationProfiles.map((profile) => profile.fruitId).toSet(),
      mashFruitProfiles.map((fruit) => fruit.id).toSet(),
    );
  });

  test('az alma és a szilva eltérő időablakot kap', () {
    final apple = FermentationService.estimate(
      fruitId: 'apple',
      initialBrix: 18,
      temperatureC: 18,
    );
    final plum = FermentationService.estimate(
      fruitId: 'plum',
      initialBrix: 18,
      temperatureC: 18,
    );

    expect(apple.minDays, greaterThan(plum.minDays));
    expect(apple.maxDays, greaterThan(plum.maxDays));
  });

  test('a hideg és a magas kezdeti Brix hosszabbítja a becslést', () {
    final normal = FermentationService.estimate(
      fruitId: 'plum',
      initialBrix: 18,
      temperatureC: 18,
    );
    final difficult = FermentationService.estimate(
      fruitId: 'plum',
      initialBrix: 28,
      temperatureC: 13,
    );

    expect(difficult.minDays, greaterThan(normal.minDays));
    expect(difficult.maxDays, greaterThan(normal.maxDays));
  });

  test(
    '48 órás stabil trend és megszűnt gáz valószínű kész állapotot jelez',
    () {
      final startedAt = DateTime(2026, 8, 1, 8);
      final batch = _batch(
        startedAt: startedAt,
        readings: [
          BrixReading(recordedAt: startedAt, brix: 18),
          BrixReading(
            recordedAt: startedAt.add(const Duration(days: 14)),
            brix: 1,
            gasActivity: false,
          ),
          BrixReading(
            recordedAt: startedAt.add(const Duration(days: 15)),
            brix: 0.9,
            gasActivity: false,
          ),
          BrixReading(
            recordedAt: startedAt.add(const Duration(days: 16)),
            brix: 1,
            gasActivity: false,
          ),
        ],
      );

      final result = FermentationService.assess(
        batch,
        now: startedAt.add(const Duration(days: 16)),
      );
      expect(result.status, FermentationStatus.possiblyComplete);
      expect(result.hasStableReadings, isTrue);
    },
  );

  test('a túl magasan megálló Brix lehetséges elakadást jelez', () {
    final startedAt = DateTime(2026, 8, 1, 8);
    final batch = _batch(
      startedAt: startedAt,
      readings: [
        BrixReading(recordedAt: startedAt, brix: 18),
        BrixReading(
          recordedAt: startedAt.add(const Duration(days: 1)),
          brix: 15,
          gasActivity: false,
        ),
        BrixReading(
          recordedAt: startedAt.add(const Duration(days: 2)),
          brix: 15.1,
          gasActivity: false,
        ),
        BrixReading(
          recordedAt: startedAt.add(const Duration(days: 3)),
          brix: 15,
          gasActivity: false,
        ),
      ],
    );

    final result = FermentationService.assess(
      batch,
      now: startedAt.add(const Duration(days: 3)),
    );
    expect(result.status, FermentationStatus.stalled);
  });

  test('a cefretétel helyi tárolás után veszteség nélkül visszaolvasható', () {
    final startedAt = DateTime(2026, 8, 1, 8);
    final original = _batch(
      startedAt: startedAt,
      readings: [
        BrixReading(
          recordedAt: startedAt,
          brix: 18,
          sampleTemperatureC: 20,
          gasActivity: true,
          note: 'Indítás',
        ),
      ],
    );

    final restored = MashBatch.fromJson(original.toJson());
    expect(restored.id, original.id);
    expect(restored.fruitId, 'apple');
    expect(restored.measurementMethod, BrixMeasurementMethod.hydrometer);
    expect(restored.readings.single.note, 'Indítás');
    expect(restored.readings.single.sampleTemperatureC, 20);
    expect(restored.notificationsEnabled, isFalse);
    expect(restored.reminderHour, 19);
  });
}

MashBatch _batch({
  required DateTime startedAt,
  required List<BrixReading> readings,
}) => MashBatch(
  id: 'batch-1',
  fruitId: 'apple',
  mashKg: 100,
  startedAt: startedAt,
  yeastName: 'Test yeast',
  yeastDoseGramsPer100Kg: 20,
  yeastGrams: 20,
  enzymeMinMl: 5,
  enzymeMaxMl: 15,
  nutrientMinGrams: 25,
  nutrientMaxGrams: 40,
  initialBrix: 18,
  potentialAbvMin: 9.36,
  potentialAbvMax: 10.98,
  fermentationTemperatureC: 18,
  measurementMethod: BrixMeasurementMethod.hydrometer,
  estimatedMinDays: 14,
  estimatedMaxDays: 28,
  readings: readings,
);
