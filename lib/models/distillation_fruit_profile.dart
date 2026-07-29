enum DistillationRisk { low, medium, high }

enum AromaStrategy { delicate, balanced, late }

class DistillationFruitProfile {
  final String fruitId;
  final DistillationRisk foamingRisk;
  final DistillationRisk scorchingRisk;
  final AromaStrategy aromaStrategy;
  final bool stoneWarning;
  final bool pectinWarning;
  final Map<String, String> focusNotes;

  const DistillationFruitProfile({
    required this.fruitId,
    required this.foamingRisk,
    required this.scorchingRisk,
    required this.aromaStrategy,
    required this.focusNotes,
    this.stoneWarning = false,
    this.pectinWarning = false,
  });

  String focus(String languageCode) =>
      focusNotes[languageCode] ?? focusNotes['hu']!;
}

const distillationFruitProfiles = <DistillationFruitProfile>[
  DistillationFruitProfile(
    fruitId: 'apple',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.balanced,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'Az almacefre pektindús és könnyen ülepedik. Homogenizálja az üst gyártói előírása szerint, és ne hagyja a sűrű aljat közvetlenül leégni.',
      'en':
          'Apple mash is pectin-rich and settles readily. Homogenise it as allowed by the still manufacturer and prevent dense sediment from scorching.',
      'ro':
          'Borhotul de mere este bogat în pectină și se depune ușor. Omogenizați conform instrucțiunilor instalației și preveniți arderea sedimentului dens.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'pear',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.delicate,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A körte finom, könnyen elvesző aromáit tiszta cefréből és kíméletes elválasztással őrizze meg. A sűrű üledék miatt a leégést külön figyelje.',
      'en':
          'Protect pear’s delicate, easily lost aromas with clean mash and careful sensory cuts. Watch dense sediment closely to avoid scorching.',
      'ro':
          'Protejați aromele fine și ușor de pierdut ale perei prin borhot curat și separări senzoriale atente. Urmăriți atent sedimentul dens pentru a evita arderea.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'quince',
    foamingRisk: DistillationRisk.high,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.delicate,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A birscefre nagyon sűrű és pektindús: fokozott habzási és leégési kockázattal számoljon. Csak a berendezéshez engedélyezett keverést vagy közvetett fűtést használja.',
      'en':
          'Quince mash is very dense and pectin-rich, with increased foaming and scorching risk. Use only agitation or indirect heating approved for the still.',
      'ro':
          'Borhotul de gutui este foarte dens și bogat în pectină, cu risc sporit de spumare și ardere. Folosiți numai agitarea sau încălzirea indirectă permisă de instalație.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'medlar',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.late,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A naspoly sűrű, rostos cefréje könnyen leég. A lágy, fűszeres jegyek a főzés későbbi részén is megjelenhetnek, ezért az utópárlati átmenetet érzékszervileg figyelje.',
      'en':
          'Dense, fibrous medlar mash can scorch. Its soft spicy notes may appear later in the run, so monitor the transition to tails by smell and taste.',
      'ro':
          'Borhotul dens și fibros de moșmon se poate arde. Notele moi, condimentate pot apărea mai târziu, deci urmăriți senzorial trecerea spre cozi.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'plum',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.late,
    stoneWarning: true,
    focusNotes: {
      'hu':
          'Törött mag ne kerüljön az üstbe. A szilva telt, lekváros jegyei később is érkezhetnek, de az utópárlatos, savanykás-nehéz karaktert ne engedje a középpárlatba.',
      'en':
          'Do not charge broken stones. Rich, jammy plum notes can arrive late, but keep sour, heavy tail character out of the heart.',
      'ro':
          'Nu introduceți sâmburi sparți în cazan. Notele bogate, de magiun, pot apărea târziu, dar excludeți din inimă caracterul acru și greu al cozilor.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'apricot',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.late,
    stoneWarning: true,
    focusNotes: {
      'hu':
          'Törött magot ne főzzön. A kajszi jellegzetes lekváros vezéraromái a lepárlás vége felé dúsulhatnak, ezért a túl erős deflegmáció aromavesztést okozhat.',
      'en':
          'Do not distil broken stones. Apricot’s characteristic jammy key aromas may concentrate later, so excessive dephlegmation can reduce fruit character.',
      'ro':
          'Nu distilați sâmburi sparți. Aromele caracteristice, de gem, ale caisei se pot concentra mai târziu, iar deflegmarea excesivă poate reduce caracterul fructat.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'peach',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.delicate,
    stoneWarning: true,
    focusNotes: {
      'hu':
          'Az őszibarack illata finom és sérülékeny; törött mag ne legyen a cefrében. Kerülje a durva fűtési változásokat és a túlzott aromatisztítást.',
      'en':
          'Peach aroma is delicate; no broken stones should be present. Avoid abrupt heat changes and excessive aroma stripping.',
      'ro':
          'Aroma piersicii este delicată; borhotul nu trebuie să conțină sâmburi sparți. Evitați schimbările bruște de încălzire și epurarea excesivă a aromelor.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'sweet_cherry',
    foamingRisk: DistillationRisk.high,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.balanced,
    stoneWarning: true,
    focusNotes: {
      'hu':
          'A cseresznye habzásra hajlamos lehet; hagyjon a gépkönyv szerinti bőséges szabad teret és fokozatosan fűtsön. Törött magot ne töltsön az üstbe.',
      'en':
          'Cherry mash can foam; leave generous headspace as specified by the manual and raise heat gradually. Do not charge broken stones.',
      'ro':
          'Borhotul de cireșe poate spuma; lăsați spațiul liber generos cerut de manual și creșteți căldura treptat. Nu încărcați sâmburi sparți.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'sour_cherry',
    foamingRisk: DistillationRisk.high,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.balanced,
    stoneWarning: true,
    focusNotes: {
      'hu':
          'A meggycef­re kifejezetten felhabozhat. Csökkentett töltéssel, lassú felfűtéssel és folyamatos felügyelettel dolgozzon; habzásgátlót csak engedély és címke szerint használjon.',
      'en':
          'Sour-cherry mash can foam strongly. Use a reduced charge, gradual heat-up and continuous supervision; use antifoam only when approved and exactly as labelled.',
      'ro':
          'Borhotul de vișine poate spuma puternic. Folosiți o încărcare redusă, încălzire treptată și supraveghere continuă; antispumant numai dacă este permis și conform etichetei.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'sloe',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.late,
    stoneWarning: true,
    focusNotes: {
      'hu':
          'A kökénycef­re sűrű és magban gazdag; törött mag ne kerüljön az üstbe. A fanyar, későn megjelenő jegyeket ne keverje össze az utópárlat nehéz karakterével.',
      'en':
          'Sloe mash is dense and stone-rich; exclude broken stones. Do not confuse late astringent fruit notes with heavy tail character.',
      'ro':
          'Borhotul de porumbar este dens și bogat în sâmburi; excludeți sâmburii sparți. Nu confundați notele astringente târzii cu caracterul greu al cozilor.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'cornelian_cherry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.late,
    stoneWarning: true,
    focusNotes: {
      'hu':
          'A som sűrű húsa és nagy magja miatt figyeljen a leégésre, a mag épségére és a szabad gőzútra. A késői fanyar jegyeknél gyakran kóstoljon kis mintát.',
      'en':
          'Cornelian cherry’s dense flesh and large stone require attention to scorching, intact stones and an unobstructed vapour path. Sample frequently as late tart notes appear.',
      'ro':
          'Pulpa densă și sâmburele mare ale coarnelor cer atenție la ardere, integritatea sâmburilor și calea liberă a vaporilor. Degustați probe mici când apar notele acre târzii.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'grape',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.balanced,
    focusNotes: {
      'hu':
          'A szőlőhéj és az apró szilárd részek leülepedhetnek. Ez az útmutató friss szőlőcefrére vonatkozik; a törköly eltérő alapanyag és technológia.',
      'en':
          'Grape skins and fine solids may settle. This guide covers fresh grape mash; grape marc is a different raw material and process.',
      'ro':
          'Cojile și particulele fine de strugure se pot depune. Ghidul se referă la borhot proaspăt de struguri; tescovina este altă materie primă și alt proces.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'strawberry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.delicate,
    focusNotes: {
      'hu':
          'A szamóca illata nagyon könnyen elvész. Tiszta, frissen kierjedt cefrével dolgozzon, és ne alkalmazzon a szükségesnél erősebb aromatisztítást.',
      'en':
          'Strawberry aroma is easily lost. Work with clean, freshly fermented mash and avoid more aroma purification than necessary.',
      'ro':
          'Aroma căpșunii se pierde ușor. Lucrați cu borhot curat, proaspăt fermentat, și evitați purificarea aromelor peste nivelul necesar.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'raspberry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.delicate,
    focusNotes: {
      'hu':
          'A málna illékony aromája érzékeny a hosszú tárolásra és a túlzott deflegmációra. Rövid időn belül, tiszta berendezéssel dolgozzon.',
      'en':
          'Raspberry’s volatile aroma is sensitive to long storage and excessive dephlegmation. Distil promptly with thoroughly clean equipment.',
      'ro':
          'Aroma volatilă a zmeurei este sensibilă la păstrare îndelungată și deflegmare excesivă. Distilați prompt într-o instalație perfect curată.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'blackberry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.medium,
    aromaStrategy: AromaStrategy.balanced,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A szeder apró magjai és héjrészei leülepedhetnek, ezért óvja a cefrét a leégéstől. A tiszta bogyós aromát a nehéz, földes utópárlati jegyek előtt válassza le.',
      'en':
          'Blackberry seeds and skins may settle, so protect the mash from scorching. Separate the clean berry character before heavy, earthy tail notes dominate.',
      'ro':
          'Semințele și cojile de mură se pot depune, deci protejați borhotul de ardere. Separați caracterul curat de fruct înainte să domine notele grele, pământii, de cozi.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'blackcurrant',
    foamingRisk: DistillationRisk.high,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.delicate,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A fekete ribizli pektindús, sűrű és intenzív illatú. Nagyobb szabad térrel, leégés elleni védelemmel és visszafogott aromatisztítással dolgozzon.',
      'en':
          'Blackcurrant mash is pectin-rich, dense and intensely aromatic. Allow extra headspace, protect against scorching and keep aroma purification restrained.',
      'ro':
          'Borhotul de coacăze negre este dens, bogat în pectină și foarte aromat. Lăsați spațiu liber suplimentar, preveniți arderea și limitați epurarea aromelor.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'redcurrant',
    foamingRisk: DistillationRisk.high,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.delicate,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A piros ribizli savas, pektindús cefréje habozhat és leéghet. Fokozatos fűtéssel és a berendezés szerinti keveréssel őrizze meg könnyű bogyós aromáját.',
      'en':
          'Acidic, pectin-rich redcurrant mash may foam and scorch. Use gradual heat and manufacturer-approved agitation to retain its light berry aroma.',
      'ro':
          'Borhotul acid și bogat în pectină de coacăze roșii poate spuma și se poate arde. Încălziți treptat și agitați numai conform instalației pentru a păstra aroma fină.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'gooseberry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.delicate,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'Az egres sűrű, savas és pektindús lehet. Ügyeljen a leégésre, és a friss, zöldes gyümölcsjegyek megőrzéséhez kerülje a túl erős deflegmációt.',
      'en':
          'Gooseberry mash can be dense, acidic and pectin-rich. Prevent scorching and avoid excessive dephlegmation to retain fresh green fruit notes.',
      'ro':
          'Borhotul de agrișe poate fi dens, acid și bogat în pectină. Preveniți arderea și evitați deflegmarea excesivă pentru a păstra notele verzi, proaspete.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'blueberry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.delicate,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'Az áfonya héja és apró magjai sűrű üledéket képezhetnek. Kímélje a leégéstől, a finom illat miatt pedig gyakori kis mintákkal kövesse az elválasztást.',
      'en':
          'Blueberry skins and fine seeds can form dense sediment. Prevent scorching and use frequent small samples to follow cuts around its delicate aroma.',
      'ro':
          'Cojile și semințele fine de afine pot forma sediment dens. Preveniți arderea și urmăriți separările prin probe mici și dese pentru aroma delicată.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'elderberry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.late,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'Csak kocsány-, levél- és zöldbogyó-mentes bodzacefrét főzzön. A sűrű héj- és maganyag miatt a leégésre, a késői nehéz növényi jegyekre külön figyeljen.',
      'en':
          'Distil only elderberry mash free from stems, leaves and green berries. Dense skins and seeds increase scorching risk and can bring late heavy vegetal notes.',
      'ro':
          'Distilați numai borhot de soc fără codițe, frunze și boabe verzi. Cojile și semințele dense cresc riscul de ardere și pot aduce note vegetale grele spre final.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'mulberry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.delicate,
    focusNotes: {
      'hu':
          'Az eperfa termésének lágy cefréje könnyen ülepszik és aromája visszafogott. Leégés elleni védelem mellett kíméletes aromakoncentrálást válasszon.',
      'en':
          'Soft mulberry mash settles readily and has restrained aroma. Protect it from scorching and use gentle aroma concentration.',
      'ro':
          'Borhotul moale de dude se depune ușor și are aromă discretă. Protejați-l de ardere și concentrați aroma cu blândețe.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'rosehip',
    foamingRisk: DistillationRisk.high,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.late,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A csipkebogyócefre rendkívül sűrű és szilárdanyag-dús. Csökkentett töltés, a gépkönyv szerinti keverés vagy közvetett fűtés nélkül ne kezdje meg a lepárlást.',
      'en':
          'Rosehip mash is exceptionally dense and high in solids. Do not start without a reduced charge and manufacturer-approved agitation or indirect heating.',
      'ro':
          'Borhotul de măceșe este foarte dens și bogat în solide. Nu începeți fără încărcare redusă și agitare aprobată sau încălzire indirectă.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'rowanberry',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.late,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A madárberkenye pektindús, fanyar és sűrű lehet. A leégés ellen védekezzen, és a későn érkező fűszeres-fanyar jegyeknél sűrűn ellenőrizze az utópárlati átmenetet.',
      'en':
          'Rowanberry mash may be pectin-rich, tart and dense. Prevent scorching and check the tail transition frequently as late spicy-tart notes appear.',
      'ro':
          'Borhotul de scoruş poate fi dens, astringent și bogat în pectină. Preveniți arderea și verificați des trecerea spre cozi când apar notele condimentate târzii.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'service_tree',
    foamingRisk: DistillationRisk.medium,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.late,
    pectinWarning: true,
    focusNotes: {
      'hu':
          'A házi berkenye utóérlelt, pektindús cefréje sűrűn ülepedik. A leégés elleni védelem mellett különítse el a kellemes fűszeres jegyeket a nehéz utópárlati karaktertől.',
      'en':
          'Bletted, pectin-rich sorb-apple mash forms dense sediment. Prevent scorching and distinguish pleasant spicy notes from heavy tail character.',
      'ro':
          'Borhotul postmaturat și bogat în pectină de scoruş domestic formează sediment dens. Preveniți arderea și separați notele condimentate plăcute de caracterul greu al cozilor.',
    },
  ),
  DistillationFruitProfile(
    fruitId: 'fig',
    foamingRisk: DistillationRisk.high,
    scorchingRisk: DistillationRisk.high,
    aromaStrategy: AromaStrategy.late,
    focusNotes: {
      'hu':
          'A füge magas szárazanyag-tartalmú, sűrű cefréje habozhat és könnyen leég. Csökkentett töltéssel, fokozatos fűtéssel és jóváhagyott keveréssel dolgozzon.',
      'en':
          'Fig mash is dense and high in solids, so it may foam and scorch. Use a reduced charge, gradual heat-up and approved agitation.',
      'ro':
          'Borhotul de smochine este dens și bogat în solide, deci poate spuma și se poate arde. Folosiți încărcare redusă, încălzire treptată și agitare aprobată.',
    },
  ),
];

DistillationFruitProfile distillationProfileFor(String fruitId) =>
    distillationFruitProfiles.firstWhere(
      (profile) => profile.fruitId == fruitId,
    );
