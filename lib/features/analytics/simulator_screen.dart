import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class SimulatorScreen extends ConsumerStatefulWidget {
  const SimulatorScreen({super.key});
  @override
  ConsumerState<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends ConsumerState<SimulatorScreen> {
  final selected = <String>{};

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final subs = ref.watch(scopedSubscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final result = WhatIfEngine(fx).simulate(subs, selected);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.whatIf)),
      body: AppPage(
        child: ListView(
          children: [
            SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionLabel(l10n.current),
                  TerminalAmount('${MoneyMath.format(result.currentMonthly, fx.baseCurrency)} ${l10n.perMonth}', size: 22),
                  const SizedBox(height: 12),
                  SectionLabel(l10n.newValue),
                  TerminalAmount('${MoneyMath.format(result.newMonthly, fx.baseCurrency)} ${l10n.perMonth}', size: 22),
                  const SizedBox(height: 12),
                  SectionLabel(l10n.saveLabel),
                  Text('${MoneyMath.format(result.savedMonthly, fx.baseCurrency)} ${l10n.perMonth}'),
                  Text('${MoneyMath.format(result.savedYearly, fx.baseCurrency)} ${l10n.perYear}'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionLabel(l10n.simCancel),
            for (final s in subs)
              CheckboxListTile(
                value: selected.contains(s.id),
                title: Text(s.serviceName),
                subtitle: Text(MoneyMath.format(fx.monthlyBase(s), fx.baseCurrency)),
                onChanged: (v) => setState(() {
                  if (v == true) {
                    selected.add(s.id);
                  } else {
                    selected.remove(s.id);
                  }
                }),
              ),
          ],
        ),
      ),
    );
  }
}
