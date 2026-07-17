import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../l10n/app_localizations.dart';
import '../services/alcohol_calculator.dart';
import '../utils/number_parser.dart';
import '../widgets/input_field.dart';

enum CalculationMode { dilution, finalVolume, mixing }

enum VolumeUnit { liter, deciliter, milliliter }

extension on VolumeUnit {
  String get label => switch (this) {
    VolumeUnit.liter => 'L',
    VolumeUnit.deciliter => 'dl',
    VolumeUnit.milliliter => 'ml',
  };
  double get liters => switch (this) {
    VolumeUnit.liter => 1,
    VolumeUnit.deciliter => .1,
    VolumeUnit.milliliter => .001,
  };
}

class DilutionScreen extends StatefulWidget {
  final ValueChanged<CalculationHistoryItem> onCalculated;
  const DilutionScreen({super.key, required this.onCalculated});

  @override
  State<DilutionScreen> createState() => _DilutionScreenState();
}

class _DilutionScreenState extends State<DilutionScreen> {
  final controllers = List.generate(4, (_) => TextEditingController());
  CalculationMode mode = CalculationMode.dilution;
  VolumeUnit unit = VolumeUnit.liter;
  String? errorKey;
  List<(String, double, bool)> results = [];

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<String> get labelKeys => switch (mode) {
    CalculationMode.dilution => [
      'field.currentAbv',
      'field.volume',
      'field.targetAbv',
    ],
    CalculationMode.finalVolume => [
      'field.sourceAbv',
      'field.finalVolume',
      'field.targetAbv',
    ],
    CalculationMode.mixing => [
      'field.firstAbv',
      'field.firstVolume',
      'field.secondAbv',
      'field.secondVolume',
    ],
  };

  void calculate() {
    final values = labelKeys
        .asMap()
        .entries
        .map((entry) => parseLocalizedNumber(controllers[entry.key].text))
        .toList();
    if (values.any((value) => value == null)) {
      setState(() {
        errorKey = 'error.allNumbers';
        results = [];
      });
      return;
    }
    final v = values.cast<double>();
    try {
      late String title;
      late String details;
      if (mode == CalculationMode.dilution) {
        final r = AlcoholCalculator.calculateDilution(
          currentAbv: v[0],
          volumeLiters: v[1] * unit.liters,
          targetAbv: v[2],
        );
        results = [
          ('result.waterToAdd', r.waterLiters, false),
          ('result.finalVolume', r.finalVolume, false),
        ];
        title = 'history.dilution';
        details = '${v[0]}% → ${v[2]}%';
      } else if (mode == CalculationMode.finalVolume) {
        final r = AlcoholCalculator.calculateForFinalVolume(
          sourceAbv: v[0],
          finalVolumeLiters: v[1] * unit.liters,
          targetAbv: v[2],
        );
        results = [
          ('result.spiritNeeded', r.spiritLiters, false),
          ('result.waterNeeded', r.waterLiters, false),
        ];
        title = 'history.finalVolume';
        details = '${v[1]} ${unit.label}, ${v[2]}%';
      } else {
        final r = AlcoholCalculator.mix(
          firstAbv: v[0],
          firstVolumeLiters: v[1] * unit.liters,
          secondAbv: v[2],
          secondVolumeLiters: v[3] * unit.liters,
        );
        results = [
          ('result.mixtureAbv', r.finalAbv, true),
          ('result.finalVolume', r.finalVolume, false),
        ];
        title = 'history.mixing';
        details = '${v[0]}% + ${v[2]}%';
      }
      setState(() => errorKey = null);
      widget.onCalculated(
        CalculationHistoryItem(
          createdAt: DateTime.now(),
          title: title,
          details: details,
          result: _formatResult(results.first),
        ),
      );
    } on CalculatorException catch (e) {
      setState(() {
        errorKey = e.code;
        results = [];
      });
    }
  }

  String _formatResult((String, double, bool) item) =>
      item.$3 ? '${item.$2.toStringAsFixed(2)}%' : _volume(item.$2);
  String _volume(double liters) =>
      '${(liters / unit.liters).toStringAsFixed(unit == VolumeUnit.liter ? 3 : 1)} ${unit.label}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          strings.tr('dilution.title'),
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<CalculationMode>(
          initialValue: mode,
          decoration: InputDecoration(
            labelText: strings.tr('dilution.type'),
            border: const OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(
              value: CalculationMode.dilution,
              child: Text(strings.tr('mode.dilution')),
            ),
            DropdownMenuItem(
              value: CalculationMode.finalVolume,
              child: Text(strings.tr('mode.finalVolume')),
            ),
            DropdownMenuItem(
              value: CalculationMode.mixing,
              child: Text(strings.tr('mode.mixing')),
            ),
          ],
          onChanged: (value) => setState(() {
            mode = value!;
            errorKey = null;
            results = [];
          }),
        ),
        const SizedBox(height: 12),
        SegmentedButton<VolumeUnit>(
          segments: VolumeUnit.values
              .map((u) => ButtonSegment(value: u, label: Text(u.label)))
              .toList(),
          selected: {unit},
          onSelectionChanged: (value) => setState(() {
            unit = value.first;
            results = [];
          }),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                for (var i = 0; i < labelKeys.length; i++)
                  InputField(
                    controller: controllers[i],
                    label: strings.tr(labelKeys[i]),
                    unit: _isVolumeField(i) ? unit.label : null,
                  ),
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
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: calculate,
                    child: Text(strings.tr('calculate')),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (results.isNotEmpty) ...[
          const SizedBox(height: 16),
          Card(
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  for (final item in results)
                    ListTile(
                      title: Text(strings.tr(item.$1)),
                      trailing: Text(
                        _formatResult(item),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(strings.tr('dilution.info'))),
          ],
        ),
      ],
    );
  }

  bool _isVolumeField(int index) => switch (mode) {
    CalculationMode.dilution || CalculationMode.finalVolume => index == 1,
    CalculationMode.mixing => index == 1 || index == 3,
  };
}
