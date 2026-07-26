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
      'nav.mash': 'Cefre',
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
      'history.mash': 'Cefretervezés',
      'history.title': 'Számítási előzmények',
      'history.clear': 'Előzmények törlése',
      'history.empty': 'Még nincs elmentett számítás.',
      'mash.title': 'Cefretervező',
      'mash.subtitle':
          'Gyümölcsspecifikus alapanyag-, segédanyag- és alkoholtartalom-becslés.',
      'mash.fruit': 'Gyümölcs fajtája',
      'mash.amount': 'Cefre tömege',
      'mash.yeastDose': 'Élesztő címke szerinti adagja',
      'mash.brix': 'Gyümölcs mért Brix-foka',
      'mash.error.amount': 'A cefre tömege 0 és 100 000 kg között lehet.',
      'mash.error.yeastDose':
          'Az élesztő adagja 0 és 500 g/100 kg között lehet.',
      'mash.error.brix': 'A Brix-érték 0 és 40 °Bx között lehet.',
      'mash.result.title': 'Tervezett mennyiségek',
      'mash.result.yeast': 'Szükséges élesztő',
      'mash.result.enzyme': 'Pektinbontó enzim',
      'mash.result.nutrient': 'Komplex élesztőtáp',
      'mash.result.abv': 'Várható potenciális alkohol',
      'mash.result.enzymeNote':
          'Az enzimérték a Distizym FM-Top koncentrált folyékony, lepárlási enzim 15 °C-on megadott gyártói tartománya. Más terméknél mindig annak címkéje az irányadó; csak alacsony pektinészteráz-tartalmú, gyümölcspárlathoz ajánlott készítményt használjon.',
      'mash.result.nutrientNote':
          'A 25–40 g/100 kg tápanyagtartomány a Vitamon Combi hűvös gyümölcscefrés erjesztésre közölt referenciaértéke. Más összetételű tápnál a gyártói adagolás és időzítés az irányadó; pontos nitrogénigényhez YAN-mérés szükséges.',
      'mash.result.abvNote':
          'A Brix oldott szárazanyagot mér, nem kizárólag erjeszthető cukrot. A 0,52–0,61 × °Bx tartomány tervezési becslés; a tényleges eredményt a gyümölcs, az élesztő, a maradékcukor és a hőmérséklet módosítja.',
      'mash.warning.highBrix':
          'Magas Brix: ellenőrizze az élesztő alkoholtűrését. Elakadt erjedésnél ne adjon automatikusan több tápot, hanem mérjen Brixet, hőmérsékletet és pH-t.',
      'mash.category.pome': 'Almatermésű vagy kemény húsú gyümölcs',
      'mash.category.stone': 'Csonthéjas gyümölcs',
      'mash.category.soft': 'Bogyós vagy lágy húsú gyümölcs',
      'mash.guidance.preparation': 'Kategória szerinti előkészítés',
      'mash.guidance.specific': 'Erre a gyümölcsre figyeljen',
      'mash.preparation.pome':
          'Válogassa, mossa és finoman darálja fel. A kemény, pektindús gyümölcshúst teljesen fel kell tárni, majd késlekedés nélkül beoltani.',
      'mash.preparation.stone':
          'Távolítsa el a kocsányt és lehetőleg a magot. Ha maggal együtt roppant, egyetlen magot se törjön össze; a sérült mag növeli a cianidvegyületek kockázatát.',
      'mash.preparation.soft':
          'Csak ép, érett bogyót használjon, távolítsa el a kocsányt és levelet, majd kíméletesen tárja fel. A gyors romlás miatt azonnal indítsa az erjesztést.',
      'mash.process.title': 'Általános cefrézési ellenőrzőlista',
      'mash.process.quality':
          'Kizárólag teljesen érett, tiszta, penész- és rothadásmentes gyümölcsöt használjon; a tárolt vagy sérült gyümölcsöt azonnal válogassa át.',
      'mash.process.ph':
          'Mérjen pH-t. A szakmai technológiai útmutatók jellemzően 2,8–3,2 közötti védett tartományt alkalmaznak, de a szükséges savmennyiség Brixből nem számítható: kis mintán végzett próbabeállítás és a savkészítmény címkéje szükséges.',
      'mash.process.fermentation':
          'Tiszta, élelmiszeripari edényben, kotyogóval vagy más biztonságos CO₂-elvezetéssel, levegőtől védve erjesszen. Általános célhőmérséklet 15–20 °C; az élesztő adatlapja az elsődleges.',
      'mash.process.cap':
          'A felúszó cefrebundát naponta kíméletesen merítse vissza, de ne keverjen feleslegesen oxigént a cefrébe. Naponta kövesse a hőmérsékletet és a Brix változását.',
      'mash.process.finish':
          'A stabil Brix és a gázképződés megszűnése együtt jelezheti a kierjedést. Ne hagyatkozzon csak a napok számára; a kész cefrét zártan, hűvösen tartsa és mielőbb szakszerűen pároltassa le.',
      'mash.process.co2':
          'A szén-dioxid színtelen, szagtalan és fulladást okozhat. Csak jól szellőző helyen erjesszen, ne hajoljon tartályba, és zárt helyen használjon CO₂-érzékelőt.',
      'mash.process.legal':
          'Magyar pálinkához cukrot nem szabad a gyümölcshöz adni. A lepárlást és az elnevezést mindig az aktuális helyi és jövedéki szabályok szerint végezze.',
      'mash.sources.title': 'Szakmai források és módszertan',
      'mash.sources.subtitle':
          'A dózisok tervezési segédletek, nem helyettesítik a termék adatlapját és a mérést.',
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
      'nav.mash': 'Mash',
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
      'history.mash': 'Mash planning',
      'history.title': 'Calculation history',
      'history.clear': 'Clear history',
      'history.empty': 'No saved calculations yet.',
      'mash.title': 'Fruit mash planner',
      'mash.subtitle':
          'Fruit-specific planning for ingredients, processing aids and potential alcohol.',
      'mash.fruit': 'Fruit type',
      'mash.amount': 'Mash mass',
      'mash.yeastDose': 'Yeast label dosage',
      'mash.brix': 'Measured fruit Brix',
      'mash.error.amount': 'Mash mass must be between 0 and 100,000 kg.',
      'mash.error.yeastDose':
          'Yeast dosage must be between 0 and 500 g/100 kg.',
      'mash.error.brix': 'Brix must be between 0 and 40 °Bx.',
      'mash.result.title': 'Planned quantities',
      'mash.result.yeast': 'Yeast required',
      'mash.result.enzyme': 'Pectolytic enzyme',
      'mash.result.nutrient': 'Complex yeast nutrient',
      'mash.result.abv': 'Estimated potential alcohol',
      'mash.result.enzymeNote':
          'The enzyme value is the manufacturer range at 15 °C for Distizym FM-Top, a concentrated liquid distilling enzyme. For any other product, its label takes priority; use only a low-pectin-esterase product intended for fruit distilling.',
      'mash.result.nutrientNote':
          'The 25–40 g/100 kg nutrient range is the published Vitamon Combi reference for cool fruit-mash fermentation. For a different formulation, follow its dosage and timing; accurate nitrogen demand requires a YAN measurement.',
      'mash.result.abvNote':
          'Brix measures soluble solids, not only fermentable sugar. The 0.52–0.61 × °Bx range is a planning estimate; fruit, yeast, residual sugar and temperature change the actual result.',
      'mash.warning.highBrix':
          'High Brix: check the yeast alcohol tolerance. If fermentation stalls, do not automatically add more nutrient; measure Brix, temperature and pH first.',
      'mash.category.pome': 'Pome or firm-fleshed fruit',
      'mash.category.stone': 'Stone fruit',
      'mash.category.soft': 'Berry or soft fruit',
      'mash.guidance.preparation': 'Category preparation',
      'mash.guidance.specific': 'Fruit-specific points',
      'mash.preparation.pome':
          'Sort, wash and mill finely. Firm, pectin-rich flesh must be opened completely, then inoculated without delay.',
      'mash.preparation.stone':
          'Remove stalks and preferably stones. If crushing with stones present, do not break any; damaged stones increase the risk from cyanogenic compounds.',
      'mash.preparation.soft':
          'Use only sound, ripe berries, remove stems and leaves, then crush gently. Start fermentation immediately because soft fruit spoils quickly.',
      'mash.process.title': 'General mash checklist',
      'mash.process.quality':
          'Use only fully ripe, clean fruit free of mould and rot; re-sort stored or damaged fruit immediately before processing.',
      'mash.process.ph':
          'Measure pH. Technical process guides commonly use a protected range of 2.8–3.2, but the required acid amount cannot be calculated from Brix: a bench trial and the acid product label are required.',
      'mash.process.fermentation':
          'Ferment in a clean food-grade vessel, protected from air, with an airlock or another safe CO₂ outlet. A general target is 15–20 °C; the yeast data sheet takes priority.',
      'mash.process.cap':
          'Gently submerge the floating cap every day without mixing unnecessary oxygen into the mash. Track temperature and Brix change daily.',
      'mash.process.finish':
          'Stable Brix together with the end of gas production can indicate completion. Do not rely only on elapsed days; keep finished mash sealed and cool and have it professionally distilled promptly.',
      'mash.process.co2':
          'Carbon dioxide is colourless, odourless and can cause suffocation. Ferment only with good ventilation, never lean into a tank, and use a CO₂ detector in enclosed areas.',
      'mash.process.legal':
          'Sugar must not be added when producing Hungarian pálinka. Always follow current local excise, distillation and naming rules.',
      'mash.sources.title': 'Technical sources and method',
      'mash.sources.subtitle':
          'Dosages are planning aids and do not replace product data sheets or measurements.',
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
      'nav.mash': 'Borhot',
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
      'history.mash': 'Planificarea borhotului',
      'history.title': 'Istoricul calculelor',
      'history.clear': 'Șterge istoricul',
      'history.empty': 'Nu există încă niciun calcul salvat.',
      'mash.title': 'Planificator pentru borhot',
      'mash.subtitle':
          'Planificare specifică fructului pentru ingrediente, auxiliari tehnologici și alcool potențial.',
      'mash.fruit': 'Tipul fructului',
      'mash.amount': 'Masa borhotului',
      'mash.yeastDose': 'Doza de drojdie de pe etichetă',
      'mash.brix': 'Brix măsurat al fructului',
      'mash.error.amount':
          'Masa borhotului trebuie să fie între 0 și 100.000 kg.',
      'mash.error.yeastDose':
          'Doza de drojdie trebuie să fie între 0 și 500 g/100 kg.',
      'mash.error.brix': 'Valoarea Brix trebuie să fie între 0 și 40 °Bx.',
      'mash.result.title': 'Cantități planificate',
      'mash.result.yeast': 'Drojdie necesară',
      'mash.result.enzyme': 'Enzimă pectolitică',
      'mash.result.nutrient': 'Nutrient complex pentru drojdie',
      'mash.result.abv': 'Alcool potențial estimat',
      'mash.result.enzymeNote':
          'Valoarea enzimei este intervalul producătorului la 15 °C pentru Distizym FM-Top, o enzimă lichidă concentrată pentru distilare. Pentru orice alt produs prevalează eticheta sa; folosiți numai un produs cu activitate redusă de pectin-esterază, destinat distilatelor de fructe.',
      'mash.result.nutrientNote':
          'Intervalul de nutrient 25–40 g/100 kg este referința publicată pentru Vitamon Combi la fermentarea la rece a borhotului de fructe. Pentru altă formulă urmați dozarea și momentul aplicării de pe etichetă; necesarul exact de azot cere măsurarea YAN.',
      'mash.result.abvNote':
          'Brix măsoară solidele solubile, nu numai zahărul fermentescibil. Intervalul 0,52–0,61 × °Bx este o estimare; fructul, drojdia, zahărul rezidual și temperatura modifică rezultatul real.',
      'mash.warning.highBrix':
          'Brix ridicat: verificați toleranța drojdiei la alcool. Dacă fermentarea se oprește, nu adăugați automat mai mult nutrient; măsurați mai întâi Brix, temperatura și pH-ul.',
      'mash.category.pome': 'Fruct semințos sau cu pulpă tare',
      'mash.category.stone': 'Fruct sâmburos',
      'mash.category.soft': 'Fruct de pădure sau cu pulpă moale',
      'mash.guidance.preparation': 'Pregătirea categoriei',
      'mash.guidance.specific': 'Aspecte specifice fructului',
      'mash.preparation.pome':
          'Sortați, spălați și măcinați fin. Pulpa tare și bogată în pectină trebuie desfăcută complet, apoi inoculată fără întârziere.',
      'mash.preparation.stone':
          'Îndepărtați codițele și, de preferință, sâmburii. Dacă zdrobiți cu sâmburii prezenți, nu spargeți niciunul; sâmburii deteriorați cresc riscul compușilor cianogeni.',
      'mash.preparation.soft':
          'Folosiți numai fructe sănătoase și coapte, îndepărtați codițele și frunzele, apoi zdrobiți delicat. Porniți imediat fermentarea, deoarece fructele moi se alterează rapid.',
      'mash.process.title': 'Lista generală pentru borhot',
      'mash.process.quality':
          'Folosiți numai fructe complet coapte, curate, fără mucegai și putregai; sortați din nou fructele păstrate sau deteriorate chiar înainte de prelucrare.',
      'mash.process.ph':
          'Măsurați pH-ul. Ghidurile tehnologice folosesc frecvent intervalul protejat 2,8–3,2, dar cantitatea de acid nu poate fi calculată din Brix: sunt necesare o probă la scară mică și eticheta produsului acidifiant.',
      'mash.process.fermentation':
          'Fermentați într-un vas alimentar curat, protejat de aer, cu supapă sau altă evacuare sigură a CO₂. Ținta generală este 15–20 °C; fișa drojdiei are prioritate.',
      'mash.process.cap':
          'Scufundați delicat, zilnic, căciula plutitoare fără a introduce inutil oxigen. Urmăriți zilnic temperatura și schimbarea Brix-ului.',
      'mash.process.finish':
          'Brix-ul stabil împreună cu oprirea degajării de gaz pot indica finalizarea. Nu vă bazați doar pe numărul de zile; păstrați borhotul fermentat închis și rece și distilați-l profesionist cât mai curând.',
      'mash.process.co2':
          'Dioxidul de carbon este incolor, inodor și poate provoca asfixiere. Fermentați numai cu ventilație bună, nu vă aplecați în rezervor și folosiți detector de CO₂ în spații închise.',
      'mash.process.legal':
          'Pentru pálinka maghiară nu se adaugă zahăr fructelor. Respectați întotdeauna normele locale actuale privind accizele, distilarea și denumirea.',
      'mash.sources.title': 'Surse tehnice și metodă',
      'mash.sources.subtitle':
          'Dozele sunt ajutoare de planificare și nu înlocuiesc fișa produsului sau măsurătorile.',
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
