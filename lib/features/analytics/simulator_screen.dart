import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/features/subscriptions/edit_subscription.dart';
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
    final c = context.colors;
    final subs = ref.watch(scopedSubscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final result = WhatIfEngine(fx).simulate(subs, selected);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.whatIf)),
      body: AppPage(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            SurfaceCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _metric(l10n.current, '${MoneyMath.format(result.currentMonthly, fx.baseCurrency)} ${l10n.perMonth}', 22),
                  const SizedBox(height: 16),
                  _metric(l10n.newValue, '${MoneyMath.format(result.newMonthly, fx.baseCurrency)} ${l10n.perMonth}', 22),
                  const SizedBox(height: 16),
                  SectionLabel(l10n.saveLabel),
                  const SizedBox(height: 6),
                  Text(
                    '${MoneyMath.format(result.savedMonthly, fx.baseCurrency)} ${l10n.perMonth}',
                    style: AppTypography.body(c.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${MoneyMath.format(result.savedYearly, fx.baseCurrency)} ${l10n.perYear}',
                    style: AppTypography.caption(c.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SectionLabel(l10n.simCancel),
            const SizedBox(height: 6),
            Text(l10n.simulatorDeleteHint, style: AppTypography.caption(c.textMuted)),
            const SizedBox(height: 12),
            for (final s in subs)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SurfaceCard(
                  padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: selected.contains(s.id),
                          title: Text(
                            s.serviceName,
                            style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              MoneyMath.format(fx.monthlyBase(s), fx.baseCurrency),
                              style: AppTypography.caption(c.textMuted),
                            ),
                          ),
                          onChanged: (v) => setState(() {
                            if (v == true) {
                              selected.add(s.id);
                            } else {
                              selected.remove(s.id);
                            }
                          }),
                        ),
                      ),
                      IconButton(
                        tooltip: l10n.deleteSubscription,
                        icon: Icon(Icons.delete_outline_rounded, color: c.danger, size: 22),
                        onPressed: () async {
                          final ok = await showDeleteSubscriptionDialog(context: context, ref: ref, sub: s);
                          if (ok) {
                            setState(() => selected.remove(s.id));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _metric(String label, String amount, double size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label),
        const SizedBox(height: 6),
        TerminalAmount(amount, size: size),
      ],
    );
  }
}
