import '../models/mash_batch.dart';
import 'fermentation_service.dart';

enum MashNotificationType {
  nextMeasurement,
  overdueMeasurement,
  windowStart,
  windowEnd,
  dailyCheck,
}

class PlannedMashNotification {
  final MashNotificationType type;
  final DateTime scheduledAt;
  final bool repeatsDaily;

  const PlannedMashNotification({
    required this.type,
    required this.scheduledAt,
    this.repeatsDaily = false,
  });
}

class MashNotificationPlanner {
  static List<PlannedMashNotification> create(
    MashBatch batch, {
    DateTime? now,
  }) {
    final current = now ?? DateTime.now();
    if (!batch.notificationsEnabled ||
        FermentationService.assess(batch, now: current).status ==
            FermentationStatus.possiblyComplete) {
      return const [];
    }

    final readings = [...batch.readings]
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
    final latest = readings.isEmpty
        ? batch.startedAt
        : readings.last.recordedAt;
    final ageDays = current.difference(batch.startedAt).inHours / 24;
    final stablePair =
        readings.length >= 2 &&
        readings.last.recordedAt
                .difference(readings[readings.length - 2].recordedAt)
                .inHours >=
            18 &&
        (readings.last.brix - readings[readings.length - 2].brix).abs() <= 0.3;
    final nearFinish = ageDays >= batch.estimatedMinDays - 2;
    final cadenceDays = readings.length <= 3 || nearFinish || stablePair
        ? 1
        : 2;
    final plannedDue = _atReminderTime(
      latest.add(Duration(days: cadenceDays)),
      batch,
    );
    final result = <PlannedMashNotification>[];

    if (plannedDue.isAfter(current)) {
      result.add(
        PlannedMashNotification(
          type: MashNotificationType.nextMeasurement,
          scheduledAt: plannedDue,
        ),
      );
      result.add(
        PlannedMashNotification(
          type: MashNotificationType.overdueMeasurement,
          scheduledAt: plannedDue.add(const Duration(days: 1)),
        ),
      );
    } else {
      result.add(
        PlannedMashNotification(
          type: MashNotificationType.overdueMeasurement,
          scheduledAt: current.add(const Duration(minutes: 2)),
        ),
      );
    }

    final windowStart = _atReminderTime(
      batch.startedAt.add(Duration(days: batch.estimatedMinDays)),
      batch,
    );
    if (windowStart.isAfter(current)) {
      result.add(
        PlannedMashNotification(
          type: MashNotificationType.windowStart,
          scheduledAt: windowStart,
        ),
      );
    }

    final windowEnd = _atReminderTime(
      batch.startedAt.add(Duration(days: batch.estimatedMaxDays + 1)),
      batch,
    );
    if (windowEnd.isAfter(current)) {
      result.add(
        PlannedMashNotification(
          type: MashNotificationType.windowEnd,
          scheduledAt: windowEnd,
        ),
      );
    }

    if (batch.dailyMashCheckEnabled) {
      var nextDaily = DateTime(
        current.year,
        current.month,
        current.day,
        batch.reminderHour,
        batch.reminderMinute,
      );
      if (!nextDaily.isAfter(current)) {
        nextDaily = nextDaily.add(const Duration(days: 1));
      }
      result.add(
        PlannedMashNotification(
          type: MashNotificationType.dailyCheck,
          scheduledAt: nextDaily,
          repeatsDaily: true,
        ),
      );
    }

    return result;
  }

  static DateTime _atReminderTime(DateTime date, MashBatch batch) => DateTime(
    date.year,
    date.month,
    date.day,
    batch.reminderHour,
    batch.reminderMinute,
  );
}
