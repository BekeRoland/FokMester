enum BrixMeasurementMethod { hydrometer, refractometer }

class BrixReading {
  final DateTime recordedAt;
  final double brix;
  final double? sampleTemperatureC;
  final bool? gasActivity;
  final String note;

  const BrixReading({
    required this.recordedAt,
    required this.brix,
    this.sampleTemperatureC,
    this.gasActivity,
    this.note = '',
  });

  Map<String, dynamic> toJson() => {
    'recordedAt': recordedAt.toIso8601String(),
    'brix': brix,
    'sampleTemperatureC': sampleTemperatureC,
    'gasActivity': gasActivity,
    'note': note,
  };

  factory BrixReading.fromJson(Map<String, dynamic> json) => BrixReading(
    recordedAt: DateTime.parse(json['recordedAt'] as String),
    brix: (json['brix'] as num).toDouble(),
    sampleTemperatureC: (json['sampleTemperatureC'] as num?)?.toDouble(),
    gasActivity: json['gasActivity'] as bool?,
    note: json['note'] as String? ?? '',
  );
}

class MashBatch {
  final String id;
  final String fruitId;
  final double mashKg;
  final DateTime startedAt;
  final String yeastName;
  final double yeastDoseGramsPer100Kg;
  final double yeastGrams;
  final double enzymeMinMl;
  final double enzymeMaxMl;
  final double nutrientMinGrams;
  final double nutrientMaxGrams;
  final double initialBrix;
  final double potentialAbvMin;
  final double potentialAbvMax;
  final double fermentationTemperatureC;
  final BrixMeasurementMethod measurementMethod;
  final int estimatedMinDays;
  final int estimatedMaxDays;
  final bool notificationsEnabled;
  final int reminderHour;
  final int reminderMinute;
  final bool dailyMashCheckEnabled;
  final List<BrixReading> readings;

  const MashBatch({
    required this.id,
    required this.fruitId,
    required this.mashKg,
    required this.startedAt,
    required this.yeastName,
    required this.yeastDoseGramsPer100Kg,
    required this.yeastGrams,
    required this.enzymeMinMl,
    required this.enzymeMaxMl,
    required this.nutrientMinGrams,
    required this.nutrientMaxGrams,
    required this.initialBrix,
    required this.potentialAbvMin,
    required this.potentialAbvMax,
    required this.fermentationTemperatureC,
    required this.measurementMethod,
    required this.estimatedMinDays,
    required this.estimatedMaxDays,
    this.notificationsEnabled = false,
    this.reminderHour = 19,
    this.reminderMinute = 0,
    this.dailyMashCheckEnabled = false,
    required this.readings,
  });

  MashBatch copyWith({
    List<BrixReading>? readings,
    bool? notificationsEnabled,
    int? reminderHour,
    int? reminderMinute,
    bool? dailyMashCheckEnabled,
  }) => MashBatch(
    id: id,
    fruitId: fruitId,
    mashKg: mashKg,
    startedAt: startedAt,
    yeastName: yeastName,
    yeastDoseGramsPer100Kg: yeastDoseGramsPer100Kg,
    yeastGrams: yeastGrams,
    enzymeMinMl: enzymeMinMl,
    enzymeMaxMl: enzymeMaxMl,
    nutrientMinGrams: nutrientMinGrams,
    nutrientMaxGrams: nutrientMaxGrams,
    initialBrix: initialBrix,
    potentialAbvMin: potentialAbvMin,
    potentialAbvMax: potentialAbvMax,
    fermentationTemperatureC: fermentationTemperatureC,
    measurementMethod: measurementMethod,
    estimatedMinDays: estimatedMinDays,
    estimatedMaxDays: estimatedMaxDays,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    reminderHour: reminderHour ?? this.reminderHour,
    reminderMinute: reminderMinute ?? this.reminderMinute,
    dailyMashCheckEnabled: dailyMashCheckEnabled ?? this.dailyMashCheckEnabled,
    readings: readings ?? this.readings,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fruitId': fruitId,
    'mashKg': mashKg,
    'startedAt': startedAt.toIso8601String(),
    'yeastName': yeastName,
    'yeastDoseGramsPer100Kg': yeastDoseGramsPer100Kg,
    'yeastGrams': yeastGrams,
    'enzymeMinMl': enzymeMinMl,
    'enzymeMaxMl': enzymeMaxMl,
    'nutrientMinGrams': nutrientMinGrams,
    'nutrientMaxGrams': nutrientMaxGrams,
    'initialBrix': initialBrix,
    'potentialAbvMin': potentialAbvMin,
    'potentialAbvMax': potentialAbvMax,
    'fermentationTemperatureC': fermentationTemperatureC,
    'measurementMethod': measurementMethod.name,
    'estimatedMinDays': estimatedMinDays,
    'estimatedMaxDays': estimatedMaxDays,
    'notificationsEnabled': notificationsEnabled,
    'reminderHour': reminderHour,
    'reminderMinute': reminderMinute,
    'dailyMashCheckEnabled': dailyMashCheckEnabled,
    'readings': readings.map((reading) => reading.toJson()).toList(),
  };

  factory MashBatch.fromJson(Map<String, dynamic> json) => MashBatch(
    id: json['id'] as String,
    fruitId: json['fruitId'] as String,
    mashKg: (json['mashKg'] as num).toDouble(),
    startedAt: DateTime.parse(json['startedAt'] as String),
    yeastName: json['yeastName'] as String? ?? '',
    yeastDoseGramsPer100Kg: (json['yeastDoseGramsPer100Kg'] as num).toDouble(),
    yeastGrams: (json['yeastGrams'] as num).toDouble(),
    enzymeMinMl: (json['enzymeMinMl'] as num).toDouble(),
    enzymeMaxMl: (json['enzymeMaxMl'] as num).toDouble(),
    nutrientMinGrams: (json['nutrientMinGrams'] as num).toDouble(),
    nutrientMaxGrams: (json['nutrientMaxGrams'] as num).toDouble(),
    initialBrix: (json['initialBrix'] as num).toDouble(),
    potentialAbvMin: (json['potentialAbvMin'] as num).toDouble(),
    potentialAbvMax: (json['potentialAbvMax'] as num).toDouble(),
    fermentationTemperatureC: (json['fermentationTemperatureC'] as num)
        .toDouble(),
    measurementMethod: BrixMeasurementMethod.values.firstWhere(
      (method) => method.name == json['measurementMethod'],
      orElse: () => BrixMeasurementMethod.hydrometer,
    ),
    estimatedMinDays: json['estimatedMinDays'] as int,
    estimatedMaxDays: json['estimatedMaxDays'] as int,
    notificationsEnabled: json['notificationsEnabled'] as bool? ?? false,
    reminderHour: json['reminderHour'] as int? ?? 19,
    reminderMinute: json['reminderMinute'] as int? ?? 0,
    dailyMashCheckEnabled: json['dailyMashCheckEnabled'] as bool? ?? false,
    readings: (json['readings'] as List<dynamic>? ?? const [])
        .map((item) => BrixReading.fromJson(item as Map<String, dynamic>))
        .toList(),
  );
}
