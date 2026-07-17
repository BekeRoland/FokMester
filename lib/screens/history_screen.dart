import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../l10n/app_localizations.dart';

class HistoryScreen extends StatelessWidget {
  final List<CalculationHistoryItem> items;
  final VoidCallback onClear;

  const HistoryScreen({super.key, required this.items, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  strings.tr('history.title'),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              IconButton(
                onPressed: items.isEmpty ? null : onClear,
                tooltip: strings.tr('history.clear'),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? Center(child: Text(strings.tr('history.empty')))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    final time =
                        '${item.createdAt.hour.toString().padLeft(2, '0')}:${item.createdAt.minute.toString().padLeft(2, '0')}';
                    return Card(
                      child: ListTile(
                        title: Text(
                          _localizedHistoryTitle(strings, item.title),
                        ),
                        subtitle: Text('${item.details}\n$time'),
                        trailing: Text(item.result, textAlign: TextAlign.end),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _localizedHistoryTitle(AppLocalizations strings, String title) {
    const legacy = {
      'Hőmérséklet-korrekció': 'history.correction',
      'Hígítás': 'history.dilution',
      'Kívánt végtérfogat': 'history.finalVolume',
      'Két folyadék keverése': 'history.mixing',
    };
    return strings.tr(legacy[title] ?? title);
  }
}
