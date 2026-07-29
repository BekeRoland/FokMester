import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/calculation_history.dart';
import 'guide_screen.dart';
import 'history_screen.dart';

class MoreScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  final AppLanguage language;
  final ValueChanged<AppLanguage> onLanguageChanged;
  final List<CalculationHistoryItem> history;
  final VoidCallback onClearHistory;

  const MoreScreen({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
    required this.language,
    required this.onLanguageChanged,
    required this.history,
    required this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          strings.tr('more.title'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        _NavigationCard(
          icon: Icons.menu_book_outlined,
          title: strings.tr('nav.guide'),
          subtitle: strings.tr('more.guideSubtitle'),
          onTap: () =>
              _open(context, strings.tr('nav.guide'), const GuideScreen()),
        ),
        _NavigationCard(
          icon: Icons.history_outlined,
          title: strings.tr('nav.history'),
          subtitle: strings.tr('more.historySubtitle'),
          onTap: () => _open(
            context,
            strings.tr('nav.history'),
            HistoryScreen(items: history, onClear: onClearHistory),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DropdownButtonFormField<AppLanguage>(
                  initialValue: language,
                  decoration: InputDecoration(
                    labelText: strings.tr('language'),
                    prefixIcon: const Icon(Icons.language_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  items: AppLanguage.values
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item.nativeName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) onLanguageChanged(value);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<ThemeMode>(
                  initialValue: themeMode,
                  decoration: InputDecoration(
                    labelText: strings.tr('theme'),
                    prefixIcon: const Icon(Icons.contrast_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(strings.tr('system')),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(strings.tr('light')),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(strings.tr('dark')),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) onThemeChanged(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _open(BuildContext context, String title, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: screen,
        ),
      ),
    );
  }
}

class _NavigationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _NavigationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      minTileHeight: 72,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      leading: Icon(icon, size: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    ),
  );
}
