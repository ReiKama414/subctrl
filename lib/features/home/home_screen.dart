import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/data/repositories/purchase_repository.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

const _mask = '••••';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(subscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final prefs = ref.watch(preferencesProvider).valueOrNull;
    final methods = ref.watch(paymentMethodsProvider).valueOrNull ?? [];
    final hide = prefs?.hideAmounts == true;
    final budgets = ref.watch(budgetsProvider).valueOrNull ?? [];
    final pending = ref.watch(pendingPurchaseOrdersProvider);
    final l10n = context.l10n;
    final now = DateTime.now();

    return async.when(
      loading: () => const AppPage(child: Padding(padding: EdgeInsets.only(top: 24), child: SkeletonBlock(height: 180))),
      error: (e, _) => AppPage(child: Text('$e')),
      data: (_) {
        final subs = ref.watch(scopedSubscriptionsProvider);
        final monthly = subs.fold<double>(0, (p, s) => p + fx.monthlyBase(s));
        final year = ForecastEngine(fx).nextTwelveMonths(subs).fold<double>(0, (p, m) => p + m.totalBase);
        final actions = ActionEngine.build(subs, methods, l10n);
        final totalBudget = budgets.where((b) => b.scope == 'total').firstOrNull;
        String money(double v, String cur) => hide ? _mask : MoneyMath.format(v, cur);

        // AppPage must be the root (same as other tabs). Nesting it inside
        // ListView lets the column shrink below maxContentWidth on wide web.
        return AppPage(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              PageHeader(
                subtitle: l10n.longDate(now),
                title: l10n.greeting(now),
                actions: [
                  HeaderIconButton(
                    tooltip: l10n.hideAmounts,
                    icon: hide ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    onPressed: () => ref.read(settingsRepoProvider).patch(
                          UserPreferencesCompanion(hideAmounts: Value(!hide)),
                        ),
                  ),
                  HeaderIconButton(
                    tooltip: l10n.settings,
                    icon: Icons.settings_rounded,
                    onPressed: () => context.push('/settings'),
                  ),
                ],
              ),
              const ProfileSwitcher(compact: true),
              const SizedBox(height: 16),
              _HeroCard(
                monthly: money(monthly, fx.baseCurrency),
                year: money(year, fx.baseCurrency),
                activeCount: subs.where((s) => s.isBillable).length,
                budgetRatio: totalBudget == null || totalBudget.monthlyAmount <= 0
                    ? null
                    : monthly / totalBudget.monthlyAmount,
              ),
              const SizedBox(height: 20),
              _QuickActions(pendingCount: pending.length),
              const SizedBox(height: 28),
              SectionHeader(l10n.actionRequired),
              if (actions.isEmpty)
                _InfoRow(icon: Icons.check_circle_rounded, tone: context.colors.success, text: l10n.noUrgentDeadlines)
              else
                SizedBox(
                  height: 148,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    itemCount: actions.length.clamp(0, 8),
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (_, i) => _ActionCard(item: actions[i]),
                  ),
                ),
              const SizedBox(height: 28),
              SectionHeader(
                l10n.upcomingPayments,
                actionLabel: l10n.viewAll,
                onAction: () => context.go('/cal'),
              ),
              _UpcomingList(subs: _upcoming(subs, now), money: money),
              const SizedBox(height: 28),
              SectionHeader(
                l10n.spendingBreakdown,
                actionLabel: l10n.viewAll,
                onAction: () => context.go('/data'),
              ),
              _CategoryBreakdown(subs: subs, fx: fx, money: money),
              const SizedBox(height: 28),
              SectionHeader(
                l10n.pendingPreorders,
                actionLabel: l10n.viewAll,
                onAction: () => context.push('/orders'),
              ),
              if (pending.isEmpty)
                _InfoRow(icon: Icons.inventory_2_rounded, tone: context.colors.textMuted, text: l10n.noPendingOrders)
              else
                _PendingOrders(orders: _pendingOrders(pending), money: money),
            ],
          ),
        );
      },
    );
  }

  List<SubscriptionView> _upcoming(List<SubscriptionView> subs, DateTime now) {
    final today = BillingMath.dateOnly(now);
    const charging = {SubscriptionStatus.active, SubscriptionStatus.trial, SubscriptionStatus.promo};
    final list = [
      ...subs.where(
        (s) =>
            s.nextBillingDate != null &&
            charging.contains(s.status) &&
            !BillingMath.dateOnly(s.nextBillingDate!).isBefore(today),
      ),
    ]..sort((a, b) => a.nextBillingDate!.compareTo(b.nextBillingDate!));
    return list.take(5).toList();
  }

  List<PurchaseOrderView> _pendingOrders(List<PurchaseOrderView> pending) {
    final list = [...pending]
      ..sort((a, b) {
        final ae = a.expectedAt ?? a.orderedAt;
        final be = b.expectedAt ?? b.orderedAt;
        return ae.compareTo(be);
      });
    return list.take(4).toList();
  }
}

