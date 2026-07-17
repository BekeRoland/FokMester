import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    const sections = [
      ('guide.correct.title', 'guide.correct.body'),
      ('guide.range.title', 'guide.range.body'),
      ('guide.unsuitable.title', 'guide.unsuitable.body'),
      ('guide.dilution.title', 'guide.dilution.body'),
    ];
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          strings.tr('guide.title'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        for (final section in sections)
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                strings.tr(section.$1),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(strings.tr(section.$2)),
              ),
            ),
          ),
      ],
    );
  }
}
