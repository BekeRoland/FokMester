import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/distillation_cut_profile.dart';
import '../models/distillation_fruit_profile.dart';
import '../models/distillation_sensory_profile.dart';
import '../models/mash_fruit_profile.dart';
import '../utils/number_parser.dart';
import '../widgets/input_field.dart';

enum DistillationMethod { pot, column }

enum _PotRun { stripping, spirit }

class DistillationScreen extends StatefulWidget {
  final MashFruitProfile? initialFruit;
  final double? initialMashKg;

  const DistillationScreen({super.key, this.initialFruit, this.initialMashKg});

  @override
  State<DistillationScreen> createState() => _DistillationScreenState();
}

class _DistillationScreenState extends State<DistillationScreen> {
  late MashFruitProfile selectedFruit;
  DistillationMethod method = DistillationMethod.pot;
  _PotRun run = _PotRun.stripping;
  final mashVolume = TextEditingController();
  final mashStrength = TextEditingController();
  final lowWinesVolume = TextEditingController();
  final lowWinesStrength = TextEditingController();

  @override
  void dispose() {
    for (final field in [
      mashVolume,
      mashStrength,
      lowWinesVolume,
      lowWinesStrength,
    ]) {
      field.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedFruit = widget.initialFruit ?? mashFruitProfiles.first;
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final profile = distillationProfileFor(selectedFruit.id);
    final cutProfile = distillationCutProfileFor(selectedFruit.id);
    final sensoryProfile = distillationSensoryProfileFor(selectedFruit.id);
    final stripping =
        method == DistillationMethod.pot && run == _PotRun.stripping;
    final spirit = method == DistillationMethod.pot && run == _PotRun.spirit;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          strings.tr('distillation.title'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 6),
        Text(strings.tr('distillation.subtitle')),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<MashFruitProfile>(
                  initialValue: selectedFruit,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: strings.tr('mash.fruit'),
                    prefixIcon: const Icon(Icons.eco_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  items: mashFruitProfiles
                      .map(
                        (fruit) => DropdownMenuItem(
                          value: fruit,
                          child: Text(fruit.name(languageCode)),
                        ),
                      )
                      .toList(),
                  onChanged: (fruit) {
                    if (fruit != null) setState(() => selectedFruit = fruit);
                  },
                ),
                if (widget.initialMashKg != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.link_rounded, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          strings
                              .tr('distillation.fromMash')
                              .replaceFirst(
                                '{value}',
                                _number(widget.initialMashKg!),
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 18),
                Text(
                  strings.tr('distillation.method'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<DistillationMethod>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: DistillationMethod.pot,
                      icon: const Icon(Icons.local_fire_department_outlined),
                      label: Text(strings.tr('distillation.method.pot')),
                    ),
                    ButtonSegment(
                      value: DistillationMethod.column,
                      icon: const Icon(Icons.view_column_outlined),
                      label: Text(strings.tr('distillation.method.column')),
                    ),
                  ],
                  selected: {method},
                  onSelectionChanged: (value) =>
                      setState(() => method = value.first),
                ),
                if (method == DistillationMethod.pot) ...[
                  const SizedBox(height: 20),
                  DropdownButtonFormField<_PotRun>(
                    initialValue: run,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: strings.tr('run.stage'),
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      for (final stage in _PotRun.values)
                        DropdownMenuItem(
                          value: stage,
                          child: Text(strings.tr('run.${stage.name}')),
                        ),
                    ],
                    onChanged: (stage) {
                      if (stage != null) setState(() => run = stage);
                    },
                  ),
                  const SizedBox(height: 16),
                  _YieldEstimate(
                    stripping: stripping,
                    volume: stripping ? mashVolume : lowWinesVolume,
                    strength: stripping ? mashStrength : lowWinesStrength,
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (!spirit) ...[
          _FruitCard(
            fruitName: selectedFruit.name(languageCode),
            profile: profile,
            strings: strings,
          ),
          const SizedBox(height: 12),
          _RiskCard(profile: profile, strings: strings),
          const SizedBox(height: 12),
        ],
        if (!stripping) ...[
          _MethodCard(
            method: method,
            profile: profile,
            sensoryProfile: sensoryProfile,
            fruitName: selectedFruit.name(languageCode),
            strings: strings,
          ),
          const SizedBox(height: 12),
          _CutWindowCard(
            method: method,
            cuts: method == DistillationMethod.pot
                ? cutProfile.pot
                : cutProfile.column,
            sensoryProfile: sensoryProfile,
            languageCode: languageCode,
            strings: strings,
          ),
          const SizedBox(height: 12),
          _FaultGuide(strings: strings),
          const SizedBox(height: 12),
        ],
        _LaboratorySafetyCard(strings: strings),
        const SizedBox(height: 12),
        _Checklist(method: method, run: run, strings: strings),
        const SizedBox(height: 12),
        _SafetyCard(strings: strings),
      ],
    );
  }

  String _number(double value) => value == value.roundToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
}

class _YieldEstimate extends StatelessWidget {
  final bool stripping;
  final TextEditingController volume;
  final TextEditingController strength;

