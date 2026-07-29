import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/calculation_history.dart';
import 'dilution_screen.dart';
import 'home_screen.dart';

enum CalculatorPage { correction, dilution }

class CalculationsScreen extends StatefulWidget {
  final ValueChanged<CalculationHistoryItem> onCalculated;

  const CalculationsScreen({super.key, required this.onCalculated});

  @override
  State<CalculationsScreen> createState() => _CalculationsScreenState();
}

class _CalculationsScreenState extends State<CalculationsScreen> {
  CalculatorPage selected = CalculatorPage.correction;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: SizedBox(
            width: double.infinity,
            child: SegmentedButton<CalculatorPage>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: CalculatorPage.correction,
                  icon: const Icon(Icons.thermostat_outlined),
                  label: Text(strings.tr('calculations.correction')),
                ),
                ButtonSegment(
                  value: CalculatorPage.dilution,
                  icon: const Icon(Icons.water_drop_outlined),
                  label: Text(strings.tr('calculations.dilution')),
                ),
              ],
              selected: {selected},
              onSelectionChanged: (value) =>
                  setState(() => selected = value.first),
            ),
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: selected.index,
            children: [
              HomeScreen(onCalculated: widget.onCalculated),
              DilutionScreen(onCalculated: widget.onCalculated),
            ],
          ),
        ),
      ],
    );
  }
}
