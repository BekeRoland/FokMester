import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_10y.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../l10n/app_localizations.dart';
import '../models/mash_batch.dart';
import '../models/mash_fruit_profile.dart';
import 'fermentation_service.dart';
import 'mash_notification_planner.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const _channelId = 'mash_journal_reminders';
  static const _channelName = 'Cefrenapló';
  static const _channelDescription =
      'Cefremérések, erjedési állapotok és időablakok emlékeztetői';
  static const _alertChannelId = 'mash_journal_alerts';
  static const _alertChannelName = 'Cefrenapló figyelmeztetések';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  ValueChanged<String>? _onBatchSelected;
  String? _pendingBatchId;

  bool get isSupported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<void> initialize() async {
    if (_initialized || !isSupported) return;
    try {
      tz_data.initializeTimeZones();
      try {
        final timezone = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(timezone.identifier));
      } on Object {
        tz.setLocalLocation(tz.getLocation('UTC'));
      }

      const settings = InitializationSettings(
        android: AndroidInitializationSettings('ic_notification'),
      );
      await _plugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (response) {
          final batchId = response.payload;
          if (batchId != null && batchId.isNotEmpty) _selectBatch(batchId);
        },
      );
      final launchDetails = await _plugin.getNotificationAppLaunchDetails();
      final launchPayload = launchDetails?.notificationResponse?.payload;
      if ((launchDetails?.didNotificationLaunchApp ?? false) &&
          launchPayload != null &&
          launchPayload.isNotEmpty) {
        _pendingBatchId = launchPayload;
      }
      _initialized = true;
    } on Object {
      _initialized = false;
    }
  }

  void attachBatchSelectionHandler(ValueChanged<String> handler) {
    _onBatchSelected = handler;
    final pending = _pendingBatchId;
    if (pending != null) {
      _pendingBatchId = null;
      handler(pending);
    }
  }

  void detachBatchSelectionHandler() => _onBatchSelected = null;

  Future<bool> requestPermission() async {
    if (!isSupported) return false;
    await initialize();
    if (!_initialized) return false;
    try {
      return await _plugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.requestNotificationsPermission() ??
          false;
    } on Object {
      return false;
    }
  }

  Future<void> scheduleForBatch(
    MashBatch batch, {
    required String languageCode,
  }) async {
    if (!isSupported) return;
    await initialize();
    if (!_initialized) return;
    await cancelForBatch(batch.id);
    if (!batch.notificationsEnabled) return;

    final strings = AppLocalizations(Locale(languageCode));
    final fruit = mashFruitProfiles.firstWhere(
      (item) => item.id == batch.fruitId,
      orElse: () => mashFruitProfiles.first,
    );
    final fruitName = fruit.name(languageCode);
    for (final planned in MashNotificationPlanner.create(batch)) {
      if (!planned.scheduledAt.isAfter(DateTime.now())) continue;
      final text = _textFor(
        planned.type,
        fruit: fruit,
        fruitName: fruitName,
        strings: strings,
      );
      try {
        await _plugin.zonedSchedule(
          id: _notificationId(batch.id, planned.type.index),
          title: text.$1,
          body: text.$2,
          scheduledDate: tz.TZDateTime.from(planned.scheduledAt, tz.local),
          notificationDetails: _details(),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: planned.repeatsDaily
              ? DateTimeComponents.time
              : null,
          payload: batch.id,
        );
      } on Object {
        // Az értesítés hibája nem akadályozhatja a cefrenapló használatát.
      }
    }
  }

  Future<void> notifyStatusChange(
    MashBatch batch,
    FermentationStatus status, {
    required String languageCode,
  }) async {
    if (!isSupported || !batch.notificationsEnabled) return;
    if (status != FermentationStatus.stalled &&
        status != FermentationStatus.possiblyComplete) {
      return;
    }
    await initialize();
    if (!_initialized) return;
    final strings = AppLocalizations(Locale(languageCode));
    final fruit = mashFruitProfiles.firstWhere(
      (item) => item.id == batch.fruitId,
      orElse: () => mashFruitProfiles.first,
    );
    final type = status == FermentationStatus.possiblyComplete
        ? 'complete'
        : 'stalled';
    if (status == FermentationStatus.possiblyComplete) {
      await cancelForBatch(batch.id);
    }
    try {
      await _plugin.show(
        id: _notificationId(batch.id, status.index + 10),
        title: strings
            .tr('notification.$type.title')
            .replaceAll('{fruit}', fruit.name(languageCode)),
        body: strings.tr('notification.$type.body'),
        notificationDetails: _details(important: true),
        payload: batch.id,
      );
    } on Object {
      // Az alkalmazáson belüli állapotjelzés ettől még elérhető marad.
    }
  }

  Future<void> cancelForBatch(String batchId) async {
    if (!isSupported) return;
    await initialize();
    if (!_initialized) return;
    for (var slot = 0; slot < 20; slot++) {
      try {
        await _plugin.cancel(id: _notificationId(batchId, slot));
      } on Object {
        // Egy sikertelen törlés nem akadályozhatja a többi emlékeztetőt.
      }
    }
  }

  NotificationDetails _details({bool important = false}) => NotificationDetails(
    android: AndroidNotificationDetails(
      important ? _alertChannelId : _channelId,
      important ? _alertChannelName : _channelName,
      channelDescription: _channelDescription,
      importance: important ? Importance.high : Importance.defaultImportance,
      priority: important ? Priority.high : Priority.defaultPriority,
      category: AndroidNotificationCategory.reminder,
    ),
  );

  (String, String) _textFor(
    MashNotificationType type, {
    required MashFruitProfile fruit,
    required String fruitName,
    required AppLocalizations strings,
  }) {
    final key = switch (type) {
      MashNotificationType.nextMeasurement => 'measurement',
      MashNotificationType.overdueMeasurement => 'overdue',
      MashNotificationType.windowStart => 'windowStart',
      MashNotificationType.windowEnd => 'windowEnd',
      MashNotificationType.dailyCheck => _dailyCheckKey(fruit),
    };
    return (
      strings.tr('notification.$key.title').replaceAll('{fruit}', fruitName),
      strings.tr('notification.$key.body'),
    );
  }

  String _dailyCheckKey(MashFruitProfile fruit) {
    if (fruit.id == 'sour_cherry') return 'dailyCheck.foaming';
    if (const ['quince', 'rosehip', 'sloe'].contains(fruit.id)) {
      return 'dailyCheck.dense';
    }
    return switch (fruit.category) {
      MashFruitCategory.pome => 'dailyCheck.pome',
      MashFruitCategory.stone => 'dailyCheck.stone',
      MashFruitCategory.soft => 'dailyCheck.soft',
    };
  }

  int _notificationId(String batchId, int slot) {
    var hash = 17;
    for (final codeUnit in batchId.codeUnits) {
      hash = (hash * 31 + codeUnit) & 0x07ffffff;
    }
    return (hash % 100000000) * 20 + slot;
  }

  void _selectBatch(String batchId) {
    final handler = _onBatchSelected;
    if (handler == null) {
      _pendingBatchId = batchId;
    } else {
      handler(batchId);
    }
  }
}