  const _YieldEstimate({
    required this.stripping,
    required this.volume,
    required this.strength,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final stage = stripping ? 'stripping' : 'spirit';
    return ListenableBuilder(
      listenable: Listenable.merge([volume, strength]),
      builder: (context, _) {
        final litres = parseLocalizedNumber(volume.text);
        final abv = parseLocalizedNumber(strength.text);
        final validVolume =
            litres != null &&
            litres.isFinite &&
            litres > 0 &&
            litres <= 1000000;
        final validAbv =
            abv != null &&
            abv.isFinite &&
            (stripping ? abv > 0 && abv <= 15 : abv >= 10 && abv <= 30);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              controller: volume,
              label: strings.tr('run.$stage.volume'),
              unit: 'L',
              errorText: volume.text.isEmpty || validVolume
                  ? null
                  : strings.tr('run.volumeError'),
            ),
            InputField(
              controller: strength,
              label: strings.tr('run.$stage.strength'),
              unit: '% vol',
              errorText: strength.text.isEmpty || validAbv
                  ? null
                  : strings.tr('run.$stage.error'),
            ),
            if (validVolume && validAbv) ...[
              if (stripping)
                _range(
                  context,
                  'run.lowWines',
                  litres * abv / 100 * 0.90 / 0.25,
                  litres * abv / 100 * 0.90 / 0.20,
                )
              else ...[
                // Sólyom, Pálinkafőzés: 0.3–0.5% foreshots plus 0.5–1.5% further heads by charge volume.
                _range(context, 'run.heads', litres * 0.008, litres * 0.020),
                // Scale the 30–35% reference heart yield to the same absolute alcohol at a 25% reference charge.
                _range(
                  context,
                  'run.hearts',
                  litres * abv / 25 * 0.30,
                  litres * abv / 25 * 0.35,
                ),
              ],
              const SizedBox(height: 8),
            ],
            Text(strings.tr('run.$stage.note')),
          ],
        );
      },
    );
  }

  Widget _range(BuildContext context, String key, double low, double high) {
    final ml = high < 1;
    String format(double value) {
      final n = ml ? value * 1000 : value;
      if (ml && n < 1) return '<1';
      final text = n.toStringAsFixed(
        ml || n >= 100
            ? 0
            : n < 1
            ? 2
            : 1,
      );
      return Localizations.localeOf(context).languageCode == 'en'
          ? text
          : text.replaceAll('.', ',');
    }

    return Text(
      '${AppLocalizations.of(context).tr(key)}\n${format(low)}–${format(high)} ${ml ? 'ml' : 'L'}',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class _CutWindowCard extends StatelessWidget {
  final DistillationMethod method;
  final DistillationMethodCuts cuts;
  final DistillationSensoryProfile sensoryProfile;
  final String languageCode;
  final AppLocalizations strings;

  const _CutWindowCard({
    required this.method,
    required this.cuts,
    required this.sensoryProfile,
    required this.languageCode,
    required this.strings,
  });

  String _description(String key, AbvCutWindow window) => strings
      .tr(key)
      .replaceAll('{high}', '${window.high}%')
      .replaceAll('{low}', '${window.low}%')
      .replaceAll('{range}', window.label);

  @override
  Widget build(BuildContext context) {
    final methodKey = method == DistillationMethod.pot ? 'pot' : 'column';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strings.tr('distillation.cuts.title'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(strings.tr('distillation.cuts.subtitle')),
            const SizedBox(height: 16),
            _CutRow(
              icon: Icons.arrow_forward_rounded,
              title: strings.tr('distillation.cuts.headsToHeart'),
              window: cuts.headsToHeart,
              description:
                  '${_description('distillation.cuts.$methodKey.headsToHeart', cuts.headsToHeart)}\n\n'
                  '${strings.tr('distillation.sensory.cleanSignal')} '
                  '${sensoryProfile.target(languageCode)}',
            ),
            const Divider(height: 28),
            _SensoryHeartRow(
              description: strings
                  .tr('distillation.sensory.heartBody')
                  .replaceAll('{target}', sensoryProfile.target(languageCode)),
              strings: strings,
            ),
            const Divider(height: 28),
            _CutRow(
              icon: Icons.arrow_downward_rounded,
              title: strings.tr('distillation.cuts.heartToTails'),
              window: cuts.heartToTails,
              description:
                  '${_description('distillation.cuts.$methodKey.heartToTails', cuts.heartToTails)}\n\n'
                  '${strings.tr('distillation.sensory.lateSignal')} '
                  '${sensoryProfile.lateRun(languageCode)}',
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.tertiaryContainer.withValues(alpha: .55),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text(strings.tr('distillation.cuts.note'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CutRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final AbvCutWindow window;
  final String description;

  const _CutRow({
    required this.icon,
    required this.title,
    required this.window,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 24),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    window.label,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    ],
  );
}

class _SensoryHeartRow extends StatelessWidget {
  final String description;
  final AppLocalizations strings;

  const _SensoryHeartRow({required this.description, required this.strings});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.favorite_outline_rounded, size: 24),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strings.tr('distillation.sensory.heartTitle'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    ],
  );
}

class _RiskCard extends StatelessWidget {
  final DistillationFruitProfile profile;
  final AppLocalizations strings;

  const _RiskCard({required this.profile, required this.strings});

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.tr('distillation.risks'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _RiskLine(
            label: strings.tr('distillation.risk.foaming'),
            risk: profile.foamingRisk,
            strings: strings,
          ),
          _RiskLine(
            label: strings.tr('distillation.risk.scorching'),
            risk: profile.scorchingRisk,
            strings: strings,
          ),
          if (profile.stoneWarning)
            _AlertLine(
              icon: Icons.warning_amber_rounded,
              text: strings.tr('distillation.warning.stone'),
            ),
          if (profile.pectinWarning)
            _AlertLine(
              icon: Icons.science_outlined,
              text: strings.tr('distillation.warning.pectin'),
            ),
        ],
      ),
    ),
  );
}

class _RiskLine extends StatelessWidget {
  final String label;
  final DistillationRisk risk;
  final AppLocalizations strings;

  const _RiskLine({
    required this.label,
    required this.risk,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final key = switch (risk) {
      DistillationRisk.low => 'distillation.risk.low',
      DistillationRisk.medium => 'distillation.risk.medium',
      DistillationRisk.high => 'distillation.risk.high',
    };
    final color = switch (risk) {
      DistillationRisk.low => Colors.green,
      DistillationRisk.medium => Colors.orange,
      DistillationRisk.high => Theme.of(context).colorScheme.error,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .14),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              strings.tr(key),
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _AlertLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

class _MethodCard extends StatelessWidget {
  final DistillationMethod method;
  final DistillationFruitProfile profile;
  final DistillationSensoryProfile sensoryProfile;
  final String fruitName;
  final AppLocalizations strings;

  const _MethodCard({
    required this.method,
    required this.profile,
    required this.sensoryProfile,
    required this.fruitName,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final methodKey = method == DistillationMethod.pot ? 'pot' : 'column';
    final strategyKey = switch (profile.aromaStrategy) {
      AromaStrategy.delicate => 'delicate',
      AromaStrategy.balanced => 'balanced',
      AromaStrategy.late => 'late',
    };
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${strings.tr('distillation.method.$methodKey')} – $fruitName',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(strings.tr('distillation.method.$methodKey.body')),
            const Divider(height: 28),
            Text(
              strings.tr('distillation.strategy.title'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(strings.tr('distillation.$methodKey.$strategyKey')),
            const SizedBox(height: 10),
            Text(
              strings
                  .tr('distillation.method.preserve')
                  .replaceAll(
                    '{target}',
                    sensoryProfile.target(
                      Localizations.localeOf(context).languageCode,
                    ),
                  ),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _FruitCard extends StatelessWidget {
  final String fruitName;
  final DistillationFruitProfile profile;
  final AppLocalizations strings;

  const _FruitCard({
    required this.fruitName,
    required this.profile,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fruitName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            strings.tr('distillation.beforeHeating'),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Text(profile.focus(Localizations.localeOf(context).languageCode)),
        ],
      ),
    ),
  );
}

class _FaultGuide extends StatelessWidget {
  final AppLocalizations strings;

  const _FaultGuide({required this.strings});

  @override
  Widget build(BuildContext context) {
    const faults = [
      ('solvent', Icons.science_outlined),
      ('vinegar', Icons.water_drop_outlined),
      ('scorched', Icons.local_fire_department_outlined),
      ('tails', Icons.opacity_outlined),
      ('neutral', Icons.air_outlined),
      ('musty', Icons.warning_amber_rounded),
    ];
    return Card(
      child: ExpansionTile(
        leading: const Icon(Icons.troubleshoot_rounded),
        title: Text(
          strings.tr('distillation.faults.title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(strings.tr('distillation.faults.subtitle')),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          for (final fault in faults)
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(fault.$2, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.tr('distillation.faults.${fault.$1}.title'),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          strings.tr('distillation.faults.${fault.$1}.body'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 14),
          Text(
            strings.tr('distillation.faults.note'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _LaboratorySafetyCard extends StatelessWidget {
  final AppLocalizations strings;

  const _LaboratorySafetyCard({required this.strings});

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.tertiaryContainer,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.biotech_outlined, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.tr('distillation.laboratory.title'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(strings.tr('distillation.laboratory.body')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Checklist extends StatelessWidget {
  final _PotRun run;
  final DistillationMethod method;
  final AppLocalizations strings;

  const _Checklist({
    required this.method,
    required this.run,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final keys = [
      if (method == DistillationMethod.column || run == _PotRun.stripping)
        'distillation.check.finished',
      'distillation.check.charge',
      'distillation.check.heat',
      if (method == DistillationMethod.pot)
        'distillation.check.pot'
      else
        'distillation.check.column',
      if (method == DistillationMethod.column || run == _PotRun.spirit)
        'distillation.check.cuts',
      'distillation.check.record',
    ];
    return Card(
      child: ExpansionTile(
        leading: const Icon(Icons.fact_check_outlined),
        title: Text(strings.tr('distillation.checklist')),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          for (final key in keys)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(Icons.circle, size: 6),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(strings.tr(key))),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  final AppLocalizations strings;

  const _SafetyCard({required this.strings});

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.errorContainer,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.health_and_safety_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.tr('distillation.safety.title'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(strings.tr('distillation.safety.body')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
