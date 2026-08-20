import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/mash_batch.dart';
import '../models/mash_fruit_profile.dart';
import '../services/fermentation_service.dart';
import '../services/notification_service.dart';
import '../utils/number_parser.dart';
import '../widgets/input_field.dart';

class MashJournalScreen extends StatefulWidget {
  final List<MashBatch> batches;
  final ValueChanged<MashBatch> onBatchUpdated;

  const MashJournalScreen({
    super.key,
    required this.batches,
    required this.onBatchUpdated,
  });

  @override
  State<MashJournalScreen> createState() => _MashJournalScreenState();
}

class _MashJournalScreenState extends State<MashJournalScreen> {
  late final List<MashBatch> _batches = [...widget.batches];

  void _updateBatch(MashBatch updated) {
    final index = _batches.indexWhere((batch) => batch.id == updated.id);
    if (index < 0) return;
    setState(() => _batches[index] = updated);
    widget.onBatchUpdated(updated);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    if (_batches.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu_book_outlined, size: 58),
              const SizedBox(height: 16),
              Text(
                strings.tr('journal.empty.title'),
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                strings.tr('journal.empty.body'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _batches.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final batch = _batches[index];
        final fruit = mashFruitProfiles.firstWhere(
          (item) => item.id == batch.fruitId,
          orElse: () => mashFruitProfiles.first,
        );
        final assessment = FermentationService.assess(batch);
        final latest = batch.readings.isEmpty
            ? batch.initialBrix
            : batch.readings
                  .reduce((a, b) => a.recordedAt.isAfter(b.recordedAt) ? a : b)
                  .brix;
        return Card(
          child: ListTile(
            minTileHeight: 92,
            contentPadding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
            leading: _StatusIcon(status: assessment.status),
            title: Text(
              fruit.name(languageCode),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${_date(batch.startedAt, languageCode)} · ${_number(batch.mashKg)} kg\n'
              '${strings.tr(_statusKey(assessment.status))} · ${_number(latest)} °Bx',
            ),
            isThreeLine: true,
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (_) => MashBatchDetailScreen(
                    batch: batch,
                    onBatchUpdated: _updateBatch,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class MashBatchDetailScreen extends StatefulWidget {
  final MashBatch batch;
  final ValueChanged<MashBatch> onBatchUpdated;

  const MashBatchDetailScreen({
    super.key,
    required this.batch,
    required this.onBatchUpdated,
  });

  @override
  State<MashBatchDetailScreen> createState() => _MashBatchDetailScreenState();
}

class _MashBatchDetailScreenState extends State<MashBatchDetailScreen> {
  late MashBatch _batch = widget.batch;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final fruit = mashFruitProfiles.firstWhere(
      (item) => item.id == _batch.fruitId,
      orElse: () => mashFruitProfiles.first,
    );
    final assessment = FermentationService.assess(_batch);
    final readings = [..._batch.readings]
      ..sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    final estimatedFrom = _batch.startedAt.add(
      Duration(days: _batch.estimatedMinDays),
    );
    final estimatedTo = _batch.startedAt.add(
      Duration(days: _batch.estimatedMaxDays),
    );

    return Scaffold(
      appBar: AppBar(title: Text(fruit.name(languageCode))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _StatusCard(status: assessment.status, strings: strings),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _InfoLine(
                    label: strings.tr('journal.startedAt'),
                    value: _dateTime(_batch.startedAt, languageCode),
                  ),
                  _InfoLine(
                    label: strings.tr('journal.amount'),
                    value: '${_number(_batch.mashKg)} kg',
                  ),
                  _InfoLine(
                    label: strings.tr('journal.initialBrix'),
                    value: '${_number(_batch.initialBrix)} °Bx',
                  ),
                  _InfoLine(
                    label: strings.tr('journal.temperature'),
                    value: '${_number(_batch.fermentationTemperatureC)} °C',
                  ),
                  _InfoLine(
                    label: strings.tr('journal.yeast'),
                    value: _batch.yeastName.isEmpty
                        ? '${_number(_batch.yeastGrams)} g'
                        : '${_batch.yeastName} · ${_number(_batch.yeastGrams)} g',
                  ),
                  _InfoLine(
                    label: strings.tr('journal.yeastDose'),
                    value: '${_number(_batch.yeastDoseGramsPer100Kg)} g/100 kg',
                  ),
                  _InfoLine(
                    label: strings.tr('journal.enzyme'),
                    value:
                        '${_number(_batch.enzymeMinMl)}–${_number(_batch.enzymeMaxMl)} ml',
                  ),
                  _InfoLine(
                    label: strings.tr('journal.nutrient'),
                    value:
                        '${_number(_batch.nutrientMinGrams)}–${_number(_batch.nutrientMaxGrams)} g',
                  ),
                  _InfoLine(
                    label: strings.tr('journal.potentialAbv'),
                    value:
                        '${_batch.potentialAbvMin.toStringAsFixed(1)}–${_batch.potentialAbvMax.toStringAsFixed(1)} %',
                  ),
                  _InfoLine(
                    label: strings.tr('journal.method'),
                    value: strings.tr(
                      'journal.method.${_batch.measurementMethod.name}',
                    ),
                  ),
                  _InfoLine(
                    label: strings.tr('journal.estimate'),
                    value:
                        '${_date(estimatedFrom, languageCode)} – ${_date(estimatedTo, languageCode)}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _NotificationSettingsCard(
            batch: _batch,
            onChanged: _updateNotificationSettings,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: _addReading,
              icon: const Icon(Icons.add_chart_rounded),
              label: Text(strings.tr('journal.addReading')),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            strings.tr('journal.measurements'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          for (final reading in readings)
            Card(
              child: ListTile(
                leading: const Icon(Icons.water_drop_outlined),
                title: Text(
                  '${_number(reading.brix)} °Bx',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  [
                    _dateTime(reading.recordedAt, languageCode),
                    if (reading.gasActivity != null)
                      strings.tr(
                        reading.gasActivity!
                            ? 'journal.gas.yes'
                            : 'journal.gas.no',
                      ),
                    if (reading.sampleTemperatureC != null)
                      '${strings.tr('journal.sampleTemperatureShort')}: ${_number(reading.sampleTemperatureC!)} °C',
                    if (reading.note.trim().isNotEmpty) reading.note.trim(),
                  ].join('\n'),
                ),
              ),
            ),
          const SizedBox(height: 8),
          _MeasurementNotice(method: _batch.measurementMethod),
        ],
      ),
    );
  }

  Future<void> _addReading() async {
    final reading = await showModalBottomSheet<BrixReading>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AddReadingSheet(firstDate: _batch.startedAt),
    );
    if (reading == null || !mounted) return;
    setState(() {
      _batch = _batch.copyWith(readings: [..._batch.readings, reading]);
    });
    widget.onBatchUpdated(_batch);
  }

  void _updateNotificationSettings(MashBatch updated) {
    setState(() => _batch = updated);
    widget.onBatchUpdated(updated);
  }
}

class _NotificationSettingsCard extends StatelessWidget {
  final MashBatch batch;
  final ValueChanged<MashBatch> onChanged;

  const _NotificationSettingsCard({
    required this.batch,
    required this.onChanged,
  });

  Future<void> _toggle(BuildContext context, bool enabled) async {
    if (enabled) {
      final granted = await NotificationService.instance.requestPermission();
      if (!context.mounted) return;
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).tr('notifications.permissionDenied'),
            ),
          ),
        );
        return;
      }
    }
    onChanged(
      batch.copyWith(
        notificationsEnabled: enabled,
        dailyMashCheckEnabled: enabled ? batch.dailyMashCheckEnabled : false,
      ),
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: batch.reminderHour,
        minute: batch.reminderMinute,
      ),
    );
    if (selected == null) return;
    onChanged(
      batch.copyWith(
        reminderHour: selected.hour,
        reminderMinute: selected.minute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final supported = NotificationService.instance.isSupported;
    final time = TimeOfDay(
      hour: batch.reminderHour,
      minute: batch.reminderMinute,
    );
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active_outlined),
            title: Text(strings.tr('notifications.smart')),
            subtitle: Text(
              supported
                  ? strings.tr('notifications.smartSubtitle')
                  : strings.tr('notifications.unsupported'),
            ),
            value: batch.notificationsEnabled,
            onChanged: supported ? (value) => _toggle(context, value) : null,
          ),
          if (batch.notificationsEnabled) ...[
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.schedule_outlined),
              title: Text(strings.tr('notifications.time')),
              trailing: Text(
                time.format(context),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              onTap: () => _pickTime(context),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.fact_check_outlined),
              title: Text(strings.tr('notifications.dailyCheck')),
              subtitle: Text(strings.tr('notifications.dailyCheckSubtitle')),
              value: batch.dailyMashCheckEnabled,
              onChanged: (value) =>
                  onChanged(batch.copyWith(dailyMashCheckEnabled: value)),
            ),
          ],
        ],
      ),
    );
  }
}

