class DistillationSensoryProfile {
  final String fruitId;
  final Map<String, String> targetNotes;
  final Map<String, String> lateRunNotes;

  const DistillationSensoryProfile({
    required this.fruitId,
    required this.targetNotes,
    required this.lateRunNotes,
  });

  String target(String languageCode) =>
      targetNotes[languageCode] ?? targetNotes['hu']!;

  String lateRun(String languageCode) =>
      lateRunNotes[languageCode] ?? lateRunNotes['hu']!;
}

const distillationSensoryProfiles = <DistillationSensoryProfile>[
  DistillationSensoryProfile(
    fruitId: 'apple',
    targetNotes: {
      'hu':
          'Tiszta, friss vagy érett alma, finom héjas és enyhén virágos-cideres karakter.',
      'en':
          'Clean fresh or ripe apple with subtle peel and lightly floral, cider-like character.',
      'ro':
          'Măr curat, proaspăt sau copt, cu note fine de coajă și caracter ușor floral, de cidru.',
    },
    lateRunNotes: {
      'hu':
          'Az enyhe héjas-fűszeres jegy még értékes lehet. A tompa főtt alma, savanykás, nehéz vagy olajos érzet már az utópárlat felé mutat.',
      'en':
          'A light peel-spice note may still be useful. Dull cooked apple, sour, heavy or oily character points toward tails.',
      'ro':
          'O notă fină de coajă și condiment poate fi încă utilă. Mărul fiert tern, caracterul acru, greu sau uleios indică cozile.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'pear',
    targetNotes: {
      'hu':
          'Érett, lédús körte, könnyű virágos és mézes jegyekkel; a karakter legyen tiszta, ne parfümösen oldószeres.',
      'en':
          'Ripe juicy pear with light floral and honeyed notes; clean rather than perfumed or solvent-like.',
      'ro':
          'Pară coaptă și suculentă, cu note florale și de miere; curată, fără caracter parfumat de solvent.',
    },
    lateRunNotes: {
      'hu':
          'A körtearoma egy része későn is érkezhet, ezért kis mintákat hasonlítson össze. A főtt, földes, fojtott vagy olajos jelleg már ne kerüljön a középpárlatba.',
      'en':
          'Some pear aroma can arrive late, so compare small consecutive samples. Exclude cooked, earthy, muted or oily character.',
      'ro':
          'O parte din aroma de pară poate apărea târziu; comparați probe mici consecutive. Excludeți caracterul fiert, pământiu, închis sau uleios.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'quince',
    targetNotes: {
      'hu':
          'Határozott birs, citrusos-virágos, fűszeres és enyhén mézes karakterrel.',
      'en':
          'Distinct quince with citrus-floral, spicy and lightly honeyed character.',
      'ro':
          'Gutui bine definită, cu caracter citric-floral, condimentat și ușor de miere.',
    },
    lateRunNotes: {
      'hu':
          'A fűszeres, kandírozott birsjelleg későn is megmaradhat. A kesernyés, főtt, nehéz vagy olajos jegyek megjelenésekor már utópárlatra gyanakodjon.',
      'en':
          'Spicy, candied-quince character may remain late. Bitter, cooked, heavy or oily notes indicate the approach of tails.',
      'ro':
          'Caracterul condimentat, de gutuie confiată, poate persista târziu. Notele amare, fierte, grele sau uleioase indică apropierea cozilor.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'medlar',
    targetNotes: {
      'hu':
          'Lágy, érett naspolya, aszalt gyümölcsös, mézes és finoman fűszeres karakterrel.',
      'en':
          'Soft ripe medlar with dried-fruit, honeyed and gently spicy character.',
      'ro':
          'Moșmon copt și catifelat, cu caracter de fruct uscat, miere și condimente fine.',
    },
    lateRunNotes: {
      'hu':
          'Az aszalt gyümölcsös-fűszeres jegyek későn is értékesek lehetnek. A dohos, földes, főtt vagy olajos irány már utópárlati jel.',
      'en':
          'Dried-fruit and spicy notes may remain valuable late. Musty, earthy, cooked or oily character signals tails.',
      'ro':
          'Notele de fruct uscat și condimente pot rămâne valoroase târziu. Caracterul mucegăit, pământiu, fiert sau uleios indică cozile.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'plum',
    targetNotes: {
      'hu':
          'Érett szilva, telt lekváros gyümölcsösség és finom fűszeresség, tiszta háttérrel.',
      'en':
          'Ripe plum, full jammy fruit and gentle spice on a clean background.',
      'ro':
          'Prună coaptă, fruct plin de magiun și condimente fine, pe un fundal curat.',
    },
    lateRunNotes: {
      'hu':
          'A telt lekváros és fűszeres szilvajegy később is érkezhet. A savanykás, nehéz, főtt vagy olajos karakter már rontja a középpárlat tisztaságát.',
      'en':
          'Full jammy and spicy plum notes can arrive late. Sour, heavy, cooked or oily character reduces heart quality.',
      'ro':
          'Notele pline, de magiun și condimente, pot apărea târziu. Caracterul acru, greu, fiert sau uleios reduce calitatea inimii.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'apricot',
    targetNotes: {
      'hu':
          'Érett kajszi, telt lekváros, virágos és enyhén fűszeres vezéraromával.',
      'en':
          'Ripe apricot with full jammy, floral and lightly spicy leading aroma.',
      'ro':
          'Caisă coaptă, cu aromă dominantă plină, de gem, florală și ușor condimentată.',
    },
    lateRunNotes: {
      'hu':
          'A jellegzetes lekváros kajsziaroma a főzés későbbi részében is erősödhet. A savanykás, tompa főtt vagy olajos jegyeket már ne tartsa meg.',
      'en':
          'Characteristic jammy apricot can strengthen later in the run. Do not retain sour, dull cooked or oily notes.',
      'ro':
          'Aroma caracteristică de gem de caise se poate intensifica spre final. Nu păstrați notele acre, fierte terne sau uleioase.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'peach',
    targetNotes: {
      'hu':
          'Friss, érett őszibarack, könnyű virágos és lédús gyümölcsös karakterrel.',
      'en': 'Fresh ripe peach with light floral and juicy fruit character.',
      'ro':
          'Piersică proaspătă și coaptă, cu caracter floral fin și fructat suculent.',
    },
    lateRunNotes: {
      'hu':
          'A finom barackillat gyorsan tompulhat. A főtt, zöldes-növényi, fojtott vagy olajos jelleg már az utópárlat közeledését mutatja.',
      'en':
          'Delicate peach aroma can fade quickly. Cooked, green-vegetal, muted or oily character points toward tails.',
      'ro':
          'Aroma delicată de piersică se poate estompa rapid. Caracterul fiert, verde-vegetal, închis sau uleios indică apropierea cozilor.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'sweet_cherry',
    targetNotes: {
      'hu':
          'Érett cseresznye, tiszta piros gyümölcsös, enyhén virágos és finoman fűszeres karakterrel.',
      'en':
          'Ripe cherry with clean red-fruit, lightly floral and gently spicy character.',
      'ro':
          'Cireașă coaptă, cu caracter curat de fruct roșu, ușor floral și fin condimentat.',
    },
    lateRunNotes: {
      'hu':
          'A mélyebb cseresznyés-fűszeres jegy még értékes lehet. A kesernyés magjelleg, főtt, földes vagy olajos karakter már ne kerüljön a középpárlatba.',
      'en':
          'Deeper cherry-spice can still be useful. Exclude bitter kernel-like, cooked, earthy or oily character.',
      'ro':
          'Nota mai profundă de cireașă și condiment poate fi încă utilă. Excludeți caracterul amar de sâmbure, fiert, pământiu sau uleios.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'sour_cherry',
    targetNotes: {
      'hu':
          'Tiszta, élénk meggy, friss savanykás piros gyümölcs és visszafogott fűszeresség.',
      'en':
          'Clean vivid sour cherry with fresh tart red fruit and restrained spice.',
      'ro':
          'Vișină curată și vie, cu fruct roșu acrișor proaspăt și condimente discrete.',
    },
    lateRunNotes: {
      'hu':
          'A mélyebb meggyes karakter későn is megmaradhat. Ha ezt főtt-kompótos, kesernyés, nehéz vagy olajos jegy váltja fel, kezdődik az utópárlati átmenet.',
      'en':
          'Deeper sour-cherry character may remain late. Cooked-compote, bitter, heavy or oily notes mark the tail transition.',
      'ro':
          'Caracterul profund de vișină poate persista târziu. Notele de compot fiert, amare, grele sau uleioase marchează trecerea spre cozi.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'sloe',
    targetNotes: {
      'hu':
          'Fanyar, sötét vadgyümölcsös, szilvás-bogyós és finoman fűszeres karakter.',
      'en': 'Tart dark wild-fruit character with plum, berry and gentle spice.',
      'ro':
          'Caracter astringent de fruct sălbatic închis, cu prună, fructe de pădure și condimente fine.',
    },
    lateRunNotes: {
      'hu':
          'A fanyar-fűszeres gyümölcsjelleg későn is természetes lehet. A durván keserű, földes, főtt vagy olajos irány már utópárlati jel.',
      'en':
          'Tart spicy fruit can remain natural late. Harsh bitterness, earthy, cooked or oily character signals tails.',
      'ro':
          'Fructul astringent și condimentat poate rămâne natural spre final. Amăreala dură, caracterul pământiu, fiert sau uleios indică cozile.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'cornelian_cherry',
    targetNotes: {
      'hu':
          'Élénk, fanyar som, tiszta piros bogyós és finoman fűszeres karakterrel.',
      'en':
          'Vivid tart cornelian cherry with clean red-berry and lightly spicy character.',
      'ro':
          'Coarne vii și astringente, cu caracter curat de fruct roșu și condimente fine.',
    },
    lateRunNotes: {
      'hu':
          'A savas-fűszeres somjelleg későn is megmaradhat. A nyersen keserű, földes, főtt vagy olajos érzet már utópárlatra utal.',
      'en':
          'Tart spicy cornelian-cherry character may persist late. Raw bitterness, earthiness, cooked or oily feel indicates tails.',
      'ro':
          'Caracterul acrișor și condimentat poate persista târziu. Amăreala crudă, notele pământii, fierte sau uleioase indică cozile.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'grape',
    targetNotes: {
      'hu':
          'Tiszta friss szőlő, könnyű virágosság és gyümölcsös észteresség, idegen törkölyös jelleg nélkül.',
      'en':
          'Clean fresh grape with light floral and fruity ester character, without foreign marc-like notes.',
      'ro':
          'Strugure proaspăt și curat, cu note florale fine și esteri fructați, fără caracter străin de tescovină.',
    },
    lateRunNotes: {
      'hu':
          'Enyhe fűszeres-szőlős jegy még hasznos lehet. A nehéz héjas, növényi, zsíros vagy olajos karakter már az utópárlat felé mutat.',
      'en':
          'A light spicy-grape note may remain useful. Heavy skin-like, vegetal, fatty or oily character points toward tails.',
      'ro':
          'O notă ușoară condimentată de strugure poate fi încă utilă. Caracterul greu de coajă, vegetal, gras sau uleios indică cozile.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'strawberry',
    targetNotes: {
      'hu':
          'Friss szamóca, könnyű virágos, édes érzetű, de nem cukros vagy lekváros illat.',
      'en':
          'Fresh strawberry with light floral, sweet-smelling character without sugary or cooked-jam aroma.',
      'ro':
          'Căpșună proaspătă, ușor florală și dulce la miros, fără aromă zaharoasă sau de gem fiert.',
    },
    lateRunNotes: {
      'hu':
          'A szamóca finom illata hamar elfáradhat. A főtt lekváros, erjedt, földes vagy olajos jegyek már ne kerüljenek a középpárlatba.',
      'en':
          'Delicate strawberry aroma can tire quickly. Exclude cooked-jam, fermented, earthy or oily notes.',
      'ro':
          'Aroma delicată de căpșună poate obosi repede. Excludeți notele de gem fiert, fermentate, pământii sau uleioase.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'raspberry',
    targetNotes: {
      'hu':
          'Élénk friss málna, könnyű virágos és tiszta piros bogyós karakterrel.',
      'en':
          'Vivid fresh raspberry with light floral and clean red-berry character.',
      'ro':
          'Zmeură proaspătă și vie, cu note florale fine și caracter curat de fruct roșu.',
    },
    lateRunNotes: {
      'hu':
          'A málnajelleg gyorsan halványulhat. A magos, leveles, földes, erjedt vagy olajos irány az utópárlat közeledését jelzi.',
      'en':
          'Raspberry character can fade quickly. Seedy, leafy, earthy, fermented or oily character signals approaching tails.',
      'ro':
          'Caracterul de zmeură se poate estompa rapid. Notele de semințe, frunză, pământ, fermentat sau uleios indică apropierea cozilor.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'blackberry',
    targetNotes: {
      'hu':
          'Érett szeder, telt sötét bogyós, enyhén lekváros és finoman fűszeres karakter.',
      'en':
          'Ripe blackberry with full dark-berry, lightly jammy and gently spicy character.',
      'ro':
          'Mură coaptă, cu caracter plin de fruct negru, ușor de gem și fin condimentat.',
    },
    lateRunNotes: {
      'hu':
          'A mély sötét gyümölcsösség későn is értékes lehet. A sáros-földes, főtt, nehéz vagy olajos jelleg már az utópárlatba tartozik.',
      'en':
          'Deep dark-fruit character can remain useful late. Muddy-earthy, cooked, heavy or oily character belongs to tails.',
      'ro':
          'Caracterul profund de fruct negru poate rămâne valoros târziu. Notele noroioase-pământii, fierte, grele sau uleioase aparțin cozilor.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'blackcurrant',
    targetNotes: {
      'hu':
          'Intenzív fekete ribizli, telt sötét bogyós, friss zöldes és finoman fűszeres jegyekkel.',
      'en':
          'Intense blackcurrant with full dark-berry, fresh green and gently spicy notes.',
      'ro':
          'Coacăză neagră intensă, cu fruct negru plin, note verzi proaspete și condimente fine.',
    },
    lateRunNotes: {
      'hu':
          'A friss zöldes ribizlijegy önmagában még nem hiba. A durván leveles, kénes, földes, főtt vagy olajos karakter már utópárlati vagy cefrehiba lehet.',
      'en':
          'A fresh green currant note is not automatically a fault. Harsh leafy, sulphury, earthy, cooked or oily character can indicate tails or a mash defect.',
      'ro':
          'O notă verde proaspătă de coacăză nu este automat defect. Caracterul puternic de frunză, sulf, pământ, fiert sau uleios poate indica cozi ori defect de borhot.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'redcurrant',
    targetNotes: {
      'hu':
          'Friss, élénk piros ribizli, savas piros bogyós és könnyű virágos karakterrel.',
      'en':
          'Fresh vivid redcurrant with tart red-berry and light floral character.',
      'ro':
          'Coacăză roșie proaspătă și vie, cu fruct roșu acrișor și caracter floral fin.',
    },
    lateRunNotes: {
      'hu':
          'A könnyű savas-bogyós jelleg hamar elvékonyodhat. A főtt, durván leveles, földes vagy olajos érzet már utópárlati átmenet.',
      'en':
          'Light tart-berry character can thin quickly. Cooked, harsh leafy, earthy or oily feel marks the tail transition.',
      'ro':
          'Caracterul ușor acrișor de fruct se poate subția repede. Notele fierte, puternic vegetale, pământii sau uleioase marchează trecerea spre cozi.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'gooseberry',
    targetNotes: {
      'hu':
          'Friss egres, élénk savas, zöld gyümölcsös és enyhén virágos karakterrel.',
      'en':
          'Fresh gooseberry with vivid tart, green-fruit and lightly floral character.',
      'ro':
          'Agrișă proaspătă, cu caracter viu acrișor, de fruct verde și ușor floral.',
    },
    lateRunNotes: {
      'hu':
          'A friss zöld gyümölcsjegy lehet fajtajelleg. A nyers leveles, főtt, keserű, földes vagy olajos karakter már nem kívánatos.',
      'en':
          'Fresh green-fruit character can be varietal. Raw leafy, cooked, bitter, earthy or oily notes are undesirable.',
      'ro':
          'Caracterul proaspăt de fruct verde poate fi specific. Notele crude de frunză, fierte, amare, pământii sau uleioase sunt nedorite.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'blueberry',
    targetNotes: {
      'hu':
          'Tiszta áfonya, finom erdei bogyós, enyhén virágos és visszafogott fűszeres karakterrel.',
      'en':
          'Clean blueberry with delicate forest-berry, lightly floral and restrained spicy character.',
      'ro':
          'Afină curată, cu fruct fin de pădure, note ușor florale și condimente discrete.',
    },
    lateRunNotes: {
      'hu':
          'A finom erdei gyümölcsösség hamar átfordulhat tompa irányba. A sáros, földes, főtt vagy olajos jegy már utópárlati jel.',
      'en':
          'Delicate forest-fruit character can turn dull quickly. Muddy, earthy, cooked or oily notes signal tails.',
      'ro':
          'Caracterul fin de fruct de pădure poate deveni repede tern. Notele noroioase, pământii, fierte sau uleioase indică cozile.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'elderberry',
    targetNotes: {
      'hu':
          'Érett bodzabogyó, telt sötét gyümölcsös, enyhén virágos és fűszeres karakterrel.',
      'en':
          'Ripe elderberry with full dark-fruit, lightly floral and spicy character.',
      'ro':
          'Boabe coapte de soc, cu caracter plin de fruct negru, ușor floral și condimentat.',
    },
    lateRunNotes: {
      'hu':
          'A mély fűszeres-bogyós jegy még értékes lehet. A kocsányos, durván növényi, keserű, főtt vagy olajos jelleg már nem tartozik a tiszta középpárlatba.',
      'en':
          'Deep spicy-berry notes can remain useful. Stemmy, harsh vegetal, bitter, cooked or oily character does not belong in a clean heart.',
      'ro':
          'Notele profunde de fruct și condimente pot rămâne utile. Caracterul de codiță, vegetal dur, amar, fiert sau uleios nu aparține unei inimi curate.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'mulberry',
    targetNotes: {
      'hu':
          'Érett eperfa-termés, lágy édes érzetű gyümölcsösség, enyhe mézes és virágos jegyekkel.',
      'en':
          'Ripe mulberry with soft sweet-smelling fruit and light honeyed, floral notes.',
      'ro':
          'Dudă coaptă, cu fruct catifelat și dulce la miros, note fine de miere și flori.',
    },
    lateRunNotes: {
      'hu':
          'A visszafogott mézes gyümölcsjelleg könnyen eltűnik. A lapos, főtt, erjedt, földes vagy olajos karakter már utópárlati vagy cefrehibás irány.',
      'en':
          'Restrained honeyed fruit can disappear easily. Flat, cooked, fermented, earthy or oily character suggests tails or a mash fault.',
      'ro':
          'Caracterul discret de fruct și miere poate dispărea ușor. Notele plate, fierte, fermentate, pământii sau uleioase indică cozi ori defect de borhot.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'rosehip',
    targetNotes: {
      'hu':
          'Érett csipkebogyó, savas piros gyümölcsös, teás, mézes és finoman fűszeres karakterrel.',
      'en':
          'Ripe rosehip with tart red-fruit, tea-like, honeyed and gently spicy character.',
      'ro':
          'Măceș copt, cu fruct roșu acrișor, note de ceai, miere și condimente fine.',
    },
    lateRunNotes: {
      'hu':
          'A teás-fűszeres jegy későn is fajtajelleg lehet. A durván keserű, növényi, főtt vagy olajos irány már utópárlati jel.',
      'en':
          'Tea-like spicy notes may remain varietal late. Harsh bitterness, vegetal, cooked or oily character signals tails.',
      'ro':
          'Notele de ceai și condimente pot rămâne specifice târziu. Amăreala dură, caracterul vegetal, fiert sau uleios indică cozile.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'rowanberry',
    targetNotes: {
      'hu':
          'Fanyar madárberkenye, tiszta vadgyümölcsös, teás és finoman fűszeres karakterrel.',
      'en':
          'Tart rowanberry with clean wild-fruit, tea-like and gently spicy character.',
      'ro':
          'Scoruș astringent, cu caracter curat de fruct sălbatic, note de ceai și condimente fine.',
    },
    lateRunNotes: {
      'hu':
          'A fanyar-fűszeres karakter későn is természetes lehet. A durva keserűség, főtt, növényi, földes vagy olajos jelleg már utópárlati irány.',
      'en':
          'Tart spicy character can remain natural late. Harsh bitterness, cooked, vegetal, earthy or oily notes indicate tails.',
      'ro':
          'Caracterul astringent și condimentat poate rămâne natural târziu. Amăreala dură, notele fierte, vegetale, pământii sau uleioase indică cozile.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'service_tree',
    targetNotes: {
      'hu':
          'Utóérlelt házi berkenye, érett aszalt gyümölcsös, mézes és fűszeres karakterrel.',
      'en':
          'Bletted service-tree fruit with ripe dried-fruit, honeyed and spicy character.',
      'ro':
          'Fruct postmaturat de scoruş domestic, cu caracter copt de fruct uscat, miere și condimente.',
    },
    lateRunNotes: {
      'hu':
          'Az aszalt gyümölcsös-fűszeres jegy későn is értékes lehet. A dohos, túl főtt, durván keserű vagy olajos karakter már ne kerüljön a középpárlatba.',
      'en':
          'Dried-fruit and spicy notes can remain valuable late. Exclude musty, overcooked, harsh bitter or oily character.',
      'ro':
          'Notele de fruct uscat și condimente pot rămâne valoroase târziu. Excludeți caracterul mucegăit, prea fiert, puternic amar sau uleios.',
    },
  ),
  DistillationSensoryProfile(
    fruitId: 'fig',
    targetNotes: {
      'hu':
          'Érett füge, mézes, aszalt gyümölcsös és enyhén fűszeres, telt karakterrel.',
      'en':
          'Ripe fig with full honeyed, dried-fruit and lightly spicy character.',
      'ro':
          'Smochină coaptă, cu caracter plin de miere, fruct uscat și condimente fine.',
    },
    lateRunNotes: {
      'hu':
          'A mézes-aszalt gyümölcsös jelleg későn is megmaradhat. A karamellizáltan égett, savanykás, erjedt vagy olajos karakter már hiba vagy utópárlati jel.',
      'en':
          'Honeyed dried-fruit character may remain late. Burnt-caramel, sour, fermented or oily character indicates a fault or tails.',
      'ro':
          'Caracterul de miere și fruct uscat poate persista târziu. Notele de caramel ars, acre, fermentate sau uleioase indică defect ori cozi.',
    },
  ),
];

DistillationSensoryProfile distillationSensoryProfileFor(String fruitId) =>
    distillationSensoryProfiles.firstWhere(
      (profile) => profile.fruitId == fruitId,
    );
