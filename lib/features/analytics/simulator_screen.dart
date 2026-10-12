import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
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
    final subs = ref.watch(scopedSubscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final result = WhatIfEngine(fx).simulate(subs, selected);
    return Scaffold(
      appBar: AppBar(title: const Text('WHAT-IF')),
      body: AppPage(
        child: ListView(
          children: [
            SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel('CURRENT'),
                  TerminalAmount('${MoneyMath.format(result.currentMonthly, fx.baseCurrency)} / month', size: 22),
                  const SizedBox(height: 12),
                  const SectionLabel('NEW'),
                  TerminalAmount('${MoneyMath.format(result.newMonthly, fx.baseCurrency)} / month', size: 22),
                  const SizedBox(height: 12),
                  const SectionLabel('SAVE'),
                  Text('${MoneyMath.format(result.savedMonthly, fx.baseCurrency)} / month'),
                  Text('${MoneyMath.format(result.savedYearly, fx.baseCurrency)} / year'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const SectionLabel('CANCEL'),
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
