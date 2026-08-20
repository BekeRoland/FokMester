import 'dart:math' as math;

import '../models/fermentation_profile.dart';
import '../models/mash_batch.dart';

class FermentationEstimate {
  final int minDays;
  final int maxDays;

  const FermentationEstimate(this.minDays, this.maxDays);
}

enum FermentationStatus {
  active,
  checkSoon,
  stableTrend,
  possiblyComplete,
  stalled,
}

class FermentationAssessment {
  final FermentationStatus status;
  final bool hasStableReadings;

  const FermentationAssessment(this.status, {this.hasStableReadings = false});
}

class FermentationService {
  static FermentationEstimate estimate({
    required String fruitId,
    required double initialBrix,
    required double temperatureC,
  }) {
    final profile = fermentationProfiles.firstWhere(
      (item) => item.fruitId == fruitId,
      orElse: () => const FermentationProfile(
        fruitId: 'fallback',
        minDays: 10,
        maxDays: 21,
      ),
    );

    var factor = 1.0;
    if (temperatureC < 12) {
      factor *= 1.75;
    } else if (temperatureC < 15) {
      factor *= 1.4;
    } else if (temperatureC < 17) {
      factor *= 1.15;
    } else if (temperatureC > 24) {
      factor *= 0.9;
    }
    if (initialBrix >= 28) {
      factor *= 1.35;
    } else if (initialBrix >= 24) {
      factor *= 1.2;
    }

    return FermentationEstimate(
      math.max(1, (profile.minDays * factor).ceil()),
      math.max(2, (profile.maxDays * factor).ceil()),
    );
  }

  static FermentationAssessment assess(MashBatch batch, {DateTime? now}) {
    final readings = [...batch.readings]
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
    final age =
        (now ?? DateTime.now()).difference(batch.startedAt).inHours / 24;
    if (readings.length < 3) {
      return FermentationAssessment(
        age >= batch.estimatedMinDays
            ? FermentationStatus.checkSoon
            : FermentationStatus.active,
      );
    }

    final latestThree = readings.sublist(readings.length - 3);
    final span = latestThree.last.recordedAt.difference(
      latestThree.first.recordedAt,
    );
    final values = latestThree.map((reading) => reading.brix);
    final spread = values.reduce(math.max) - values.reduce(math.min);
    final stable = span.inHours >= 48 && spread <= 0.3;
    if (!stable) {
      return FermentationAssessment(
        age >= batch.estimatedMaxDays
            ? FermentationStatus.checkSoon
            : FermentationStatus.active,
      );
    }

    final noGas = latestThree.last.gasActivity == false;
    final substantialDrop = latestThree.last.brix <= batch.initialBrix * 0.45;
    if (noGas && substantialDrop && age >= batch.estimatedMinDays) {
      return const FermentationAssessment(
        FermentationStatus.possiblyComplete,
        hasStableReadings: true,
      );
    }
    if (!substantialDrop || age < batch.estimatedMinDays) {
      return const FermentationAssessment(
        FermentationStatus.stalled,
        hasStableReadings: true,
      );
    }
    return const FermentationAssessment(
      FermentationStatus.stableTrend,
      hasStableReadings: true,
    );
  }
}
