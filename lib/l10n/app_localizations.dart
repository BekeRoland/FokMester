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
      'nav.calculations': 'Számítások',
      'nav.distillation': 'Főzés',
      'nav.more': 'Továbbiak',
      'calculations.correction': 'Korrekció',
      'calculations.dilution': 'Hígítás',
      'more.title': 'Továbbiak',
      'more.guideSubtitle': 'Mérési és hígítási tudnivalók',
      'more.historySubtitle': 'Korábbi számítások megtekintése',
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
      'mash.continueDistillation': 'Folytatás a főzéssel',
      'distillation.title': 'Főzési útmutató',
      'distillation.subtitle':
          'Válasszon gyümölcsöt és lepárlási módot a célzott ellenőrzőlistához.',
      'distillation.fromMash': 'A cefretervből átvéve: {value} kg',
      'distillation.method': 'Lepárlási mód',
      'distillation.method.pot': 'Kisüsti',
      'distillation.method.column': 'Tornyos',
      'distillation.method.pot.body':
          'Hagyományos, kétszeri szakaszos eljárás: az első főzés alszeszt készít, a második finomításkor történik az elő-, közép- és utópárlat érzékszervi elválasztása.',
      'distillation.method.column.body':
          'Az erősítőfeltétes vagy oszlopos berendezés egy menetben főz és finomít. A tányérok és a deflegmátor beállítása az alkohol- és aromakoncentrációt együtt alakítja.',
      'distillation.beforeHeating': 'Főzés előtt ezt ellenőrizze',
      'distillation.method.preserve': 'Megőrzendő karakter: {target}',
      'distillation.cuts.title': 'Érzékszervi vágási útmutató',
      'distillation.cuts.subtitle':
          'A felső értéknél kezdje a sűrű ellenőrzést. A tartományon belül mindig a lehűtött minta változása döntsön.',
      'distillation.cuts.headsToHeart': 'Előpárlat → középpárlat',
      'distillation.cuts.heartToTails': 'Középpárlat → utópárlat',
      'distillation.cuts.pot.headsToHeart':
          'A kifolyó párlat {high} értékénél kezdje sűrűn ellenőrizni az előpárlat végét. A {range} tartományban csak akkor váltson középpárlatra, amikor a szúrós, oldószeres jegyek eltűntek és megjelent a tiszta gyümölcsillat.',
      'distillation.cuts.pot.heartToTails':
          'A kifolyó párlat {high} értékénél kezdje sűrűn figyelni az utópárlat megjelenését. A {range} tartományban az első nehéz, savanykás, főtt vagy olajos jegynél váltson utópárlatra; ne várjon automatikusan {low}-ig.',
      'distillation.cuts.column.headsToHeart':
          'A kifolyó párlat {high} értékénél kezdje sűrűn ellenőrizni az előpárlat végét. Tornyos gépen a {range} tartományon belül a tiszta gyümölcsillat és a gépkönyv alapján váltson középpárlatra.',
      'distillation.cuts.column.heartToTails':
          'A kifolyó párlat {high} értékénél kezdje sűrűn figyelni az utópárlat megjelenését. A {range} tartományban az első nehéz vagy fojtott jegynél váltson; ne várjon automatikusan {low}-ig.',
      'distillation.cuts.note':
          'Nem automatikus kapcsolási érték. A valós vágási pontot a cefre alkoholtartalma, a főzési sebesség és a berendezés is eltolja. A mintát mindig hűtse 20 °C-ra; érzékszervi vizsgálathoz kis részt hígítson kb. 20–30%-ra.',
      'distillation.sensory.cleanSignal':
          'A keresendő tiszta gyümölcskarakter:',
      'distillation.sensory.heartTitle': 'Tiszta középpárlat',
      'distillation.sensory.heartBody':
          'Egymást követő kis mintákat hasonlítson össze. A középpárlat legyen tiszta és egyre határozottabban ezt mutassa: {target} Ha a következő minta romlik, ne a kihozatal kedvéért tartsa meg.',
      'distillation.sensory.lateSignal':
          'A késői gyümölcsjegyek és az utópárlat megkülönböztetése:',
      'distillation.risks': 'Fő kockázatok',
      'distillation.risk.foaming': 'Habzás',
      'distillation.risk.scorching': 'Leégés',
      'distillation.risk.low': 'Alacsony',
      'distillation.risk.medium': 'Közepes',
      'distillation.risk.high': 'Magas',
      'distillation.warning.stone':
          'Csonthéjas: a magokat lehetőleg távolítsa el, törött magot ne főzzön. A hidrogén-cianid és etil-karbamát kockázata laborvizsgálat nélkül nem ítélhető meg biztosan.',
      'distillation.warning.pectin':
          'Pektindús gyümölcs: a metanol főként a pektin lebomlásából keletkezik, és nem távolítható el megbízhatóan egy egyszerű, rögzített előpárlat-vágással.',
      'distillation.strategy.title': 'Ehhez az aromaprofilhoz',
      'distillation.pot.delicate':
          'Tartson egyenletes üzemet, és a finomításkor sűrűn vegyen kis érzékszervi mintát. A tisztaság mellett a könnyű gyümölcsillat megőrzése legyen a cél.',
      'distillation.pot.balanced':
          'A finomításnál fokozatosan, kis mintákkal keresse az elválasztási pontokat. A gyümölcsös középpárlatot se oldószeres előpárlat, se nehéz utópárlat ne fedje el.',
      'distillation.pot.late':
          'A jellegzetes telt aromák a finomítás későbbi részében is megjelenhetnek. Ne vágjon pusztán előre rögzített mennyiség alapján, de az utópárlati hibát ne engedje a középpárlatba.',
      'distillation.column.delicate':
          'A berendezés kézikönyve szerinti stabil, visszafogott aromatisztítást használjon. A túl erős deflegmáció csökkentheti a finom vezéraromák koncentrációját.',
      'distillation.column.balanced':
          'Tartsa stabilan a fűtést és a hűtést, majd kis érzékszervi mintákkal kövesse az átmeneteket. A deflegmációt ne csak a magas kihozatalhoz állítsa.',
      'distillation.column.late':
          'A túl erős deflegmáció a későn illó vezéraromákat túlságosan hátratolhatja. Csak a gyártó által engedett tartományban, érzékszervi visszajelzés alapján módosítson.',
      'distillation.faults.title': 'Gyors hibafelismerő',
      'distillation.faults.subtitle':
          'Mit jelezhet egy kellemetlen illat vagy íz?',
      'distillation.faults.solvent.title': 'Szúrós, oldószeres',
      'distillation.faults.solvent.body':
          'Lehet még előpárlati átmenet, de hibás vagy túl meleg erjedés is erősítheti. Hasonlítsa össze a következő kis mintával; csak a tisztulás után váltson.',
      'distillation.faults.vinegar.title': 'Ecetes, savanyú',
      'distillation.faults.vinegar.body':
          'Gyakran ecetsavas cefrehiba jele. A lepárlás nem teszi automatikusan hibamentessé az alapanyagot, ezért az ilyen tételt különösen szigorúan bírálja.',
      'distillation.faults.scorched.title': 'Égett, karamellizált',
      'distillation.faults.scorched.body':
          'Leégésre vagy túl nagy helyi hőterhelésre utalhat. Ellenőrizze a keverést és a fűtést a gépkönyv szerint; az égett íz vágással ritkán javítható.',
      'distillation.faults.tails.title': 'Nehéz, olajos, főtt',
      'distillation.faults.tails.body':
          'Jellemzően az utópárlati átmenet erősödése. Váltson külön gyűjtésre, majd a végső házasítást csak pihentetett, hígított minták alapján döntse el.',
      'distillation.faults.neutral.title': 'Túl semleges, kevés gyümölcs',
      'distillation.faults.neutral.body':
          'Okozhatja gyenge alapanyag, hibás erjedés vagy túl erős aromatisztítás. Ne próbálja egy hibás, nehéz frakció visszaengedésével pótolni.',
      'distillation.faults.musty.title': 'Dohos, penészes vagy romlott',
      'distillation.faults.musty.body':
          'Súlyos alapanyag- vagy cefrehibára utalhat. Ne tekintse egyszerű vágási problémának, és bizonytalanság esetén ne használja fel a tételt.',
      'distillation.faults.note':
          'Ezek lehetséges okok, nem laboratóriumi diagnózisok. Egyetlen illat, alkoholfok vagy hőmérséklet önmagában nem igazolja a párlat megfelelőségét.',
      'distillation.laboratory.title':
          'A metanol nem ismerhető fel szag alapján',
      'distillation.laboratory.body':
          'A metanol jelenlétét és a jogszabályi megfelelést sem kóstolás, sem az előpárlat mennyisége nem bizonyítja. Pektindús vagy csonthéjas alapanyagnál különösen fontos a helyes technológia; biztos eredményt csak laborvizsgálat ad.',
      'distillation.checklist': 'Főzési ellenőrzőlista',
      'distillation.check.finished':
          'Csak igazoltan kierjedt, hibamentes cefrét töltsön; a kész cefrét mielőbb párolja le.',
      'distillation.check.charge':
          'Ellenőrizze a tisztaságot, a szabad gőzutat és a gépkönyv szerinti töltési határt. Habzó vagy sűrű cefrénél hagyjon nagyobb szabad teret.',
      'distillation.check.heat':
          'Felügyelet mellett, fokozatosan fűtsön. Keverést, gőzköpenyt vagy habzásgátlót csak akkor használjon, ha azt a berendezés és a termék előírása engedi.',
      'distillation.check.pot':
          'Az első menetben készítsen alszeszt; az elő-, közép- és utópárlat végleges érzékszervi elválasztását a külön finomítás során végezze.',
      'distillation.check.column':
          'A tányérok, a deflegmátor, a fűtés és a hűtés gyártói beállításait együtt kezelje; egyetlen univerzális érték nem vihető át más berendezésre.',
      'distillation.check.cuts':
          'Az elválasztást illat, íz, mérés és tapasztalat együtt vezesse. A gyümölcs önmagában nem határoz meg biztonságos, rögzített liter- vagy hőfokértéket.',
      'distillation.check.record':
          'Rögzítse a cefrét, a berendezést, a beállításokat és a minták érzékszervi változását, hogy a következő főzés ellenőrizhetően javítható legyen.',
      'distillation.safety.title': 'Biztonság és jogszerűség',
      'distillation.safety.body':
          'Az alkoholgőz tűzveszélyes, a forró és nyomás alatt álló berendezés súlyos sérülést okozhat. Soha ne zárja el a gőzutat, biztosítson szellőzést, tartsa be a gépkönyvet és a helyi jövedéki szabályokat; bizonytalanság esetén bízza engedélyezett főzdére.',
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
      'nav.calculations': 'Tools',
      'nav.distillation': 'Distilling',
      'nav.more': 'More',
      'calculations.correction': 'Correction',
      'calculations.dilution': 'Dilution',
      'more.title': 'More',
      'more.guideSubtitle': 'Measurement and dilution guidance',
      'more.historySubtitle': 'View previous calculations',
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
      'mash.continueDistillation': 'Continue to distilling',
      'distillation.title': 'Distillation guide',
      'distillation.subtitle':
          'Choose a fruit and distillation method for a focused checklist.',
      'distillation.fromMash': 'Carried over from the mash plan: {value} kg',
      'distillation.method': 'Distillation method',
      'distillation.method.pot': 'Double pot still',
      'distillation.method.column': 'Column still',
      'distillation.method.pot.body':
          'Traditional two-stage batch process: the first run produces low wines, while heads, heart and tails are separated by sensory judgement during the separate spirit run.',
      'distillation.method.column.body':
          'A plated or column still distils and rectifies in one run. The plates and dephlegmator shape alcohol concentration and fruit aroma together.',
      'distillation.beforeHeating': 'Check this before heating',
      'distillation.method.preserve': 'Character to preserve: {target}',
      'distillation.cuts.title': 'Sensory cut guide',
      'distillation.cuts.subtitle':
          'Begin frequent checks at the upper value. Within the window, let changes in the cooled sample decide.',
      'distillation.cuts.headsToHeart': 'Heads → heart',
      'distillation.cuts.heartToTails': 'Heart → tails',
      'distillation.cuts.pot.headsToHeart':
          'When the running distillate reaches {high}, begin checking frequently for the end of the heads. Within {range}, switch to hearts only after sharp solvent-like notes disappear and clean fruit aroma appears.',
      'distillation.cuts.pot.heartToTails':
          'At {high}, begin checking frequently for the first signs of tails. Within {range}, switch at the first heavy, sour, cooked or oily note; do not automatically wait for {low}.',
      'distillation.cuts.column.headsToHeart':
          'At {high}, begin checking frequently for the end of the heads. On a column still, switch to hearts within {range} according to clean fruit aroma and the equipment manual.',
      'distillation.cuts.column.heartToTails':
          'At {high}, begin checking frequently for the first signs of tails. Within {range}, switch at the first heavy or muted note; do not automatically wait for {low}.',
      'distillation.cuts.note':
          'Not an automatic switching value. Mash alcohol, run speed and still configuration can move the true cut point. Cool every sample to 20 °C; dilute a small sensory sample to about 20–30% before assessment.',
      'distillation.sensory.cleanSignal':
          'The clean fruit character to look for:',
      'distillation.sensory.heartTitle': 'Clean heart',
      'distillation.sensory.heartBody':
          'Compare consecutive small samples. The heart should remain clean and show this character more clearly: {target} If the next sample deteriorates, do not keep it merely to increase yield.',
      'distillation.sensory.lateSignal':
          'Distinguishing late fruit character from tails:',
      'distillation.risks': 'Main risks',
      'distillation.risk.foaming': 'Foaming',
      'distillation.risk.scorching': 'Scorching',
      'distillation.risk.low': 'Low',
      'distillation.risk.medium': 'Medium',
      'distillation.risk.high': 'High',
      'distillation.warning.stone':
          'Stone fruit: preferably remove stones and never distil broken ones. Hydrogen cyanide and ethyl-carbamate risk cannot be assessed reliably without laboratory testing.',
      'distillation.warning.pectin':
          'Pectin-rich fruit: methanol is formed mainly from pectin breakdown and cannot be removed reliably with one fixed heads cut.',
      'distillation.strategy.title': 'For this aroma profile',
      'distillation.pot.delicate':
          'Keep operation steady and take frequent small sensory samples during the spirit run. Preserve light fruit aroma while achieving a clean heart.',
      'distillation.pot.balanced':
          'Approach the cuts gradually with small sensory samples. Neither solvent-like heads nor heavy tails should cover the fruity heart.',
      'distillation.pot.late':
          'Characteristic rich aromas may still arrive later in the spirit run. Do not cut only by a preset volume, but keep genuine tail faults out of the heart.',
      'distillation.column.delicate':
          'Use stable, restrained aroma purification within the equipment manual. Excessive dephlegmation can reduce delicate key aromas.',
      'distillation.column.balanced':
          'Keep heat and cooling stable and follow transitions with small sensory samples. Do not set dephlegmation solely for maximum yield.',
      'distillation.column.late':
          'Excessive dephlegmation can push low-volatility key aromas too far back. Adjust only within the manufacturer’s range and from sensory feedback.',
      'distillation.faults.title': 'Quick fault guide',
      'distillation.faults.subtitle':
          'What can an unpleasant aroma or taste indicate?',
      'distillation.faults.solvent.title': 'Sharp and solvent-like',
      'distillation.faults.solvent.body':
          'It may still be the heads transition, while faulty or overly warm fermentation can intensify it. Compare the next small sample and switch only after it cleans up.',
      'distillation.faults.vinegar.title': 'Vinegary and sour',
      'distillation.faults.vinegar.body':
          'Often indicates an acetic mash fault. Distillation does not automatically repair faulty raw material, so assess such a batch particularly strictly.',
      'distillation.faults.scorched.title': 'Burnt or caramelised',
      'distillation.faults.scorched.body':
          'May indicate scorching or excessive local heat. Check agitation and heat against the equipment manual; a burnt fault is rarely corrected by cuts.',
      'distillation.faults.tails.title': 'Heavy, oily or cooked',
      'distillation.faults.tails.body':
          'Usually indicates a strengthening tail transition. Change to separate collection and decide any final blending only from rested, diluted samples.',
      'distillation.faults.neutral.title': 'Too neutral, little fruit',
      'distillation.faults.neutral.body':
          'Possible causes include weak fruit, faulty fermentation or excessive rectification. Do not compensate by returning a faulty heavy fraction.',
      'distillation.faults.musty.title': 'Musty, mouldy or spoiled',
      'distillation.faults.musty.body':
          'May indicate a serious raw-material or mash fault. Do not treat it as a simple cutting issue, and do not use the batch when safety is uncertain.',
      'distillation.faults.note':
          'These are possible causes, not laboratory diagnoses. No single aroma, strength or temperature proves that a spirit is compliant.',
      'distillation.laboratory.title': 'Methanol cannot be identified by smell',
      'distillation.laboratory.body':
          'Neither tasting nor heads volume proves methanol content or legal compliance. Correct process is especially important for pectin-rich and stone fruit; only laboratory analysis gives a reliable result.',
      'distillation.checklist': 'Distillation checklist',
      'distillation.check.finished':
          'Charge only confirmed fully fermented, fault-free mash and distil finished mash promptly.',
      'distillation.check.charge':
          'Check cleanliness, an unobstructed vapour path and the manual’s fill limit. Leave additional headspace for foamy or dense mash.',
      'distillation.check.heat':
          'Heat gradually under continuous supervision. Use agitation, a steam jacket or antifoam only when approved by the still and product instructions.',
      'distillation.check.pot':
          'Produce low wines in the first run; make the final sensory separation of heads, heart and tails in the separate spirit run.',
      'distillation.check.column':
          'Treat plate, dephlegmator, heat and cooling settings as one system. No universal setting transfers safely between different stills.',
      'distillation.check.cuts':
          'Use aroma, taste, measurement and experience together for cuts. Fruit type alone does not define a safe fixed volume or temperature.',
      'distillation.check.record':
          'Record the mash, equipment, settings and sensory changes in samples so the next run can be improved reproducibly.',
      'distillation.safety.title': 'Safety and legality',
      'distillation.safety.body':
          'Alcohol vapour is flammable, and hot or pressurised equipment can cause severe injury. Never block the vapour path, provide ventilation, follow the manual and local excise rules, and use a licensed distillery when unsure.',
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
      'nav.calculations': 'Calcule',
      'nav.distillation': 'Distilare',
      'nav.more': 'Mai mult',
      'calculations.correction': 'Corecție',
      'calculations.dilution': 'Diluare',
      'more.title': 'Mai mult',
      'more.guideSubtitle': 'Indicații pentru măsurare și diluare',
      'more.historySubtitle': 'Vedeți calculele anterioare',
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
      'mash.continueDistillation': 'Continuă cu distilarea',
      'distillation.title': 'Ghid de distilare',
      'distillation.subtitle':
          'Alegeți fructul și metoda pentru o listă de verificare specifică.',
      'distillation.fromMash': 'Preluat din planul borhotului: {value} kg',
      'distillation.method': 'Metoda de distilare',
      'distillation.method.pot': 'Cazan, două treceri',
      'distillation.method.column': 'Coloană',
      'distillation.method.pot.body':
          'Procedeu tradițional discontinuu în două treceri: prima produce distilatul brut, iar la rafinarea separată se delimitează senzorial capetele, inima și cozile.',
      'distillation.method.column.body':
          'Instalația cu talere sau coloană distilează și rectifică într-o singură trecere. Talerele și deflegmatorul modelează împreună concentrația alcoolului și aroma fructului.',
      'distillation.beforeHeating': 'Verificați înainte de încălzire',
      'distillation.method.preserve': 'Caracter de păstrat: {target}',
      'distillation.cuts.title': 'Ghid senzorial pentru separări',
      'distillation.cuts.subtitle':
          'Începeți verificările dese la valoarea superioară. În interval, decide schimbarea probei răcite.',
      'distillation.cuts.headsToHeart': 'Capete → inimă',
      'distillation.cuts.heartToTails': 'Inimă → cozi',
      'distillation.cuts.pot.headsToHeart':
          'Când distilatul la ieșire ajunge la {high}, începeți verificarea frecventă a sfârșitului capetelor. În intervalul {range}, treceți la inimă numai după dispariția notelor înțepătoare de solvent și apariția aromei curate de fruct.',
      'distillation.cuts.pot.heartToTails':
          'La {high}, începeți să urmăriți frecvent apariția cozilor. În intervalul {range}, schimbați fracția la prima notă grea, acră, fiartă sau uleioasă; nu așteptați automat până la {low}.',
      'distillation.cuts.column.headsToHeart':
          'La {high}, începeți verificarea frecventă a sfârșitului capetelor. La instalația cu coloană, treceți la inimă în intervalul {range}, pe baza aromei curate de fruct și a manualului instalației.',
      'distillation.cuts.column.heartToTails':
          'La {high}, începeți să urmăriți frecvent apariția cozilor. În intervalul {range}, schimbați fracția la prima notă grea sau închisă; nu așteptați automat până la {low}.',
      'distillation.cuts.note':
          'Nu este o valoare automată de comutare. Alcoolul din borhot, viteza și configurația instalației pot deplasa punctul real. Răciți proba la 20 °C; pentru evaluare diluați o probă mică la aproximativ 20–30%.',
      'distillation.sensory.cleanSignal':
          'Caracterul curat de fruct care trebuie urmărit:',
      'distillation.sensory.heartTitle': 'Inimă curată',
      'distillation.sensory.heartBody':
          'Comparați probe mici consecutive. Inima trebuie să rămână curată și să arate tot mai clar acest caracter: {target} Dacă proba următoare se deteriorează, nu o păstrați doar pentru randament.',
      'distillation.sensory.lateSignal':
          'Deosebirea aromelor târzii de fruct de cozi:',
      'distillation.risks': 'Riscuri principale',
      'distillation.risk.foaming': 'Spumare',
      'distillation.risk.scorching': 'Ardere',
      'distillation.risk.low': 'Scăzut',
      'distillation.risk.medium': 'Mediu',
      'distillation.risk.high': 'Ridicat',
      'distillation.warning.stone':
          'Fruct sâmburos: de preferință scoateți sâmburii și nu distilați niciodată sâmburi sparți. Riscul de acid cianhidric și carbamat de etil nu poate fi stabilit sigur fără analiză de laborator.',
      'distillation.warning.pectin':
          'Fruct bogat în pectină: metanolul provine în principal din degradarea pectinei și nu poate fi eliminat fiabil printr-o cantitate fixă de capete.',
      'distillation.strategy.title': 'Pentru acest profil aromatic',
      'distillation.pot.delicate':
          'Mențineți funcționarea uniformă și luați frecvent probe senzoriale mici la rafinare. Păstrați aroma ușoară a fructului într-o inimă curată.',
      'distillation.pot.balanced':
          'Apropiați-vă treptat de separări, cu probe senzoriale mici. Nici capetele cu miros de solvent, nici cozile grele nu trebuie să acopere inima fructată.',
      'distillation.pot.late':
          'Aromele bogate caracteristice pot apărea mai târziu la rafinare. Nu separați numai după un volum prestabilit, dar nu lăsați defectele cozilor în inimă.',
      'distillation.column.delicate':
          'Folosiți o purificare aromatică stabilă și moderată, în limitele manualului. Deflegmarea excesivă poate reduce aromele-cheie delicate.',
      'distillation.column.balanced':
          'Mențineți stabile încălzirea și răcirea și urmăriți trecerile prin probe senzoriale mici. Nu reglați deflegmarea numai pentru randament maxim.',
      'distillation.column.late':
          'Deflegmarea excesivă poate împinge prea târziu aromele-cheie mai puțin volatile. Reglați numai în limitele producătorului și după evaluare senzorială.',
      'distillation.faults.title': 'Ghid rapid pentru defecte',
      'distillation.faults.subtitle':
          'Ce poate indica un miros sau gust neplăcut?',
      'distillation.faults.solvent.title': 'Înțepător, de solvent',
      'distillation.faults.solvent.body':
          'Poate fi încă trecerea capetelor, dar fermentarea defectuoasă sau prea caldă îl poate intensifica. Comparați proba mică următoare și treceți numai după curățare.',
      'distillation.faults.vinegar.title': 'Oțetit, acru',
      'distillation.faults.vinegar.body':
          'Indică adesea un defect acetic al borhotului. Distilarea nu repară automat materia primă defectă; evaluați un asemenea lot deosebit de strict.',
      'distillation.faults.scorched.title': 'Ars, caramelizat',
      'distillation.faults.scorched.body':
          'Poate indica ardere sau încălzire locală excesivă. Verificați agitarea și încălzirea conform manualului; defectul ars se corectează rar prin separări.',
      'distillation.faults.tails.title': 'Greu, uleios, fiert',
      'distillation.faults.tails.body':
          'Indică de regulă intensificarea trecerii spre cozi. Colectați separat și decideți amestecul final numai din probe odihnite și diluate.',
      'distillation.faults.neutral.title': 'Prea neutru, puțin fruct',
      'distillation.faults.neutral.body':
          'Cauzele pot fi fructul slab, fermentarea defectuoasă sau rectificarea excesivă. Nu compensați prin readăugarea unei fracții grele defecte.',
      'distillation.faults.musty.title': 'Mucegăit sau alterat',
      'distillation.faults.musty.body':
          'Poate indica un defect grav al materiei prime sau borhotului. Nu îl tratați ca simplă problemă de separare și nu folosiți lotul dacă siguranța este incertă.',
      'distillation.faults.note':
          'Acestea sunt cauze posibile, nu diagnostice de laborator. Niciun miros, tărie sau temperatură nu dovedește singur conformitatea distilatului.',
      'distillation.laboratory.title':
          'Metanolul nu poate fi recunoscut prin miros',
      'distillation.laboratory.body':
          'Nici degustarea, nici volumul capetelor nu dovedesc conținutul de metanol sau conformitatea legală. Tehnologia corectă este esențială mai ales la fructe bogate în pectină și sâmburoase; numai analiza de laborator oferă un rezultat sigur.',
      'distillation.checklist': 'Lista pentru distilare',
      'distillation.check.finished':
          'Încărcați numai borhot confirmat ca fermentat complet și fără defecte; distilați-l cât mai curând.',
      'distillation.check.charge':
          'Verificați curățenia, calea liberă a vaporilor și limita de umplere din manual. Lăsați spațiu liber suplimentar pentru borhot dens sau spumant.',
      'distillation.check.heat':
          'Încălziți treptat sub supraveghere continuă. Folosiți agitare, manta de abur sau antispumant numai dacă instalația și instrucțiunile produsului permit.',
      'distillation.check.pot':
          'Produceți distilatul brut la prima trecere; separarea senzorială finală a capetelor, inimii și cozilor se face la rafinarea distinctă.',
      'distillation.check.column':
          'Tratați reglajele talerelor, deflegmatorului, încălzirii și răcirii ca un singur sistem. Nicio valoare universală nu se transferă sigur între instalații.',
      'distillation.check.cuts':
          'Conduceți separările prin aromă, gust, măsurare și experiență împreună. Tipul fructului singur nu stabilește un volum sau o temperatură fixă sigură.',
      'distillation.check.record':
          'Notați borhotul, instalația, reglajele și schimbările senzoriale ale probelor pentru a îmbunătăți reproductibil următoarea distilare.',
      'distillation.safety.title': 'Siguranță și legalitate',
      'distillation.safety.body':
          'Vaporii de alcool sunt inflamabili, iar echipamentul fierbinte sau presurizat poate provoca răni grave. Nu blocați calea vaporilor, asigurați ventilație, respectați manualul și normele locale de accize; dacă nu sunteți sigur, apelați la o distilerie autorizată.',
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