class _AddReadingSheet extends StatefulWidget {
  final DateTime firstDate;

  const _AddReadingSheet({required this.firstDate});

  @override
  State<_AddReadingSheet> createState() => _AddReadingSheetState();
}

class _AddReadingSheetState extends State<_AddReadingSheet> {
  final _brixController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _recordedAt = DateTime.now();
  bool? _gasActivity;
  String? _errorKey;

  @override
  void dispose() {
    _brixController.dispose();
    _temperatureController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _recordedAt,
      firstDate: widget.firstDate,
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_recordedAt),
    );
    if (time == null) return;
    setState(() {
      _recordedAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _save() {
    final brix = parseLocalizedNumber(_brixController.text);
    final temperature = _temperatureController.text.trim().isEmpty
        ? null
        : parseLocalizedNumber(_temperatureController.text);
    if (brix == null || brix < -10 || brix > 40) {
      setState(() => _errorKey = 'journal.error.brix');
      return;
    }
    if (temperature != null && (temperature < 0 || temperature > 40)) {
      setState(() => _errorKey = 'journal.error.temperature');
      return;
    }
    if (_gasActivity == null) {
      setState(() => _errorKey = 'journal.error.gas');
      return;
    }
    final now = DateTime.now();
    if (_recordedAt.isBefore(widget.firstDate) ||
        _recordedAt.isAfter(now.add(const Duration(minutes: 5)))) {
      setState(() => _errorKey = 'journal.error.date');
      return;
    }
    Navigator.of(context).pop(
      BrixReading(
        recordedAt: _recordedAt,
        brix: brix,
        sampleTemperatureC: temperature,
        gasActivity: _gasActivity,
        note: _noteController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.tr('journal.addReading'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            InputField(
              controller: _brixController,
              label: strings.tr('journal.currentBrix'),
              unit: '°Bx',
              icon: Icons.water_drop_outlined,
              allowNegative: true,
            ),
            InputField(
              controller: _temperatureController,
              label: strings.tr('journal.sampleTemperature'),
              unit: '°C',
              icon: Icons.thermostat_outlined,
            ),
            OutlinedButton.icon(
              onPressed: _pickDateTime,
              icon: const Icon(Icons.schedule_outlined),
              label: Text(_dateTime(_recordedAt, languageCode)),
            ),
            const SizedBox(height: 12),
            Text(strings.tr('journal.gas.question')),
            const SizedBox(height: 6),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: true,
                  label: Text(strings.tr('yes')),
                  icon: const Icon(Icons.bubble_chart_outlined),
                ),
                ButtonSegment(
                  value: false,
                  label: Text(strings.tr('no')),
                  icon: const Icon(Icons.block_outlined),
                ),
              ],
              selected: _gasActivity == null ? {} : {_gasActivity!},
              emptySelectionAllowed: true,
              onSelectionChanged: (selection) => setState(
                () => _gasActivity = selection.isEmpty ? null : selection.first,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: strings.tr('journal.note'),
                prefixIcon: const Icon(Icons.notes_outlined),
                border: const OutlineInputBorder(),
              ),
            ),
            if (_errorKey != null) ...[
              const SizedBox(height: 10),
              Text(
                strings.tr(_errorKey!),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: _save,
                child: Text(strings.tr('save')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final FermentationStatus status;
  final AppLocalizations strings;

  const _StatusCard({required this.status, required this.strings});

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.secondaryContainer,
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatusIcon(status: status),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.tr(_statusKey(status)),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(strings.tr('${_statusKey(status)}.body')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _StatusIcon extends StatelessWidget {
  final FermentationStatus status;

  const _StatusIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    final icon = switch (status) {
      FermentationStatus.active => Icons.autorenew_rounded,
      FermentationStatus.checkSoon => Icons.schedule_rounded,
      FermentationStatus.stableTrend => Icons.monitor_heart_outlined,
      FermentationStatus.possiblyComplete => Icons.task_alt_rounded,
      FermentationStatus.stalled => Icons.warning_amber_rounded,
    };
    return Icon(icon, color: Theme.of(context).colorScheme.primary, size: 30);
  }
}

class _MeasurementNotice extends StatelessWidget {
  final BrixMeasurementMethod method;

  const _MeasurementNotice({required this.method});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline_rounded),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                strings.tr(
                  method == BrixMeasurementMethod.refractometer
                      ? 'journal.refractometerNotice'
                      : 'journal.hydrometerNotice',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

String _statusKey(FermentationStatus status) => 'journal.status.${status.name}';

String _number(double value) => value == value.roundToDouble()
    ? value.toStringAsFixed(0)
    : value.toStringAsFixed(1);

String _date(DateTime value, String languageCode) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return languageCode == 'en'
      ? '${value.year}-$month-$day'
      : '$day.$month.${value.year}';
}

String _dateTime(DateTime value, String languageCode) {
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '${_date(value, languageCode)} $hour:$minute';
}
