import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class DataScreen extends ConsumerStatefulWidget {
  const DataScreen({super.key});
  @override
  ConsumerState<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends ConsumerState<DataScreen> {
  ForecastMonth? open;

  @override
  Widget build(BuildContext context) {
    final subs = ref.watch(scopedSubscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final monthly = subs.fold<double>(0, (p, s) => p + fx.monthlyBase(s));
    final forecast = ForecastEngine(fx).nextTwelveMonths(subs);
    final year = forecast.fold<double>(0, (p, m) => p + m.totalBase);
    final cats = <String, double>{};
    for (final s in subs) {
      cats[s.categorySlug] = (cats[s.categorySlug] ?? 0) + fx.monthlyBase(s);
    }
    final foreign = subs.where((s) => s.currency != fx.baseCurrency).fold<double>(0, (p, s) => p + fx.monthlyBase(s));
    final cancelled = subs.where((s) => s.status == SubscriptionStatus.cancelled || s.status == SubscriptionStatus.expired);
    final savings = cancelled.fold<double>(0, (p, s) => p + BillingMath.monthlyEquivalent(fx.quote(s.currentPrice, s.currency).estimatedCharge, s.billingCycle));
    final c = context.colors;
    final l10n = context.l10n;
    return AppPage(
      child: ListView(
        children: [
          SectionLabel(l10n.data),
          const SizedBox(height: 8),
          const ProfileSwitcher(compact: true),
          const SizedBox(height: 12),
          SurfaceCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SectionLabel(l10n.monthlyCost),
            TerminalAmount(MoneyMath.format(monthly, fx.baseCurrency)),
            const SizedBox(height: 8),
            SectionLabel(l10n.annualForecast),
            TerminalAmount(MoneyMath.format(year, fx.baseCurrency), size: 24),
          ])),
          const SizedBox(height: 12),
          SectionLabel(l10n.categorySpending),
          SizedBox(
            height: 160,
            child: BarChart(BarChartData(
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
                  final keys = cats.keys.toList();
                  if (v.toInt() < 0 || v.toInt() >= keys.length) return const SizedBox.shrink();
                  return Text(keys[v.toInt()].substring(0, keys[v.toInt()].length.clamp(0, 3)).toUpperCase(), style: AppTypography.mono.copyWith(fontSize: 9, color: c.textMuted));
                })),
              ),
              barGroups: [
                for (var i = 0; i < cats.length; i++)
                  BarChartGroupData(x: i, barRods: [BarChartRodData(toY: cats.values.elementAt(i), color: c.accent, width: 8)]),
              ],
            )),
          ),
          const SizedBox(height: 12),
          SectionLabel(l10n.trend12),
          for (final m in forecast)
            ListTile(
              title: Text('${m.year}-${m.month.toString().padLeft(2, '0')}'),
              trailing: Text(MoneyMath.format(m.totalBase, fx.baseCurrency)),
              onTap: () => setState(() => open = m),
            ),
          if (open != null) ...[
            SectionLabel('${open!.year}-${open!.month} ${l10n.detail}'),
            for (final line in open!.lines)
              ListTile(dense: true, title: Text(line.name), subtitle: Text(line.reason), trailing: Text(MoneyMath.format(line.amountBase, fx.baseCurrency))),
          ],
          ListTile(title: Text(l10n.foreign), trailing: Text(MoneyMath.format(foreign, fx.baseCurrency))),
          ListTile(title: Text(l10n.cancelledSavings), trailing: Text(MoneyMath.format(savings, fx.baseCurrency))),
          ListTile(title: Text(l10n.whatIf), onTap: () => context.push('/simulator')),
          ListTile(title: Text(l10n.yearInReview), onTap: () => context.push('/year')),
          ListTile(title: Text(l10n.budget), onTap: () => context.push('/budget')),
        ],
      ),
    );
  }
}
