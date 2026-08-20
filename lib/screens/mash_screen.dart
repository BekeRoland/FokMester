import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/calculation_history.dart';
import '../models/mash_batch.dart';
import '../models/mash_fruit_profile.dart';
import '../services/fermentation_service.dart';
import '../services/mash_calculator.dart';
import '../services/notification_service.dart';
import '../utils/number_parser.dart';
import '../widgets/input_field.dart';
import 'mash_journal_screen.dart';

class MashScreen extends StatefulWidget {
  final ValueChanged<CalculationHistoryItem> onCalculated;
  final void Function(MashFruitProfile fruit, double mashKg)?
  onContinueToDistillation;
  final List<MashBatch> batches;
  final ValueChanged<MashBatch> onBatchSaved;
  final ValueChanged<MashBatch> onBatchUpdated;

  const MashScreen({
    super.key,
    required this.onCalculated,
    required this.batches,
    required this.onBatchSaved,
    required this.onBatchUpdated,
    this.onContinueToDistillation,
  });

  @override
  State<MashScreen> createState() => _MashScreenState();
}

class _MashScreenState extends State<MashScreen> {
  MashFruitProfile selectedFruit = mashFruitProfiles.first;
  final mashAmountController = TextEditingController();
  final yeastDoseController = TextEditingController(text: '20');
  final brixController = TextEditingController();
  final yeastNameController = TextEditingController();
  final fermentationTemperatureController = TextEditingController(text: '18');
  DateTime startedAt = DateTime.now();
  BrixMeasurementMethod measurementMethod = BrixMeasurementMethod.hydrometer;
  bool notificationsEnabled = false;
  bool dailyMashCheckEnabled = false;
  TimeOfDay reminderTime = const TimeOfDay(hour: 19, minute: 0);
  MashCalculationResult? result;
  FermentationEstimate? fermentationEstimate;
  bool savedCurrentPlan = false;
  String? errorKey;

  @override
  void initState() {
    super.initState();
    for (final controller in [
      mashAmountController,
      yeastDoseController,
      brixController,
      yeastNameController,
      fermentationTemperatureController,
    ]) {
      controller.addListener(_invalidateSavedPlan);
    }
  }

  void _invalidateSavedPlan() {
    if (!mounted ||
        (result == null &&
            fermentationEstimate == null &&
            !savedCurrentPlan &&
            errorKey == null)) {
      return;
    }
    setState(() {
      result = null;
      fermentationEstimate = null;
      savedCurrentPlan = false;
      errorKey = null;
    });
  }

  @override
  void dispose() {
    mashAmountController.dispose();
    yeastDoseController.dispose();
    brixController.dispose();
    yeastNameController.dispose();
    fermentationTemperatureController.dispose();
    super.dispose();
  }

  void _calculate() {
    FocusManager.instance.primaryFocus?.unfocus();
    final amount = parseLocalizedNumber(mashAmountController.text);
    final yeastDose = parseLocalizedNumber(yeastDoseController.text);
    final brix = parseLocalizedNumber(brixController.text);
    final temperature = parseLocalizedNumber(
      fermentationTemperatureController.text,
    );
    if (amount == null ||
        yeastDose == null ||
        brix == null ||
        temperature == null) {
      setState(() {
        result = null;
        errorKey = 'error.allNumbers';
      });
      return;
    }
    if (temperature < 5 || temperature > 35) {
      setState(() {
        result = null;
        fermentationEstimate = null;
        errorKey = 'mash.error.fermentationTemperature';
      });
      return;
    }
    if (startedAt.isAfter(DateTime.now().add(const Duration(minutes: 5)))) {
      setState(() {
        result = null;
        fermentationEstimate = null;
        errorKey = 'mash.error.startDate';
      });
      return;
    }

    try {
      final calculated = MashCalculator.calculate(
        fruit: selectedFruit,
        mashKg: amount,
        yeastDoseGramsPer100Kg: yeastDose,
        brix: brix,
      );
      final languageCode = Localizations.localeOf(context).languageCode;
      final estimate = FermentationService.estimate(
        fruitId: selectedFruit.id,
        initialBrix: brix,
        temperatureC: temperature,
      );
      setState(() {
        result = calculated;
        fermentationEstimate = estimate;
        savedCurrentPlan = false;
        errorKey = null;
      });
      widget.onCalculated(
        CalculationHistoryItem(
          createdAt: DateTime.now(),
          title: 'history.mash',
          details:
              '${selectedFruit.name(languageCode)}, ${_number(amount)} kg, ${_number(brix)} °Bx',
          result:
              '${calculated.potentialAbvMin.toStringAsFixed(1)}–${calculated.potentialAbvMax.toStringAsFixed(1)}%',
        ),
      );
    } on MashCalculatorException catch (error) {
      setState(() {
        result = null;
        fermentationEstimate = null;
        errorKey = error.code;
      });
    }
  }

