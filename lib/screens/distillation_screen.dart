import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/distillation_cut_profile.dart';
import '../models/distillation_fruit_profile.dart';
import '../models/mash_fruit_profile.dart';

enum DistillationMethod { pot, column }

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
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _RiskCard(profile: profile, strings: strings),
        const SizedBox(height: 12),
        _MethodCard(method: method, profile: profile, strings: strings),
        const SizedBox(height: 12),
        _CutWindowCard(
          method: method,
          cuts: method == DistillationMethod.pot
              ? cutProfile.pot
              : cutProfile.column,
          strings: strings,
        ),
        const SizedBox(height: 12),
        _FruitCard(
          fruitName: selectedFruit.name(languageCode),
          profile: profile,
          strings: strings,
        ),
        const SizedBox(height: 12),
        _Checklist(method: method, strings: strings),
        const SizedBox(height: 12),
        _SafetyCard(strings: strings),
      ],
    );
  }

  String _number(double value) => value == value.roundToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
}

class _CutWindowCard extends StatelessWidget {
  final DistillationMethod method;
  final DistillationMethodCuts cuts;
  final AppLocalizations strings;

  const _CutWindowCard({
    required this.method,
    required this.cuts,
    required this.strings,
  });

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
              description: strings.tr(
                'distillation.cuts.$methodKey.headsToHeart',
              ),
            ),
            const Divider(height: 28),
            _CutRow(
              icon: Icons.arrow_downward_rounded,
              title: strings.tr('distillation.cuts.heartToTails'),
              window: cuts.heartToTails,
              description: strings.tr(
                'distillation.cuts.$methodKey.heartToTails',
              ),
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
      Icon(icon, size: 22),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 3),
            Text(description),
          ],
        ),
      ),
      const SizedBox(width: 12),
      Text(
        window.label,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
  final AppLocalizations strings;

  const _MethodCard({
    required this.method,
    required this.profile,
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
              strings.tr('distillation.method.$methodKey'),
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
          const SizedBox(height: 8),
          Text(profile.focus(Localizations.localeOf(context).languageCode)),
        ],
      ),
    ),
  );
}

class _Checklist extends StatelessWidget {
  final DistillationMethod method;
  final AppLocalizations strings;

  const _Checklist({required this.method, required this.strings});

  @override
  Widget build(BuildContext context) {
    final keys = [
      'distillation.check.finished',
      'distillation.check.charge',
      'distillation.check.heat',
      if (method == DistillationMethod.pot)
        'distillation.check.pot'
      else
        'distillation.check.column',
      'distillation.check.cuts',
      'distillation.check.record',
    ];
    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
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
