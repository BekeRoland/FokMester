import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../l10n/app_localizations.dart';
import '../services/alcohol_calculator.dart';
import '../utils/number_parser.dart';
import '../widgets/input_field.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<CalculationHistoryItem> onCalculated;

  const HomeScreen({super.key, required this.onCalculated});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final measuredController = TextEditingController();
  final tempController = TextEditingController();
  double? result;
  String? errorKey;

  @override
  void dispose() {
    measuredController.dispose();
    tempController.dispose();
    super.dispose();
  }

  void calculate() {
    FocusManager.instance.primaryFocus?.unfocus();
    final measured = parseLocalizedNumber(measuredController.text);
    final temp = parseLocalizedNumber(tempController.text);
    if (measured == null || temp == null) {
      setState(() {
        result = null;
        errorKey = 'error.twoNumbers';
      });
      return;
    }
    try {
      final corrected = AlcoholCalculator.correctAlcohol(measured, temp);
      setState(() {
        result = corrected;
        errorKey = null;
      });
      widget.onCalculated(
        CalculationHistoryItem(
          createdAt: DateTime.now(),
          title: 'history.correction',
          details: '${_n(measured)}% @ ${_n(temp)} °C',
          result: '${corrected.toStringAsFixed(2)}%',
        ),
      );
    } on CalculatorException catch (error) {
      setState(() {
        result = null;
        errorKey = error.code;
      });
    }
  }

  String _n(double value) => value.toStringAsFixed(value % 1 == 0 ? 0 : 2);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          strings.tr('correction.title'),
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 6),
        Text(strings.tr('correction.range')),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                InputField(
                  controller: measuredController,
                  label: strings.tr('correction.measured'),
                  unit: '%',
                  icon: Icons.opacity_rounded,
                ),
                InputField(
                  controller: tempController,
                  label: strings.tr('correction.temperature'),
                  unit: '°C',
                  icon: Icons.thermostat_rounded,
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
        if (result != null) ...[
          const SizedBox(height: 16),
          Semantics(
            liveRegion: true,
            label: strings
                .tr('correction.semantics')
                .replaceAll('{value}', result!.toStringAsFixed(2)),
            child: Card(
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, size: 36),
                    const SizedBox(height: 12),
                    Text(
                      strings.tr('correction.result'),
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      child: Text(
                        '${result!.toStringAsFixed(2)} %',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline_rounded, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(strings.tr('correction.info'))),
          ],
        ),
      ],
    );
  }
}