  Future<void> _pickStartDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: startedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(startedAt),
    );
    if (time == null) return;
    setState(() {
      startedAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      result = null;
      fermentationEstimate = null;
      savedCurrentPlan = false;
    });
  }

  Future<void> _setNotificationsEnabled(bool enabled) async {
    if (enabled) {
      final granted = await NotificationService.instance.requestPermission();
      if (!mounted) return;
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
    setState(() {
      notificationsEnabled = enabled;
      if (!enabled) dailyMashCheckEnabled = false;
      savedCurrentPlan = false;
    });
  }

  Future<void> _pickReminderTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: reminderTime,
    );
    if (selected == null) return;
    setState(() {
      reminderTime = selected;
      savedCurrentPlan = false;
    });
  }

  void _saveToJournal() {
    final calculated = result;
    final estimate = fermentationEstimate;
    final amount = parseLocalizedNumber(mashAmountController.text);
    final yeastDose = parseLocalizedNumber(yeastDoseController.text);
    final brix = parseLocalizedNumber(brixController.text);
    final temperature = parseLocalizedNumber(
      fermentationTemperatureController.text,
    );
    if (calculated == null ||
        estimate == null ||
        amount == null ||
        yeastDose == null ||
        brix == null ||
        temperature == null) {
      return;
    }
    final batch = MashBatch(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      fruitId: selectedFruit.id,
      mashKg: amount,
      startedAt: startedAt,
      yeastName: yeastNameController.text.trim(),
      yeastDoseGramsPer100Kg: yeastDose,
      yeastGrams: calculated.yeastGrams,
      enzymeMinMl: calculated.enzymeMinMl,
      enzymeMaxMl: calculated.enzymeMaxMl,
      nutrientMinGrams: calculated.nutrientMinGrams,
      nutrientMaxGrams: calculated.nutrientMaxGrams,
      initialBrix: brix,
      potentialAbvMin: calculated.potentialAbvMin,
      potentialAbvMax: calculated.potentialAbvMax,
      fermentationTemperatureC: temperature,
      measurementMethod: measurementMethod,
      estimatedMinDays: estimate.minDays,
      estimatedMaxDays: estimate.maxDays,
      notificationsEnabled: notificationsEnabled,
      reminderHour: reminderTime.hour,
      reminderMinute: reminderTime.minute,
      dailyMashCheckEnabled: dailyMashCheckEnabled,
      readings: [BrixReading(recordedAt: startedAt, brix: brix)],
    );
    widget.onBatchSaved(batch);
    setState(() => savedCurrentPlan = true);
    final strings = AppLocalizations.of(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(strings.tr('journal.saved'))));
  }

  void _openJournal() {
    final strings = AppLocalizations.of(context);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(strings.tr('journal.title'))),
          body: MashJournalScreen(
            batches: widget.batches,
            onBatchUpdated: widget.onBatchUpdated,
          ),
        ),
      ),
    );
  }

  String _number(double value, {int decimals = 1}) {
    if (value == value.roundToDouble()) return value.toStringAsFixed(0);
    return value.toStringAsFixed(decimals);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final brix = parseLocalizedNumber(brixController.text);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(strings.tr('mash.title'), style: theme.textTheme.headlineMedium),
        const SizedBox(height: 6),
        Text(strings.tr('mash.subtitle')),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            minTileHeight: 72,
            leading: const Icon(Icons.menu_book_outlined, size: 30),
            title: Text(
              strings.tr('journal.title'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              strings
                  .tr('journal.batchCount')
                  .replaceAll('{count}', widget.batches.length.toString()),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: _openJournal,
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<MashFruitProfile>(
                  initialValue: selectedFruit,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: strings.tr('mash.fruit'),
                    prefixIcon: const Icon(Icons.eco_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  items: mashFruitProfiles
                      .map(
                        (fruit) => DropdownMenuItem(
                          value: fruit,
                          child: Text(fruit.name(languageCode)),
                        ),
                      )
                      .toList(),
                  onChanged: (fruit) {
                    if (fruit == null) return;
                    setState(() {
                      selectedFruit = fruit;
                      result = null;
                      fermentationEstimate = null;
                      savedCurrentPlan = false;
                      errorKey = null;
                    });
                  },
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: mashAmountController,
                  label: strings.tr('mash.amount'),
                  unit: 'kg',
                  icon: Icons.scale_outlined,
                ),
                InputField(
                  controller: yeastDoseController,
                  label: strings.tr('mash.yeastDose'),
                  unit: 'g/100 kg',
                  icon: Icons.science_outlined,
                ),
                InputField(
                  controller: brixController,
                  label: strings.tr('mash.brix'),
                  unit: '°Bx',
                  icon: Icons.water_drop_outlined,
                ),
                TextField(
                  controller: yeastNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: strings.tr('mash.yeastName'),
                    prefixIcon: const Icon(Icons.inventory_2_outlined),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: fermentationTemperatureController,
                  label: strings.tr('mash.fermentationTemperature'),
                  unit: '°C',
                  icon: Icons.thermostat_outlined,
                ),
                DropdownButtonFormField<BrixMeasurementMethod>(
                  initialValue: measurementMethod,
                  decoration: InputDecoration(
                    labelText: strings.tr('journal.method'),
                    prefixIcon: const Icon(Icons.straighten_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  items: BrixMeasurementMethod.values
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: Text(
                            strings.tr('journal.method.${method.name}'),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (method) {
                    if (method == null) return;
                    setState(() {
                      measurementMethod = method;
                      result = null;
                      fermentationEstimate = null;
                      savedCurrentPlan = false;
                    });
                  },
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _pickStartDateTime,
                  icon: const Icon(Icons.event_outlined),
                  label: Text(
                    '${strings.tr('mash.startedAt')}: ${_dateTime(startedAt, languageCode)}',
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SwitchListTile(
                        secondary: const Icon(
                          Icons.notifications_active_outlined,
                        ),
                        title: Text(strings.tr('notifications.smart')),
                        subtitle: Text(
                          NotificationService.instance.isSupported
                              ? strings.tr('notifications.smartSubtitle')
                              : strings.tr('notifications.unsupported'),
                        ),
                        value: notificationsEnabled,
                        onChanged: NotificationService.instance.isSupported
                            ? _setNotificationsEnabled
                            : null,
                      ),
                      if (notificationsEnabled) ...[
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.schedule_outlined),
                          title: Text(strings.tr('notifications.time')),
                          trailing: Text(
                            reminderTime.format(context),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: _pickReminderTime,
                        ),
                        SwitchListTile(
                          secondary: const Icon(Icons.fact_check_outlined),
                          title: Text(strings.tr('notifications.dailyCheck')),
                          subtitle: Text(
                            strings.tr('notifications.dailyCheckSubtitle'),
                          ),
                          value: dailyMashCheckEnabled,
                          onChanged: (value) => setState(() {
                            dailyMashCheckEnabled = value;
                            savedCurrentPlan = false;
                          }),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (errorKey != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Semantics(
                      liveRegion: true,
                      child: Text(
                        strings.tr(errorKey!),
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: _calculate,
                    icon: const Icon(Icons.calculate_outlined),
                    label: Text(strings.tr('calculate')),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (result != null) ...[
          const SizedBox(height: 16),
          _ResultCard(
            result: result!,
            estimate: fermentationEstimate!,
            highBrix: (brix ?? 0) >= 24,
            strings: strings,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: savedCurrentPlan ? null : _saveToJournal,
              icon: Icon(
                savedCurrentPlan
                    ? Icons.bookmark_added_rounded
                    : Icons.bookmark_add_outlined,
              ),
              label: Text(
                strings.tr(
                  savedCurrentPlan
                      ? 'journal.savedButton'
                      : 'journal.saveBatch',
                ),
              ),
            ),
          ),
          if (widget.onContinueToDistillation != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 54,
              child: FilledButton.tonalIcon(
                onPressed: () => widget.onContinueToDistillation!(
                  selectedFruit,
                  parseLocalizedNumber(mashAmountController.text)!,
                ),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(strings.tr('mash.continueDistillation')),
              ),
            ),
          ],
        ],
        const SizedBox(height: 16),
        _GuidanceCard(
          title: selectedFruit.name(languageCode),
          category: selectedFruit.category,
          note: selectedFruit.note(languageCode),
          strings: strings,
        ),
        const SizedBox(height: 12),
        _CommonProcessCard(strings: strings),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  final MashCalculationResult result;
  final FermentationEstimate estimate;
  final bool highBrix;
  final AppLocalizations strings;

  const _ResultCard({
    required this.result,
    required this.estimate,
    required this.highBrix,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      liveRegion: true,
      child: Card(
        color: theme.colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                strings.tr('mash.result.title'),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _ResultLine(
                label: strings.tr('mash.result.yeast'),
                value: '${_format(result.yeastGrams)} g',
              ),
              _ResultLine(
                label: strings.tr('mash.result.enzyme'),
                value:
                    '${_format(result.enzymeMinMl)}–${_format(result.enzymeMaxMl)} ml',
              ),
              _ResultLine(
                label: strings.tr('mash.result.nutrient'),
                value:
                    '${_format(result.nutrientMinGrams)}–${_format(result.nutrientMaxGrams)} g',
              ),
              _ResultLine(
                label: strings.tr('mash.result.abv'),
                value:
                    '${result.potentialAbvMin.toStringAsFixed(1)}–${result.potentialAbvMax.toStringAsFixed(1)} %',
              ),
              _ResultLine(
                label: strings.tr('mash.result.fermentationWindow'),
                value:
                    '${estimate.minDays}–${estimate.maxDays} ${strings.tr('days')}',
              ),
              const Divider(height: 28),
              _Notice(
                icon: Icons.science_outlined,
                text: strings.tr('mash.result.enzymeNote'),
              ),
              const SizedBox(height: 8),
              _Notice(
                icon: Icons.grain_outlined,
                text: strings.tr('mash.result.nutrientNote'),
              ),
              const SizedBox(height: 8),
              _Notice(
                icon: Icons.analytics_outlined,
                text: strings.tr('mash.result.abvNote'),
              ),
              const SizedBox(height: 8),
              _Notice(
                icon: Icons.schedule_outlined,
                text: strings.tr('mash.result.fermentationNote'),
              ),
              if (highBrix) ...[
                const SizedBox(height: 8),
                _Notice(
                  icon: Icons.warning_amber_rounded,
                  text: strings.tr('mash.warning.highBrix'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static String _format(double value) =>
      value >= 100 ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
}

String _dateTime(DateTime value, String languageCode) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  final date = languageCode == 'en'
      ? '${value.year}-$month-$day'
      : '$day.$month.${value.year}';
  return '$date $hour:$minute';
}

class _ResultLine extends StatelessWidget {
  final String label;
  final String value;

  const _ResultLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 12),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

class _Notice extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Notice({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18),
      const SizedBox(width: 8),
      Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
    ],
  );
}

class _GuidanceCard extends StatelessWidget {
  final String title;
  final MashFruitCategory category;
  final String note;
  final AppLocalizations strings;

  const _GuidanceCard({
    required this.title,
    required this.category,
    required this.note,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final categoryKey = switch (category) {
      MashFruitCategory.pome => 'mash.category.pome',
      MashFruitCategory.stone => 'mash.category.stone',
      MashFruitCategory.soft => 'mash.category.soft',
    };
    final preparationKey = switch (category) {
      MashFruitCategory.pome => 'mash.preparation.pome',
      MashFruitCategory.stone => 'mash.preparation.stone',
      MashFruitCategory.soft => 'mash.preparation.soft',
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(strings.tr(categoryKey)),
            const SizedBox(height: 16),
            Text(
              strings.tr('mash.guidance.preparation'),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(strings.tr(preparationKey)),
            const SizedBox(height: 12),
            Text(
              strings.tr('mash.guidance.specific'),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(note),
          ],
        ),
      ),
    );
  }
}

class _CommonProcessCard extends StatelessWidget {
  final AppLocalizations strings;

  const _CommonProcessCard({required this.strings});

  @override
  Widget build(BuildContext context) => Card(
    child: ExpansionTile(
      leading: const Icon(Icons.fact_check_outlined),
      title: Text(strings.tr('mash.process.title')),
      childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        for (final key in const [
          'mash.process.quality',
          'mash.process.ph',
          'mash.process.fermentation',
          'mash.process.cap',
          'mash.process.finish',
          'mash.process.co2',
          'mash.process.legal',
        ])
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Icon(Icons.circle, size: 6),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(strings.tr(key))),
              ],
            ),
          ),
      ],
    ),
  );
}
