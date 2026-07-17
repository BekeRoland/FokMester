import 'package:flutter/widgets.dart';

enum AppLanguage { hu, en, ro }

extension AppLanguageData on AppLanguage {
  String get code => name;
  String get nativeName => switch (this) {
    AppLanguage.hu => 'Magyar',
    AppLanguage.en => 'English',
    AppLanguage.ro => 'Română',
  };
  Locale get locale => Locale(code);
}

class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static const supportedLocales = [Locale('hu'), Locale('en'), Locale('ro')];

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  String tr(String key) =>
      (_values[locale.languageCode] ?? _values['hu']!)[key] ??
      _values['hu']![key] ??
      key;

  static const delegate = _AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _values = {
    'hu': {
      'language': 'Nyelv',
      'theme': 'Téma',
      'system': 'Rendszer',
      'light': 'Világos',
      'dark': 'Sötét',
      'nav.temperature': 'Hőmérséklet',
      'nav.dilution': 'Hígítás',
      'nav.guide': 'Útmutató',
      'nav.history': 'Előzmény',
      'calculate': 'Számítás',
      'correction.title': 'Szeszfok-korrekció',
      'correction.range': 'Mérési tartomány: 10–98%, 5–30 °C',
      'correction.measured': 'Mért szeszfok',
      'correction.temperature': 'Hőmérséklet',
      'correction.result': '20 °C-ra korrigált szeszfok',
      'correction.semantics':
          '20 Celsius fokra korrigált szeszfok {value} százalék',
      'correction.info':
          'A köztes értékeket a korrekciós táblázatból interpolálja az alkalmazás.',
      'error.twoNumbers': 'Mindkét mezőben érvényes számot adjon meg.',
      'error.allNumbers': 'Minden mezőben érvényes számot adjon meg.',
      'error.measuredRange': 'A mért szeszfok 10% és 98% között lehet.',
      'error.temperatureRange': 'A hőmérséklet 5 °C és 30 °C között lehet.',
      'error.missingTableData':
          '96% felett 9 °C alatti méréshez nincs hiteles táblázati adat.',
      'error.positiveVolume': 'A térfogat legyen pozitív.',
      'error.lowerTarget': 'A célszeszfok legyen kisebb a jelenleginél.',
      'error.positiveFinalVolume': 'A végtérfogat legyen pozitív.',
      'error.lowerSourceTarget':
          'A célszeszfok legyen kisebb a forrás szeszfokánál.',
      'error.bothVolumes': 'Mindkét térfogat legyen pozitív.',
      'error.abv': 'A szeszfok 0-nál nagyobb és 100% között lehet.',
      'error.abvZero': 'A szeszfok 0 és 100% között lehet.',
      'dilution.title': 'Hígítás és keverés',
      'dilution.type': 'Számítás típusa',
      'mode.dilution': 'Meglevő párlat hígítása',
      'mode.finalVolume': 'Kívánt végtérfogat elkészítése',
      'mode.mixing': 'Két folyadék keverése',
      'field.currentAbv': 'Jelenlegi szeszfok (%)',
      'field.volume': 'Mennyiség',
      'field.targetAbv': 'Célszeszfok (%)',
      'field.sourceAbv': 'Forrás szeszfoka (%)',
      'field.finalVolume': 'Kívánt végtérfogat',
      'field.firstAbv': 'Első szeszfok (%)',
      'field.firstVolume': 'Első mennyiség',
      'field.secondAbv': 'Második szeszfok (%)',
      'field.secondVolume': 'Második mennyiség',
      'result.waterToAdd': 'Hozzáadandó víz',
      'result.finalVolume': 'Végtérfogat',
      'result.spiritNeeded': 'Szükséges párlat',
      'result.waterNeeded': 'Szükséges víz',
      'result.mixtureAbv': 'Keverék szeszfoka (%)',
      'dilution.info':
          'A térfogatok ideális összeadódásával számol; a valós keverési kontrakció miatt az eredmény közelítő.',
      'history.correction': 'Hőmérséklet-korrekció',
      'history.dilution': 'Hígítás',
      'history.finalVolume': 'Kívánt végtérfogat',
      'history.mixing': 'Két folyadék keverése',
      'history.title': 'Számítási előzmények',
      'history.clear': 'Előzmények törlése',
      'history.empty': 'Még nincs elmentett számítás.',
      'guide.title': 'Mérési útmutató',
      'guide.correct.title': 'Helyes mérés',
      'guide.correct.body':
          'A folyadék legyen homogén, buborékmentes, az alkoholmérő pedig szabadon lebegjen. A leolvasást szemmagasságban végezze.',
      'guide.range.title': 'Korrekciós tartomány',
      'guide.range.body':
          'A beépített táblázat 10–98% és 5–30 °C között használható. 96% felett 9 °C alatt nincs hiteles forrásadat.',
      'guide.unsuitable.title': 'Mire nem alkalmas?',
      'guide.unsuitable.body':
          'A hagyományos alkoholmérő és ez a korrekció cukros, likőr jellegű vagy sok oldott anyagot tartalmazó italnál nem ad megbízható eredményt.',
      'guide.dilution.title': 'Hígítás',
      'guide.dilution.body':
          'A vizet lassan, több lépésben adja hozzá, majd pihentesse és mérje vissza az italt. A számított térfogat közelítés, mert keveréskor térfogat-kontrakció léphet fel.',
    },
    'en': {
      'language': 'Language',
      'theme': 'Theme',
      'system': 'System',
      'light': 'Light',
      'dark': 'Dark',
      'nav.temperature': 'Temperature',
      'nav.dilution': 'Dilution',
      'nav.guide': 'Guide',
      'nav.history': 'History',
      'calculate': 'Calculate',
      'correction.title': 'Alcohol strength correction',
      'correction.range': 'Measurement range: 10–98%, 5–30 °C',
      'correction.measured': 'Measured alcohol strength',
      'correction.temperature': 'Temperature',
      'correction.result': 'Alcohol strength corrected to 20 °C',
      'correction.semantics':
          'Alcohol strength corrected to 20 degrees Celsius: {value} percent',
      'correction.info':
          'Intermediate values are interpolated from the correction table.',
      'error.twoNumbers': 'Enter a valid number in both fields.',
      'error.allNumbers': 'Enter a valid number in every field.',
      'error.measuredRange':
          'Measured alcohol strength must be between 10% and 98%.',
      'error.temperatureRange': 'Temperature must be between 5 °C and 30 °C.',
      'error.missingTableData':
          'There is no reliable table data above 96% and below 9 °C.',
      'error.positiveVolume': 'Volume must be positive.',
      'error.lowerTarget':
          'Target strength must be lower than the current strength.',
      'error.positiveFinalVolume': 'Final volume must be positive.',
      'error.lowerSourceTarget':
          'Target strength must be lower than the source strength.',
      'error.bothVolumes': 'Both volumes must be positive.',
      'error.abv': 'Alcohol strength must be greater than 0 and at most 100%.',
      'error.abvZero': 'Alcohol strength must be between 0 and 100%.',
      'dilution.title': 'Dilution and mixing',
      'dilution.type': 'Calculation type',
      'mode.dilution': 'Dilute an existing spirit',
      'mode.finalVolume': 'Prepare a desired final volume',
      'mode.mixing': 'Mix two liquids',
      'field.currentAbv': 'Current alcohol strength (%)',
      'field.volume': 'Volume',
      'field.targetAbv': 'Target alcohol strength (%)',
      'field.sourceAbv': 'Source alcohol strength (%)',
      'field.finalVolume': 'Desired final volume',
      'field.firstAbv': 'First alcohol strength (%)',
      'field.firstVolume': 'First volume',
      'field.secondAbv': 'Second alcohol strength (%)',
      'field.secondVolume': 'Second volume',
      'result.waterToAdd': 'Water to add',
      'result.finalVolume': 'Final volume',
      'result.spiritNeeded': 'Spirit required',
      'result.waterNeeded': 'Water required',
      'result.mixtureAbv': 'Mixture alcohol strength (%)',
      'dilution.info':
          'The calculation assumes ideal volume addition; actual volume contraction makes the result approximate.',
      'history.correction': 'Temperature correction',
      'history.dilution': 'Dilution',
      'history.finalVolume': 'Desired final volume',
      'history.mixing': 'Mixing two liquids',
      'history.title': 'Calculation history',
      'history.clear': 'Clear history',
      'history.empty': 'No saved calculations yet.',
      'guide.title': 'Measurement guide',
      'guide.correct.title': 'Correct measurement',
      'guide.correct.body':
          'The liquid should be homogeneous and free of bubbles, and the alcoholmeter should float freely. Read it at eye level.',
      'guide.range.title': 'Correction range',
      'guide.range.body':
          'The built-in table is valid from 10–98% and 5–30 °C. No reliable source data is available above 96% and below 9 °C.',
      'guide.unsuitable.title': 'When is it unsuitable?',
      'guide.unsuitable.body':
          'A traditional alcoholmeter and this correction are unreliable for sweetened, liqueur-like drinks or liquids containing many dissolved substances.',
      'guide.dilution.title': 'Dilution',
      'guide.dilution.body':
          'Add water slowly in several steps, let the drink rest, then measure it again. The calculated volume is approximate because mixing can cause volume contraction.',
    },
    'ro': {
      'language': 'Limbă',
      'theme': 'Temă',
      'system': 'Sistem',
      'light': 'Luminoasă',
      'dark': 'Întunecată',
      'nav.temperature': 'Temperatură',
      'nav.dilution': 'Diluare',
      'nav.guide': 'Ghid',
      'nav.history': 'Istoric',
      'calculate': 'Calculează',
      'correction.title': 'Corectarea concentrației alcoolice',
      'correction.range': 'Interval de măsurare: 10–98%, 5–30 °C',
      'correction.measured': 'Concentrație alcoolică măsurată',
      'correction.temperature': 'Temperatură',
      'correction.result': 'Concentrație corectată la 20 °C',
      'correction.semantics':
          'Concentrație alcoolică corectată la 20 de grade Celsius: {value} procente',
      'correction.info':
          'Valorile intermediare sunt interpolate din tabelul de corecție.',
      'error.twoNumbers': 'Introduceți un număr valid în ambele câmpuri.',
      'error.allNumbers': 'Introduceți un număr valid în fiecare câmp.',
      'error.measuredRange':
          'Concentrația măsurată trebuie să fie între 10% și 98%.',
      'error.temperatureRange':
          'Temperatura trebuie să fie între 5 °C și 30 °C.',
      'error.missingTableData':
          'Nu există date fiabile în tabel peste 96% și sub 9 °C.',
      'error.positiveVolume': 'Volumul trebuie să fie pozitiv.',
      'error.lowerTarget':
          'Concentrația țintă trebuie să fie mai mică decât cea actuală.',
      'error.positiveFinalVolume': 'Volumul final trebuie să fie pozitiv.',
      'error.lowerSourceTarget':
          'Concentrația țintă trebuie să fie mai mică decât cea a sursei.',
      'error.bothVolumes': 'Ambele volume trebuie să fie pozitive.',
      'error.abv':
          'Concentrația alcoolică trebuie să fie mai mare ca 0 și cel mult 100%.',
      'error.abvZero': 'Concentrația alcoolică trebuie să fie între 0 și 100%.',
      'dilution.title': 'Diluare și amestecare',
      'dilution.type': 'Tipul calculului',
      'mode.dilution': 'Diluează un distilat existent',
      'mode.finalVolume': 'Prepară un volum final dorit',
      'mode.mixing': 'Amestecă două lichide',
      'field.currentAbv': 'Concentrație actuală (%)',
      'field.volume': 'Volum',
      'field.targetAbv': 'Concentrație țintă (%)',
      'field.sourceAbv': 'Concentrația sursei (%)',
      'field.finalVolume': 'Volum final dorit',
      'field.firstAbv': 'Prima concentrație (%)',
      'field.firstVolume': 'Primul volum',
      'field.secondAbv': 'A doua concentrație (%)',
      'field.secondVolume': 'Al doilea volum',
      'result.waterToAdd': 'Apă de adăugat',
      'result.finalVolume': 'Volum final',
      'result.spiritNeeded': 'Distilat necesar',
      'result.waterNeeded': 'Apă necesară',
      'result.mixtureAbv': 'Concentrația amestecului (%)',
      'dilution.info':
          'Calculul presupune adunarea ideală a volumelor; contracția reală face ca rezultatul să fie aproximativ.',
      'history.correction': 'Corecție de temperatură',
      'history.dilution': 'Diluare',
      'history.finalVolume': 'Volum final dorit',
      'history.mixing': 'Amestecarea a două lichide',
      'history.title': 'Istoricul calculelor',
      'history.clear': 'Șterge istoricul',
      'history.empty': 'Nu există încă niciun calcul salvat.',
      'guide.title': 'Ghid de măsurare',
      'guide.correct.title': 'Măsurare corectă',
      'guide.correct.body':
          'Lichidul trebuie să fie omogen, fără bule, iar alcoolmetrul să plutească liber. Citiți valoarea la nivelul ochilor.',
      'guide.range.title': 'Interval de corecție',
      'guide.range.body':
          'Tabelul inclus este valabil între 10–98% și 5–30 °C. Peste 96% și sub 9 °C nu există date-sursă fiabile.',
      'guide.unsuitable.title': 'Când nu este potrivit?',
      'guide.unsuitable.body':
          'Un alcoolmetru tradițional și această corecție nu sunt fiabile pentru băuturi îndulcite, de tip lichior, sau lichide cu multe substanțe dizolvate.',
      'guide.dilution.title': 'Diluare',
      'guide.dilution.body':
          'Adăugați apa lent, în mai multe etape, lăsați băutura să se odihnească, apoi măsurați din nou. Volumul calculat este aproximativ, deoarece amestecarea poate produce contracție.',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.contains(Locale(locale.languageCode));

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
