enum MashFruitCategory { pome, stone, soft }

class MashFruitProfile {
  final String id;
  final MashFruitCategory category;
  final Map<String, String> names;
  final Map<String, String> notes;

  const MashFruitProfile({
    required this.id,
    required this.category,
    required this.names,
    required this.notes,
  });

  String name(String languageCode) => names[languageCode] ?? names['hu']!;

  String note(String languageCode) => notes[languageCode] ?? notes['hu']!;
}

const mashFruitProfiles = <MashFruitProfile>[
  MashFruitProfile(
    id: 'apple',
    category: MashFruitCategory.pome,
    names: {'hu': 'Alma', 'en': 'Apple', 'ro': 'Măr'},
    notes: {
      'hu':
          'Mosás és válogatás után finoman darálja. Gyorsan dolgozza fel, mert a sérült alma hamar oxidálódik. Magas pektintartalma miatt csak lepárlási célra való, alacsony pektinészteráz-tartalmú enzimet használjon.',
      'en':
          'Wash, sort and mill finely. Process promptly because damaged apples oxidise quickly. Due to the high pectin content, use only a low-pectin-esterase enzyme intended for distilling.',
      'ro':
          'Spălați, sortați și măcinați fin. Prelucrați rapid, deoarece merele zdrobite oxidează repede. Din cauza conținutului ridicat de pectină, folosiți numai enzime cu activitate redusă de pectin-esterază, destinate distilării.',
    },
  ),
  MashFruitProfile(
    id: 'pear',
    category: MashFruitCategory.pome,
    names: {'hu': 'Körte', 'en': 'Pear', 'ro': 'Pară'},
    notes: {
      'hu':
          'Teljesen érett, puha, de egészséges gyümölcsöt daráljon. A körte szorbitot is tartalmaz, amely nem erjed alkohollá, ezért a Brix-alapú alkoholtartalom könnyebben túlbecsülhető. A kierjedt cefrét ne tárolja hosszan.',
      'en':
          'Mill fully ripe and soft but sound fruit. Pear contains sorbitol, which does not ferment to alcohol, so a Brix-based estimate is more likely to be high. Do not store the finished mash for long.',
      'ro':
          'Măcinați fructe complet coapte și moi, dar sănătoase. Para conține sorbitol, care nu fermentează în alcool, astfel estimarea bazată pe Brix poate fi prea mare. Nu păstrați mult timp borhotul fermentat.',
    },
  ),
  MashFruitProfile(
    id: 'quince',
    category: MashFruitCategory.pome,
    names: {'hu': 'Birs', 'en': 'Quince', 'ro': 'Gutuie'},
    notes: {
      'hu':
          'Távolítsa el a molyhos felületet, válogassa és nagyon finomra aprítsa a kemény gyümölcsöt. A birs sűrű, pektindús cefréje nehezen keverhető és könnyen leéghet; az enzim felső dózistartománya lehet indokolt.',
      'en':
          'Remove the fuzzy coating, sort, and mill the hard fruit very finely. Quince produces a thick, pectin-rich mash that is difficult to mix and can scorch; the upper enzyme range may be appropriate.',
      'ro':
          'Îndepărtați puful, sortați și mărunțiți foarte fin fructul tare. Gutuia produce un borhot dens și bogat în pectină, greu de amestecat și predispus la ardere; poate fi justificată limita superioară a dozei de enzimă.',
    },
  ),
  MashFruitProfile(
    id: 'medlar',
    category: MashFruitCategory.pome,
    names: {'hu': 'Naspolya', 'en': 'Medlar', 'ro': 'Moșmon'},
    notes: {
      'hu':
          'Csak utóérlelt, puha, de nem penészes naspolyát használjon. Távolítsa el a kocsányt és a romlott részeket, majd alaposan tárja fel a sűrű gyümölcshúst.',
      'en':
          'Use only bletted, soft medlars that are free of mould. Remove stalks and damaged parts, then break up the dense flesh thoroughly.',
      'ro':
          'Folosiți numai moșmoane bine înmuiate după coacere, fără mucegai. Îndepărtați codițele și părțile alterate, apoi zdrobiți bine pulpa densă.',
    },
  ),
  MashFruitProfile(
    id: 'plum',
    category: MashFruitCategory.stone,
    names: {'hu': 'Szilva', 'en': 'Plum', 'ro': 'Prună'},
    notes: {
      'hu':
          'Az érett gyümölcsöt magozza, vagy úgy roppantsa, hogy a magok ne sérüljenek. A felúszó cefrebundát naponta merítse vissza, levegő bekeverése nélkül, és a kierjedt cefrét mielőbb párolja le.',
      'en':
          'Dest stone-ripe fruit, or crush it without breaking the stones. Submerge the floating cap daily without mixing in air, and distil the finished mash promptly.',
      'ro':
          'Scoateți sâmburii fructelor coapte sau zdrobiți fără a sparge sâmburii. Scufundați zilnic căciula de borhot fără a introduce aer și distilați cât mai curând după terminarea fermentației.',
    },
  ),
  MashFruitProfile(
    id: 'apricot',
    category: MashFruitCategory.stone,
    names: {'hu': 'Kajszibarack', 'en': 'Apricot', 'ro': 'Caisă'},
    notes: {
      'hu':
          'Csak teljesen érett, aromás kajszit használjon. Magozza úgy, hogy a mag ne törjön, majd kíméletesen pépesítse; a 15–18 °C közötti erjesztés segít megőrizni a finom aromákat.',
      'en':
          'Use fully ripe, aromatic apricots. Remove stones without breaking them and pulp gently; fermentation at 15–18 °C helps retain delicate aromas.',
      'ro':
          'Folosiți caise complet coapte și aromate. Scoateți sâmburii fără a-i sparge și zdrobiți delicat; fermentarea la 15–18 °C ajută la păstrarea aromelor fine.',
    },
  ),
  MashFruitProfile(
    id: 'peach',
    category: MashFruitCategory.stone,
    names: {'hu': 'Őszibarack', 'en': 'Peach', 'ro': 'Piersică'},
    notes: {
      'hu':
          'Magozza a teljesen érett, egészséges gyümölcsöt, a magokat ne törje össze. A lágy hús gyorsan romlik, ezért a feldolgozás és a fajélesztős beoltás legyen azonnali.',
      'en':
          'Dest fully ripe, sound fruit and do not break the stones. The soft flesh spoils quickly, so process and inoculate with cultured yeast immediately.',
      'ro':
          'Scoateți sâmburii fructelor complet coapte și sănătoase, fără a-i sparge. Pulpa moale se alterează rapid, de aceea prelucrarea și inocularea cu drojdie selecționată trebuie făcute imediat.',
    },
  ),
  MashFruitProfile(
    id: 'sweet_cherry',
    category: MashFruitCategory.stone,
    names: {'hu': 'Cseresznye', 'en': 'Sweet cherry', 'ro': 'Cireașă'},
    notes: {
      'hu':
          'Kocsányozza és magozza, vagy a magok sérülése nélkül roppantsa. A felúszó héjréteget tartsa nedvesen és a tartályt védje a levegőtől.',
      'en':
          'Remove stalks and stones, or crush without damaging the stones. Keep the floating skins wet and protect the vessel from air.',
      'ro':
          'Îndepărtați codițele și sâmburii sau zdrobiți fără a deteriora sâmburii. Mențineți umed stratul de coji de la suprafață și protejați vasul de aer.',
    },
  ),
  MashFruitProfile(
    id: 'sour_cherry',
    category: MashFruitCategory.stone,
    names: {'hu': 'Meggy', 'en': 'Sour cherry', 'ro': 'Vișină'},
    notes: {
      'hu':
          'Kocsányozza és magozza, a magokat ne törje. A meggy sava magas lehet: mérje meg a pH-t, mert túl alacsony értéken az élesztő lassulhat; savat csak mérés alapján adjon.',
      'en':
          'Remove stalks and stones without breaking the stones. Sour cherry can be highly acidic: measure pH because very low pH may slow yeast; add acid only after measurement.',
      'ro':
          'Îndepărtați codițele și sâmburii fără a-i sparge. Vișinele pot fi foarte acide: măsurați pH-ul, deoarece o valoare prea mică poate încetini drojdia; adăugați acid numai după măsurare.',
    },
  ),
  MashFruitProfile(
    id: 'sloe',
    category: MashFruitCategory.stone,
    names: {'hu': 'Kökény', 'en': 'Sloe', 'ro': 'Porumbar'},
    notes: {
      'hu':
          'Teljesen érett, lehetőleg dércsípte gyümölcsöt használjon. A magot ne törje össze; a kis léhozam és a sűrű cefre miatt különösen fontos az alapos feltárás és a rendszeres ellenőrzés.',
      'en':
          'Use fully ripe fruit, preferably after frost. Do not break the stones; the low juice yield and dense mash make thorough pulping and regular checks especially important.',
      'ro':
          'Folosiți fructe complet coapte, de preferință după brumă. Nu spargeți sâmburii; randamentul mic de suc și borhotul dens impun o zdrobire atentă și verificări regulate.',
    },
  ),
  MashFruitProfile(
    id: 'cornelian_cherry',
    category: MashFruitCategory.stone,
    names: {'hu': 'Som', 'en': 'Cornelian cherry', 'ro': 'Corn'},
    notes: {
      'hu':
          'Csak teljesen érett, puha somot dolgozzon fel. A nagy magot távolítsa el vagy sérülés nélkül válassza le, a sűrű húst pedig gondosan tárja fel.',
      'en':
          'Process only fully ripe, soft Cornelian cherries. Remove or separate the large stones without damage and break up the dense flesh thoroughly.',
      'ro':
          'Prelucrați numai coarne complet coapte și moi. Îndepărtați sâmburii mari fără a-i deteriora și zdrobiți temeinic pulpa densă.',
    },
  ),
  MashFruitProfile(
    id: 'grape',
    category: MashFruitCategory.soft,
    names: {'hu': 'Szőlő', 'en': 'Grape', 'ro': 'Strugure'},
    notes: {
      'hu':
          'Bogyózza és roppantsa, a kocsány nagy részét távolítsa el. A törköly külön alapanyag és külön technológia; ez a számítás friss szőlőcefrére vonatkozik.',
      'en':
          'Destem and crush, removing most stems. Grape marc is a different raw material with a different process; this calculation is for fresh grape mash.',
      'ro':
          'Desciorchinați și zdrobiți, îndepărtând majoritatea ciorchinilor. Tescovina este o materie primă diferită, cu altă tehnologie; calculul se referă la borhot din struguri proaspeți.',
    },
  ),
  MashFruitProfile(
    id: 'strawberry',
    category: MashFruitCategory.soft,
    names: {'hu': 'Szamóca (eper)', 'en': 'Strawberry', 'ro': 'Căpșună'},
    notes: {
      'hu':
          'Távolítsa el a csészeleveleket, és csak egészséges, teljesen érett gyümölcsöt használjon. Nagyon romlékony és általában alacsony a cukortartalma, ezért azonnal, hűvösen indítsa az erjesztést.',
      'en':
          'Remove the calyx and use only sound, fully ripe fruit. Strawberries spoil very quickly and are usually low in sugar, so start a cool fermentation immediately.',
      'ro':
          'Îndepărtați sepalele și folosiți numai fructe sănătoase, complet coapte. Căpșunile se alterează foarte repede și au de obicei puțin zahăr, deci porniți imediat fermentarea la rece.',
    },
  ),
  MashFruitProfile(
    id: 'raspberry',
    category: MashFruitCategory.soft,
    names: {'hu': 'Málna', 'en': 'Raspberry', 'ro': 'Zmeură'},
    notes: {
      'hu':
          'A málna sérülékeny, ezért válogatás után azonnal, kíméletesen zúzza és oltsa be. Az illékony aroma megőrzéséhez tartsa az erjedést 15–18 °C közelében.',
      'en':
          'Raspberries are fragile; after sorting, crush gently and inoculate immediately. Keep fermentation near 15–18 °C to retain volatile aromas.',
      'ro':
          'Zmeura este fragilă; după sortare, zdrobiți delicat și inoculați imediat. Mențineți fermentarea aproape de 15–18 °C pentru păstrarea aromelor volatile.',
    },
  ),
  MashFruitProfile(
    id: 'blackberry',
    category: MashFruitCategory.soft,
    names: {'hu': 'Szeder', 'en': 'Blackberry', 'ro': 'Mură'},
    notes: {
      'hu':
          'Csak teljesen fekete, érett, penészmentes bogyót használjon. Kíméletesen zúzza, a felúszó mag- és héjréteget pedig naponta merítse vissza.',
      'en':
          'Use only fully black, ripe, mould-free berries. Crush gently and submerge the floating seed-and-skin cap daily.',
      'ro':
          'Folosiți numai fructe complet negre, coapte și fără mucegai. Zdrobiți delicat și scufundați zilnic stratul plutitor de semințe și coji.',
    },
  ),
  MashFruitProfile(
    id: 'blackcurrant',
    category: MashFruitCategory.soft,
    names: {
      'hu': 'Fekete ribizli',
      'en': 'Blackcurrant',
      'ro': 'Coacăză neagră',
    },
    notes: {
      'hu':
          'Bogyózza le és zúzza fel. A fekete ribizli savas és pektindús lehet: ellenőrizze a pH-t, és csak olyan élesztőt használjon, amely a mért savasságot elviseli.',
      'en':
          'Remove stems and crush. Blackcurrant can be acidic and pectin-rich: check pH and use a yeast able to tolerate the measured acidity.',
      'ro':
          'Îndepărtați codițele și zdrobiți. Coacăza neagră poate fi acidă și bogată în pectină: verificați pH-ul și folosiți o drojdie care tolerează aciditatea măsurată.',
    },
  ),
  MashFruitProfile(
    id: 'redcurrant',
    category: MashFruitCategory.soft,
    names: {'hu': 'Piros ribizli', 'en': 'Redcurrant', 'ro': 'Coacăză roșie'},
    notes: {
      'hu':
          'Bogyózza le, válogassa és zúzza fel. A magas természetes sav miatt a pH-t az élesztő beoltása előtt mérje meg; vakon ne savazzon.',
      'en':
          'Remove stems, sort and crush. Measure pH before inoculating because natural acidity can be high; do not add acid blindly.',
      'ro':
          'Îndepărtați codițele, sortați și zdrobiți. Măsurați pH-ul înainte de inoculare, deoarece aciditatea naturală poate fi ridicată; nu adăugați acid fără măsurare.',
    },
  ),
  MashFruitProfile(
    id: 'gooseberry',
    category: MashFruitCategory.soft,
    names: {'hu': 'Köszméte (egres)', 'en': 'Gooseberry', 'ro': 'Agrișă'},
    notes: {
      'hu':
          'Távolítsa el a kocsányt és a virágmaradványt, majd az érett bogyókat alaposan roppantsa meg. A savasság és az alacsonyabb Brix miatt mérés alapján tervezzen.',
      'en':
          'Remove stalks and flower remnants, then crush ripe berries thoroughly. Plan from measurements because acidity may be high and Brix relatively low.',
      'ro':
          'Îndepărtați codițele și resturile florale, apoi zdrobiți bine fructele coapte. Planificați pe baza măsurătorilor, deoarece aciditatea poate fi mare și Brix-ul relativ mic.',
    },
  ),
  MashFruitProfile(
    id: 'blueberry',
    category: MashFruitCategory.soft,
    names: {'hu': 'Áfonya', 'en': 'Blueberry', 'ro': 'Afină'},
    notes: {
      'hu':
          'A héjat minden bogyón fel kell tárni, de a magokat ne őrölje. A felúszó héjat tartsa nedvesen, és figyelje a pH-t, valamint az erjedés napi Brix-csökkenését.',
      'en':
          'Break every berry skin without grinding the seeds. Keep floating skins wet and monitor pH and the daily Brix drop during fermentation.',
      'ro':
          'Spargeți coaja fiecărui fruct fără a măcina semințele. Mențineți cojile plutitoare umede și urmăriți pH-ul și scăderea zilnică a Brix-ului.',
    },
  ),
  MashFruitProfile(
    id: 'elderberry',
    category: MashFruitCategory.soft,
    names: {'hu': 'Fekete bodza', 'en': 'Elderberry', 'ro': 'Soc negru'},
    notes: {
      'hu':
          'Csak teljesen érett, fekete bodzabogyót használjon. A kocsányokat, leveleket, zöld és éretlen bogyókat maradéktalanul távolítsa el, majd kíméletesen zúzza.',
      'en':
          'Use only fully ripe black elderberries. Completely remove stems, leaves, green and unripe berries, then crush gently.',
      'ro':
          'Folosiți numai boabe de soc negru complet coapte. Îndepărtați complet codițele, frunzele și boabele verzi sau necoapte, apoi zdrobiți delicat.',
    },
  ),
  MashFruitProfile(
    id: 'mulberry',
    category: MashFruitCategory.soft,
    names: {'hu': 'Eperfa termése', 'en': 'Mulberry', 'ro': 'Dudă'},
    notes: {
      'hu':
          'Csak teljesen érett, tiszta termést használjon és azonnal dolgozza fel. A savtartalom gyakran alacsony, ezért a mikrobiológiai védelemhez különösen fontos a pH mérése és szükség szerinti próbabeállítása.',
      'en':
          'Use only fully ripe, clean fruit and process immediately. Acidity is often low, so measuring pH and making a trial adjustment when needed is especially important for microbial control.',
      'ro':
          'Folosiți numai dude complet coapte și curate și prelucrați-le imediat. Aciditatea este adesea scăzută, de aceea măsurarea pH-ului și o ajustare de probă, dacă este necesară, sunt deosebit de importante.',
    },
  ),
  MashFruitProfile(
    id: 'rosehip',
    category: MashFruitCategory.soft,
    names: {'hu': 'Csipkebogyó', 'en': 'Rosehip', 'ro': 'Măceș'},
    notes: {
      'hu':
          'Távolítsa el a kocsányt és a csészelevelet, majd az érett bogyót erősen aprítsa. A sok szilárd rész miatt sűrű cefre keletkezik; ügyeljen a keverhetőségre és a későbbi leégés veszélyére.',
      'en':
          'Remove stalks and sepals, then mill ripe hips thoroughly. The high solids content produces a dense mash; ensure it can be mixed and account for scorching risk later.',
      'ro':
          'Îndepărtați codițele și sepalele, apoi mărunțiți bine măceșele coapte. Conținutul mare de solide produce un borhot dens; asigurați amestecarea și țineți cont de riscul de ardere.',
    },
  ),
  MashFruitProfile(
    id: 'rowanberry',
    category: MashFruitCategory.pome,
    names: {'hu': 'Madárberkenye', 'en': 'Rowanberry', 'ro': 'Scoruș de munte'},
    notes: {
      'hu':
          'Teljesen érett vagy dércsípte, kocsánytalanított bogyót használjon. A kemény, pektindús termést finoman darálja, és az erjedés után ne tárolja hosszan.',
      'en':
          'Use fully ripe or frost-touched berries with stems removed. Mill the firm, pectin-rich fruit finely and avoid prolonged storage after fermentation.',
      'ro':
          'Folosiți fructe complet coapte sau atinse de brumă, fără codițe. Măcinați fin fructele tari și bogate în pectină și evitați păstrarea îndelungată după fermentare.',
    },
  ),
  MashFruitProfile(
    id: 'service_tree',
    category: MashFruitCategory.pome,
    names: {'hu': 'Házi berkenye', 'en': 'Sorb apple', 'ro': 'Scoruș domestic'},
    notes: {
      'hu':
          'Csak utóérlelt, megbarnult és puha, de nem penészes termést használjon. Válogatás után finoman darálja; a magas pektintartalom miatt a gyors kierjesztés és lepárlás fontos.',
      'en':
          'Use only bletted, browned and soft fruit that is free of mould. Sort and mill finely; high pectin makes rapid fermentation and prompt distillation important.',
      'ro':
          'Folosiți numai fructe postmaturate, brunificate și moi, fără mucegai. Sortați și măcinați fin; conținutul ridicat de pectină impune fermentare rapidă și distilare promptă.',
    },
  ),
  MashFruitProfile(
    id: 'fig',
    category: MashFruitCategory.soft,
    names: {'hu': 'Füge', 'en': 'Fig', 'ro': 'Smochină'},
    notes: {
      'hu':
          'Nagyon érett, de nem penészes fügét használjon, a sérült részeket távolítsa el. A magas cukor és a sűrű állag miatt ellenőrizze az élesztő alkoholtűrését, és akadályozza meg a felszín kiszáradását.',
      'en':
          'Use very ripe but mould-free figs and remove damaged parts. Because of high sugar and a dense texture, check yeast alcohol tolerance and prevent the surface from drying.',
      'ro':
          'Folosiți smochine foarte coapte, dar fără mucegai, și îndepărtați părțile deteriorate. Din cauza zahărului ridicat și a consistenței dense, verificați toleranța drojdiei la alcool și nu lăsați suprafața să se usuce.',
    },
  ),
];