typedef _Money = String Function(double value, String currency);

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.monthly,
    required this.year,
    required this.activeCount,
    required this.budgetRatio,
  });

  final String monthly;
  final String year;
  final int activeCount;
  final double? budgetRatio;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    final fg = c.onAccent;
    final over = budgetRatio != null && budgetRatio! > 1;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [c.accent, Color.lerp(c.accent, c.background, 0.35)!],
        ),
        boxShadow: [BoxShadow(color: c.accent.withValues(alpha: 0.22), blurRadius: 28, offset: const Offset(0, 12))],
      ),
      child: Stack(
        children: [
          Positioned(right: -40, top: -50, child: _Orb(size: 170, color: fg.withValues(alpha: 0.08))),
          Positioned(right: 40, bottom: -70, child: _Orb(size: 140, color: fg.withValues(alpha: 0.06))),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(l10n.monthlyLoad, style: AppTypography.label(fg.withValues(alpha: 0.75))),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: fg.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(l10n.activeSubsCount(activeCount), style: AppTypography.label(fg).copyWith(fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(monthly, style: AppTypography.display(fg, size: 40)),
                ),
                const SizedBox(height: 6),
                Text(
                  '${l10n.yearForecast}  $year',
                  style: AppTypography.body(fg.withValues(alpha: 0.75)).copyWith(fontWeight: FontWeight.w500),
                ),
                if (budgetRatio != null) ...[
                  const SizedBox(height: 16),
                  ProgressPill(
                    value: budgetRatio!,
                    color: over ? c.danger : fg,
                    track: fg.withValues(alpha: 0.15),
                    height: 6,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        l10n.budgetUsage('${(budgetRatio! * 100).round()}%'),
                        style: AppTypography.caption(fg.withValues(alpha: 0.8)),
                      ),
                      const Spacer(),
                      if (over) StatusMark(l10n.overBudget, tone: c.danger, icon: Icons.warning_rounded),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.color});
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) =>
      Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color));
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.pendingCount});
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final items = [
      (Icons.add_rounded, c.accent, l10n.quickAdd, '/add', 0),
      (Icons.local_shipping_rounded, AppPalette.swatches[1], l10n.quickOrders, '/orders', pendingCount),
      (Icons.science_rounded, AppPalette.swatches[0], l10n.quickSimulate, '/simulator', 0),
      (Icons.savings_rounded, AppPalette.swatches[2], l10n.budget, '/budget', 0),
    ];
    return Row(
      children: [
        for (final it in items)
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              onTap: () => context.push(it.$4),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    Badge(
                      isLabelVisible: it.$5 > 0,
                      label: Text('${it.$5}'),
                      backgroundColor: c.warning,
                      textColor: AppPalette.onSwatch,
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: c.surface,
                          borderRadius: BorderRadius.circular(AppRadius.r16),
                        ),
                        child: Icon(it.$1, color: it.$2, size: 24),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      it.$3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption(c.textSecondary).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.item});
  final ActionItem item;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (icon, tone) = switch (item.kind) {
      'trial' => (Icons.hourglass_bottom_rounded, c.warning),
      'promo' => (Icons.local_offer_rounded, AppPalette.swatches[4]),
      'deadline' => (Icons.event_busy_rounded, c.danger),
      'first_charge' => (Icons.payments_rounded, AppPalette.swatches[5]),
      'card_expiry' => (Icons.credit_card_off_rounded, c.danger),
      _ => (Icons.autorenew_rounded, c.accent),
    };
    return SizedBox(
      width: 196,
      child: SurfaceCard(
        onTap: item.subscriptionId.isEmpty ? null : () => context.push('/subs/${item.subscriptionId}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBadge(icon: icon, color: tone, size: 34, iconSize: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.headline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.label(tone).copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.title(c.textPrimary).copyWith(fontSize: 15),
            ),
            const SizedBox(height: 2),
            if (item.lines.isNotEmpty)
              Text(
                item.lines.first,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption(c.textMuted),
              ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingList extends StatelessWidget {
  const _UpcomingList({required this.subs, required this.money});
  final List<SubscriptionView> subs;
  final _Money money;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    if (subs.isEmpty) {
      return _InfoRow(icon: Icons.event_available_rounded, tone: c.textMuted, text: l10n.noUpcoming);
    }
    final today = BillingMath.dateOnly(DateTime.now());
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          for (var i = 0; i < subs.length; i++) ...[
            if (i > 0) Divider(indent: 72, endIndent: 16, color: c.border.withValues(alpha: 0.5)),
            Builder(builder: (context) {
              final s = subs[i];
              final days = BillingMath.daysUntil(s.nextBillingDate!, today);
              final soon = days <= 3;
              return InkWell(
                onTap: () => context.push('/subs/${s.id}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      ServiceAvatar(s.serviceName, size: 42),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.serviceName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(l10n.shortDate(s.nextBillingDate!), style: AppTypography.caption(c.textMuted)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(money(s.currentPrice, s.currency), style: AppTypography.amount(c.textPrimary, size: 15)),
                          const SizedBox(height: 4),
                          StatusMark(l10n.dueIn(days), tone: soon ? c.warning : c.textSecondary),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _CategoryBreakdown extends StatelessWidget {
  const _CategoryBreakdown({required this.subs, required this.fx, required this.money});
  final List<SubscriptionView> subs;
  final CurrencyEngine fx;
  final _Money money;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    final cats = <String, double>{};
    for (final s in subs) {
      final v = fx.monthlyBase(s);
      if (v > 0) cats[s.categorySlug] = (cats[s.categorySlug] ?? 0) + v;
    }
    final total = cats.values.fold<double>(0, (p, v) => p + v);
    if (total <= 0) {
      return _InfoRow(icon: Icons.donut_large_rounded, tone: c.textMuted, text: l10n.noSubscriptionsBody);
    }
    final entries = cats.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return SurfaceCard(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: SizedBox(
              height: 12,
              child: Row(
                children: [
                  for (final e in entries)
                    Expanded(
                      flex: (e.value / total * 1000).round().clamp(1, 1000),
                      child: Container(
                        margin: const EdgeInsets.only(right: 2),
                        color: AppPalette.category(e.key),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          for (final e in entries.take(4))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(AppPalette.categoryIcon(e.key), size: 18, color: AppPalette.category(e.key)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(l10n.categorySlugLabel(e.key), style: AppTypography.body(c.textSecondary)),
                  ),
                  Text(
                    '${(e.value / total * 100).round()}%',
                    style: AppTypography.caption(c.textMuted),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 96,
                    child: Text(
                      money(e.value, fx.baseCurrency),
                      textAlign: TextAlign.right,
                      style: AppTypography.amount(c.textPrimary, size: 14, weight: FontWeight.w600),
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

class _PendingOrders extends StatelessWidget {
  const _PendingOrders({required this.orders, required this.money});
  final List<PurchaseOrderView> orders;
  final _Money money;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l10n = context.l10n;
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          for (var i = 0; i < orders.length; i++) ...[
            if (i > 0) Divider(indent: 72, endIndent: 16, color: c.border.withValues(alpha: 0.5)),
            Builder(builder: (context) {
              final o = orders[i];
              final tone = o.status.isPreorderLike ? c.warning : AppPalette.swatches[5];
              return InkWell(
                onTap: () => context.push('/orders/${o.id}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconBadge(icon: Icons.inventory_2_rounded, color: tone, size: 42),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              o.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.body(c.textPrimary).copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              [
                                o.platform,
                                if (o.expectedAt != null) l10n.shortDate(o.expectedAt!),
                              ].join(' · '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.caption(c.textMuted),
                            ),
                          ],
                        ),
                      ),
                      StatusMark(l10n.purchaseStatusLabel(o.status), tone: tone),
                    ],
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.tone, required this.text});
  final IconData icon;
  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SurfaceCard(
      child: Row(
        children: [
          IconBadge(icon: icon, color: tone, size: 36, iconSize: 18),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppTypography.body(c.textSecondary))),
        ],
      ),
    );
  }
}
