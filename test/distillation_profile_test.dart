import 'package:flutter_test/flutter_test.dart';
import 'package:fokmester/models/distillation_cut_profile.dart';
import 'package:fokmester/models/distillation_fruit_profile.dart';
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
