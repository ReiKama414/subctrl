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
  int openIndex = 0;

  @override
  Widget build(BuildContext context) {
    final subs = ref.watch(scopedSubscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final hide = ref.watch(preferencesProvider).valueOrNull?.hideAmounts == true;
    String money(double v) => hide ? '••••' : MoneyMath.format(v, fx.baseCurrency);
    final monthly = subs.fold<double>(0, (p, s) => p + fx.monthlyBase(s));
    final forecast = ForecastEngine(fx).nextTwelveMonths(subs);
    final year = forecast.fold<double>(0, (p, m) => p + m.totalBase);
    final cats = <String, double>{};
    for (final s in subs) {
      final v = fx.monthlyBase(s);
      if (v > 0) cats[s.categorySlug] = (cats[s.categorySlug] ?? 0) + v;
    }
    final foreign = subs.where((s) => s.currency != fx.baseCurrency).fold<double>(0, (p, s) => p + fx.monthlyBase(s));
    final cancelled = subs.where((s) => s.status == SubscriptionStatus.cancelled || s.status == SubscriptionStatus.expired);
    final savings = cancelled.fold<double>(0, (p, s) => p + BillingMath.monthlyEquivalent(fx.quote(s.currentPrice, s.currency).estimatedCharge, s.billingCycle));
    final c = context.colors;
    final l10n = context.l10n;
    final open = forecast.isEmpty ? null : forecast[openIndex.clamp(0, forecast.length - 1)];

    return AppPage(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          PageHeader(
            title: l10n.data,
            subtitle: l10n.insights,
            actions: [
              HeaderIconButton(
                tooltip: l10n.settings,
                icon: Icons.settings_rounded,
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
          const ProfileSwitcher(compact: true),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StatTile(label: l10n.monthlyCost, value: money(monthly), icon: Icons.calendar_view_month_rounded, tone: c.accent)),
              const SizedBox(width: 10),
              Expanded(child: _StatTile(label: l10n.annualForecast, value: money(year), icon: Icons.trending_up_rounded, tone: AppPalette.swatches[0])),
            ],
          ),
          const SizedBox(height: 28),
          SectionHeader(l10n.categorySpending),
          _CategoryDonut(cats: cats),
          const SizedBox(height: 28),
          SectionHeader(l10n.trend12),
          SurfaceCard(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
            child: Column(
              children: [
                SizedBox(
                  height: 170,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (_) => FlLine(color: c.border.withValues(alpha: 0.5), strokeWidth: 1, dashArray: [4, 4]),
                      ),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(
                        enabled: true,
                        handleBuiltInTouches: false,
                        touchCallback: (event, resp) {
                          final i = resp?.spot?.touchedBarGroupIndex;
                          if (event is FlTapUpEvent && i != null) setState(() => openIndex = i);
                        },
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 24,
                            getTitlesWidget: (v, m) {
                              final i = v.toInt();
                              if (i < 0 || i >= forecast.length) return const SizedBox.shrink();
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  '${forecast[i].month}',
                                  style: AppTypography.caption(i == openIndex ? c.textPrimary : c.textMuted).copyWith(fontSize: 11),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: [
                        for (var i = 0; i < forecast.length; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: forecast[i].totalBase,
                                width: 14,
                                color: i == openIndex ? c.accent : c.accent.withValues(alpha: 0.35),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                if (open != null) ...[
                  const SizedBox(height: 12),
                  Divider(color: c.border.withValues(alpha: 0.5)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${l10n.monthTitle(open.year, open.month)} ${l10n.detail}',
                            style: AppTypography.label(c.textSecondary),
                          ),
                        ),
                        Text(money(open.totalBase), style: AppTypography.amount(c.textPrimary, size: 16)),
                      ],
                    ),
                  ),
                  for (final line in open.lines)
                    InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.r12),
                      onTap: () => context.push('/subs/${line.subscriptionId}'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        child: Row(
                          children: [
                            ServiceAvatar(line.name, size: 32),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(line.name, style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600)),
                                  Text('${l10n.shortDate(line.date)} · ${line.reason}', style: AppTypography.caption(c.textMuted)),
                                ],
                              ),
                            ),
                            Text(money(line.amountBase), style: AppTypography.amount(c.textSecondary, size: 14, weight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(child: _StatTile(label: l10n.foreign, value: money(foreign), icon: Icons.currency_exchange_rounded, tone: AppPalette.swatches[5])),
              const SizedBox(width: 10),
              Expanded(child: _StatTile(label: l10n.cancelledSavings, value: money(savings), icon: Icons.savings_rounded, tone: c.success)),
            ],
          ),
          const SizedBox(height: 28),
          SectionHeader(l10n.tools),
          _ToolTile(icon: Icons.science_rounded, tone: AppPalette.swatches[0], title: l10n.whatIf, onTap: () => context.push('/simulator')),
          const SizedBox(height: 10),
          _ToolTile(icon: Icons.auto_graph_rounded, tone: AppPalette.swatches[4], title: l10n.yearInReview, onTap: () => context.push('/year')),
          const SizedBox(height: 10),
          _ToolTile(icon: Icons.account_balance_wallet_rounded, tone: AppPalette.swatches[2], title: l10n.budget, onTap: () => context.push('/budget')),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.icon, required this.tone});
  final String label;
  final String value;
  final IconData icon;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBadge(icon: icon, color: tone, size: 36, iconSize: 18),
          const SizedBox(height: 14),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTypography.caption(c.textMuted)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, style: AppTypography.amount(c.textPrimary, size: 20, weight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

class _CategoryDonut extends StatelessWidget {
  const _CategoryDonut({required this.cats});
  final Map<String, double> cats;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    final sum = cats.values.fold<double>(0, (p, v) => p + v);
    if (sum <= 0) {
      return SurfaceCard(child: Text(l10n.noSubscriptionsBody, style: AppTypography.body(c.textMuted)));
    }
    final entries = cats.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return SurfaceCard(
      child: Row(
        children: [
          SizedBox(
            width: 132,
            height: 132,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 44,
                    startDegreeOffset: -90,
                    sections: [
                      for (final e in entries)
                        PieChartSectionData(
                          value: e.value,
                          color: AppPalette.category(e.key),
                          radius: 20,
                          showTitle: false,
                        ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${entries.length}', style: AppTypography.amount(c.textPrimary, size: 22, weight: FontWeight.w800)),
                    Text(l10n.categoryTitle, style: AppTypography.caption(c.textMuted).copyWith(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              children: [
                for (final e in entries.take(5))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(color: AppPalette.category(e.key), borderRadius: BorderRadius.circular(3)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.categorySlugLabel(e.key),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption(c.textSecondary).copyWith(fontSize: 13),
                          ),
                        ),
                        Text('${(e.value / sum * 100).round()}%', style: AppTypography.amount(c.textPrimary, size: 13, weight: FontWeight.w600)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolTile extends StatelessWidget {
  const _ToolTile({required this.icon, required this.tone, required this.title, required this.onTap});
  final IconData icon;
  final Color tone;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          IconBadge(icon: icon, color: tone, size: 40),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600, fontSize: 15))),
          Icon(Icons.chevron_right_rounded, color: c.textMuted),
        ],
      ),
    );
  }
}
