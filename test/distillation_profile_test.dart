import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokmester/l10n/app_localizations.dart';
import 'package:fokmester/models/distillation_cut_profile.dart';
import 'package:fokmester/models/distillation_fruit_profile.dart';
import 'package:fokmester/models/distillation_sensory_profile.dart';
import 'package:fokmester/models/mash_fruit_profile.dart';

void main() {
  test('minden cefregyümölcshöz tartozik teljes főzési profil', () {
    expect(distillationFruitProfiles.length, mashFruitProfiles.length);
    expect(
      distillationFruitProfiles.map((item) => item.fruitId).toSet(),
      mashFruitProfiles.map((item) => item.id).toSet(),
    );

    for (final profile in distillationFruitProfiles) {
      expect(profile.focusNotes.keys, containsAll(<String>['hu', 'en', 'ro']));
      expect(profile.focus('hu'), isNotEmpty);
      expect(profile.focus('en'), isNotEmpty);
      expect(profile.focus('ro'), isNotEmpty);
    }
  });

  test('minden gyümölcshöz háromnyelvű érzékszervi profil tartozik', () {
    expect(distillationSensoryProfiles.length, mashFruitProfiles.length);
    expect(
      distillationSensoryProfiles.map((item) => item.fruitId).toSet(),
      mashFruitProfiles.map((item) => item.id).toSet(),
    );

    for (final profile in distillationSensoryProfiles) {
      expect(profile.targetNotes.keys, containsAll(<String>['hu', 'en', 'ro']));
      expect(
        profile.lateRunNotes.keys,
        containsAll(<String>['hu', 'en', 'ro']),
      );
      for (final language in ['hu', 'en', 'ro']) {
        expect(profile.target(language), isNotEmpty);
        expect(profile.lateRun(language), isNotEmpty);
      }
    }
  });

  test('az új főzési útmutató minden nyelven teljes', () {
    const keys = [
      'distillation.beforeHeating',
      'distillation.method.preserve',
      'distillation.sensory.cleanSignal',
      'distillation.sensory.heartTitle',
      'distillation.sensory.heartBody',
      'distillation.sensory.lateSignal',
      'distillation.faults.title',
      'distillation.faults.solvent.body',
      'distillation.faults.vinegar.body',
      'distillation.faults.scorched.body',
      'distillation.faults.tails.body',
      'distillation.faults.neutral.body',
      'distillation.faults.musty.body',
      'distillation.laboratory.title',
      'distillation.laboratory.body',
    ];

    for (final language in ['hu', 'en', 'ro']) {
      final strings = AppLocalizations(Locale(language));
      for (final key in keys) {
        expect(strings.tr(key), isNot(key), reason: '$language: $key');
      }
    }
  });

  test('minden gyümölcshöz külön kisüsti és tornyos vágási ablak tartozik', () {
    expect(distillationCutProfiles.length, mashFruitProfiles.length);
    expect(
      distillationCutProfiles.map((item) => item.fruitId).toSet(),
      mashFruitProfiles.map((item) => item.id).toSet(),
    );

    for (final profile in distillationCutProfiles) {
      for (final cuts in [profile.pot, profile.column]) {
        expect(cuts.headsToHeart.high, greaterThan(cuts.headsToHeart.low));
        expect(cuts.heartToTails.high, greaterThan(cuts.heartToTails.low));
        expect(cuts.headsToHeart.low, greaterThan(cuts.heartToTails.high));
      }
    }
  });
}
