/// A descending alcohol-strength window in the running distillate.
///
/// These values are attention windows, not automatic switching thresholds.
/// Published work shows that fruit, feed alcohol, distillation speed and
/// rectification can move the actual cut point substantially. Samples must be
/// cooled/corrected to 20 °C and assessed sensorially.
class AbvCutWindow {
  final int high;
  final int low;

  const AbvCutWindow(this.high, this.low);

  String get label => '$high–$low%';
}

class DistillationMethodCuts {
  final AbvCutWindow headsToHeart;
  final AbvCutWindow heartToTails;

  const DistillationMethodCuts({
    required this.headsToHeart,
    required this.heartToTails,
  });
}

class DistillationCutProfile {
  final String fruitId;
  final DistillationMethodCuts pot;
  final DistillationMethodCuts column;

  const DistillationCutProfile({
    required this.fruitId,
    required this.pot,
    required this.column,
  });
}

const _delicatePot = DistillationMethodCuts(
  headsToHeart: AbvCutWindow(78, 73),
  heartToTails: AbvCutWindow(60, 55),
);
const _delicateColumn = DistillationMethodCuts(
  headsToHeart: AbvCutWindow(90, 84),
  heartToTails: AbvCutWindow(80, 72),
);
const _balancedPot = DistillationMethodCuts(
  headsToHeart: AbvCutWindow(78, 72),
  heartToTails: AbvCutWindow(58, 52),
);
const _balancedColumn = DistillationMethodCuts(
  headsToHeart: AbvCutWindow(90, 84),
  heartToTails: AbvCutWindow(78, 70),
);
const _latePot = DistillationMethodCuts(
  headsToHeart: AbvCutWindow(76, 70),
  heartToTails: AbvCutWindow(52, 46),
);
const _lateColumn = DistillationMethodCuts(
  headsToHeart: AbvCutWindow(88, 81),
  heartToTails: AbvCutWindow(72, 64),
);

/// Fruit-specific starting windows compiled from fruit-spirit process
/// literature and grouped by the volatility of the fruit's leading aromas.
/// The entries are intentionally explicit so every supported fruit remains
/// reviewable and testable on its own.
const distillationCutProfiles = <DistillationCutProfile>[
  DistillationCutProfile(
    fruitId: 'apple',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(78, 72),
      heartToTails: AbvCutWindow(56, 50),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(88, 82),
      heartToTails: AbvCutWindow(74, 66),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'pear',
    pot: _delicatePot,
    column: _delicateColumn,
  ),
  DistillationCutProfile(
    fruitId: 'quince',
    pot: _delicatePot,
    column: _delicateColumn,
  ),
  DistillationCutProfile(fruitId: 'medlar', pot: _latePot, column: _lateColumn),
  DistillationCutProfile(
    fruitId: 'plum',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(76, 70),
      heartToTails: AbvCutWindow(52, 48),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(88, 82),
      heartToTails: AbvCutWindow(74, 66),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'apricot',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(78, 72),
      heartToTails: AbvCutWindow(55, 50),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(90, 84),
      heartToTails: AbvCutWindow(78, 70),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'peach',
    pot: _delicatePot,
    column: _delicateColumn,
  ),
  DistillationCutProfile(
    fruitId: 'sweet_cherry',
    pot: _balancedPot,
    column: _balancedColumn,
  ),
  DistillationCutProfile(
    fruitId: 'sour_cherry',
    pot: _balancedPot,
    column: _balancedColumn,
  ),
  DistillationCutProfile(fruitId: 'sloe', pot: _latePot, column: _lateColumn),
  DistillationCutProfile(
    fruitId: 'cornelian_cherry',
    pot: _latePot,
    column: _lateColumn,
  ),
  DistillationCutProfile(
    fruitId: 'grape',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(76, 70),
      heartToTails: AbvCutWindow(55, 50),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(88, 82),
      heartToTails: AbvCutWindow(76, 68),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'strawberry',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(78, 74),
      heartToTails: AbvCutWindow(62, 56),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(90, 85),
      heartToTails: AbvCutWindow(82, 74),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'raspberry',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(80, 75),
      heartToTails: AbvCutWindow(62, 56),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(92, 86),
      heartToTails: AbvCutWindow(84, 76),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'blackberry',
    pot: _balancedPot,
    column: _balancedColumn,
  ),
  DistillationCutProfile(
    fruitId: 'blackcurrant',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(80, 75),
      heartToTails: AbvCutWindow(62, 56),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(92, 86),
      heartToTails: AbvCutWindow(84, 76),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'redcurrant',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(80, 75),
      heartToTails: AbvCutWindow(62, 56),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(92, 86),
      heartToTails: AbvCutWindow(84, 76),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'gooseberry',
    pot: _delicatePot,
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(90, 85),
      heartToTails: AbvCutWindow(82, 74),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'blueberry',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(78, 74),
      heartToTails: AbvCutWindow(60, 54),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(90, 85),
      heartToTails: AbvCutWindow(82, 74),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'elderberry',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(76, 70),
      heartToTails: AbvCutWindow(50, 45),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(88, 81),
      heartToTails: AbvCutWindow(70, 62),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'mulberry',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(78, 73),
      heartToTails: AbvCutWindow(60, 54),
    ),
    column: _delicateColumn,
  ),
  DistillationCutProfile(
    fruitId: 'rosehip',
    pot: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(76, 70),
      heartToTails: AbvCutWindow(50, 45),
    ),
    column: DistillationMethodCuts(
      headsToHeart: AbvCutWindow(88, 81),
      heartToTails: AbvCutWindow(70, 62),
    ),
  ),
  DistillationCutProfile(
    fruitId: 'rowanberry',
    pot: _latePot,
    column: _lateColumn,
  ),
  DistillationCutProfile(
    fruitId: 'service_tree',
    pot: _latePot,
    column: _lateColumn,
  ),
  DistillationCutProfile(fruitId: 'fig', pot: _latePot, column: _lateColumn),
];

DistillationCutProfile distillationCutProfileFor(String fruitId) =>
    distillationCutProfiles.firstWhere((profile) => profile.fruitId == fruitId);
