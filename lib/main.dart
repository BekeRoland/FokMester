import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/dilution_screen.dart';
import 'screens/guide_screen.dart';
import 'screens/history_screen.dart';
import 'models/calculation_history.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PalinkaApp());
}

class PalinkaApp extends StatefulWidget {
  const PalinkaApp({super.key});

  @override
  State<PalinkaApp> createState() => _PalinkaAppState();
}

class _PalinkaAppState extends State<PalinkaApp> {
  static const _languageKey = 'app_language';
  ThemeMode _themeMode = ThemeMode.system;
  AppLanguage _language = AppLanguage.hu;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final preferences = await SharedPreferences.getInstance();
    final code = preferences.getString(_languageKey);
    final language = AppLanguage.values.where((item) => item.code == code);
    if (!mounted || language.isEmpty) return;
    setState(() => _language = language.first);
  }

  Future<void> _changeLanguage(AppLanguage language) async {
    setState(() => _language = language);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageKey, language.code);
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5B9EC9);
    return MaterialApp(
      title: 'FokMester',
      debugShowCheckedModeBanner: false,
      locale: _language.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B9EC9),
          brightness: Brightness.dark,
          primary: const Color(0xFF7EB8D4),
          secondary: const Color(0xFFA8C4D4),
          surface: const Color(0xFF111827),
          onSurface: const Color(0xFFE8EEF4),
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0F1A),
        fontFamily: 'Roboto',
      ),
      home: NavigationShell(
        themeMode: _themeMode,
        onThemeChanged: (mode) => setState(() => _themeMode = mode),
        language: _language,
        onLanguageChanged: _changeLanguage,
      ),
    );
  }
}

class NavigationShell extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  final AppLanguage language;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const NavigationShell({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
    required this.language,
    required this.onLanguageChanged,
  });

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  static const _historyKey = 'calculation_history_v1';
  int _selectedIndex = 0;
  final List<CalculationHistoryItem> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final stored = preferences.getStringList(_historyKey) ?? const [];
      final loaded = stored
          .map(
            (item) => CalculationHistoryItem.fromJson(
              jsonDecode(item) as Map<String, dynamic>,
            ),
          )
          .toList();
      if (!mounted) return;
      setState(() => _history.addAll(loaded));
    } on Object {
      // A hibás vagy régi helyi előzmény nem akadályozhatja az app indulását.
    }
  }

  Future<void> _saveHistory() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(
      _historyKey,
      _history.map((item) => jsonEncode(item.toJson())).toList(),
    );
  }

  void _addHistory(CalculationHistoryItem item) {
    setState(() {
      _history.insert(0, item);
      if (_history.length > 50) _history.removeLast();
    });
    _saveHistory();
  }

  void _clearHistory() {
    setState(_history.clear);
    _saveHistory();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        title: const Text('FokMester', style: TextStyle(fontSize: 18)),
        actions: [
          PopupMenuButton<AppLanguage>(
            tooltip: strings.tr('language'),
            icon: const Icon(Icons.language_rounded),
            initialValue: widget.language,
            onSelected: widget.onLanguageChanged,
            itemBuilder: (_) => AppLanguage.values
                .map(
                  (language) => PopupMenuItem(
                    value: language,
                    child: Text(language.nativeName),
                  ),
                )
                .toList(),
          ),
          PopupMenuButton<ThemeMode>(
            tooltip: strings.tr('theme'),
            icon: const Icon(Icons.brightness_6_outlined),
            initialValue: widget.themeMode,
            onSelected: widget.onThemeChanged,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: ThemeMode.system,
                child: Text(strings.tr('system')),
              ),
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text(strings.tr('light')),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text(strings.tr('dark')),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(onCalculated: _addHistory),
          DilutionScreen(onCalculated: _addHistory),
          const GuideScreen(),
          HistoryScreen(items: _history, onClear: _clearHistory),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFF1E2A3A), width: 1)),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) =>
              setState(() => _selectedIndex = index),
          backgroundColor: const Color(0xFF0D1420),
          indicatorColor: const Color(0xFF5B9EC9).withValues(alpha: 0.22),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.thermostat_outlined, color: Color(0xFF4A6580)),
              selectedIcon: Icon(
                Icons.thermostat_rounded,
                color: Color(0xFF7EB8D4),
              ),
              label: strings.tr('nav.temperature'),
            ),
            NavigationDestination(
              icon: Icon(Icons.water_drop_outlined, color: Color(0xFF4A6580)),
              selectedIcon: Icon(
                Icons.water_drop_rounded,
                color: Color(0xFF7EB8D4),
              ),
              label: strings.tr('nav.dilution'),
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book_rounded),
              label: strings.tr('nav.guide'),
            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              selectedIcon: Icon(Icons.history_rounded),
              label: strings.tr('nav.history'),
            ),
          ],
        ),
      ),
    );
  }
}
