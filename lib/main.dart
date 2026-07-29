import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'screens/calculations_screen.dart';
import 'screens/distillation_screen.dart';
import 'screens/mash_screen.dart';
import 'screens/more_screen.dart';
import 'models/calculation_history.dart';
import 'models/mash_fruit_profile.dart';

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
  MashFruitProfile? _distillationFruit;
  double? _distillationMashKg;
  int _distillationRevision = 0;

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

  void _continueToDistillation(MashFruitProfile fruit, double mashKg) {
    setState(() {
      _distillationFruit = fruit;
      _distillationMashKg = mashKg;
      _distillationRevision++;
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        title: const Text('FokMester', style: TextStyle(fontSize: 18)),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          CalculationsScreen(onCalculated: _addHistory),
          MashScreen(
            onCalculated: _addHistory,
            onContinueToDistillation: _continueToDistillation,
          ),
          DistillationScreen(
            key: ValueKey(_distillationRevision),
            initialFruit: _distillationFruit,
            initialMashKg: _distillationMashKg,
          ),
          MoreScreen(
            themeMode: widget.themeMode,
            onThemeChanged: widget.onThemeChanged,
            language: widget.language,
            onLanguageChanged: widget.onLanguageChanged,
            history: _history,
            onClearHistory: _clearHistory,
          ),
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
              icon: Icon(Icons.calculate_outlined, color: Color(0xFF4A6580)),
              selectedIcon: Icon(
                Icons.calculate_rounded,
                color: Color(0xFF7EB8D4),
              ),
              label: strings.tr('nav.calculations'),
            ),
            NavigationDestination(
              icon: Icon(Icons.grass_outlined, color: Color(0xFF4A6580)),
              selectedIcon: Icon(Icons.grass_rounded, color: Color(0xFF7EB8D4)),
              label: strings.tr('nav.mash'),
            ),
            NavigationDestination(
              icon: Icon(Icons.local_fire_department_outlined),
              selectedIcon: Icon(Icons.local_fire_department_rounded),
              label: strings.tr('nav.distillation'),
            ),
            NavigationDestination(
              icon: Icon(Icons.more_horiz_rounded),
              selectedIcon: Icon(Icons.more_rounded),
              label: strings.tr('nav.more'),
            ),
          ],
        ),
      ),
    );
  }
}
