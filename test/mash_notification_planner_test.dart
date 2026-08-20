import 'package:flutter_test/flutter_test.dart';
import 'package:fokmester/models/mash_batch.dart';
import 'package:fokmester/services/mash_notification_planner.dart';

void main() {
  test('kikapcsolt értesítésnél nem készül ütemezés', () {
    final now = DateTime(2026, 8, 10, 12);
    final batch = _batch(startedAt: DateTime(2026, 8, 10, 8));

    expect(MashNotificationPlanner.create(batch, now: now), isEmpty);
  });

  test('új tételnél másnapi mérés és elmaradási jelzés készül', () {
    final startedAt = DateTime(2026, 8, 10, 8);
    final batch = _batch(startedAt: startedAt, notificationsEnabled: true);

    final plan = MashNotificationPlanner.create(
      batch,
      now: DateTime(2026, 8, 10, 12),
    );
    final measurement = plan.singleWhere(
      (item) => item.type == MashNotificationType.nextMeasurement,
    );
    final overdue = plan.singleWhere(
      (item) => item.type == MashNotificationType.overdueMeasurement,
    );

    expect(measurement.scheduledAt, DateTime(2026, 8, 11, 19));
    expect(overdue.scheduledAt, DateTime(2026, 8, 12, 19));
  });

  test('az erjedési időablak kezdete és vége külön értesítést kap', () {
    final startedAt = DateTime(2026, 8, 1, 8);
    final plan = MashNotificationPlanner.create(
      _batch(startedAt: startedAt, notificationsEnabled: true),
      now: DateTime(2026, 8, 2, 12),
    );

    expect(
      plan
          .singleWhere((item) => item.type == MashNotificationType.windowStart)
          .scheduledAt,
      DateTime(2026, 8, 15, 19),
    );
    expect(
      plan
          .singleWhere((item) => item.type == MashNotificationType.windowEnd)
          .scheduledAt,
      DateTime(2026, 8, 30, 19),
    );
  });

  test('a napi cefreellenőrzés ismétlődő értesítés', () {
    final plan = MashNotificationPlanner.create(
      _batch(
        startedAt: DateTime(2026, 8, 10, 8),
        notificationsEnabled: true,
        dailyMashCheckEnabled: true,
      ),
      now: DateTime(2026, 8, 10, 20),
    );
    final daily = plan.singleWhere(
      (item) => item.type == MashNotificationType.dailyCheck,
    );

    expect(daily.scheduledAt, DateTime(2026, 8, 11, 19));
    expect(daily.repeatsDaily, isTrue);
  });

  test('valószínű kierjedés után minden emlékeztető megszűnik', () {
    final startedAt = DateTime(2026, 8, 1, 8);
    final batch = _batch(
      startedAt: startedAt,
      notificationsEnabled: true,
      readings: [
        BrixReading(recordedAt: startedAt, brix: 18),
        BrixReading(
          recordedAt: startedAt.add(const Duration(days: 14)),
          brix: 1,
          gasActivity: false,
        ),
        BrixReading(
          recordedAt: startedAt.add(const Duration(days: 15)),
          brix: 1.1,
          gasActivity: false,
        ),
        BrixReading(
          recordedAt: startedAt.add(const Duration(days: 16)),
          brix: 1,
          gasActivity: false,
        ),
      ],
    );

    expect(
      MashNotificationPlanner.create(
        batch,
        now: startedAt.add(const Duration(days: 16)),
      ),
      isEmpty,
    );
  });
}

MashBatch _batch({
  required DateTime startedAt,
  bool notificationsEnabled = false,
  bool dailyMashCheckEnabled = false,
  List<BrixReading>? readings,
}) => MashBatch(
  id: 'notification-batch',
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
  notificationsEnabled: notificationsEnabled,
  reminderHour: 19,
  reminderMinute: 0,
  dailyMashCheckEnabled: dailyMashCheckEnabled,
  readings: readings ?? [BrixReading(recordedAt: startedAt, brix: 18)],
);
