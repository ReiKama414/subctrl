import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/data/repositories/purchase_repository.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

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
    final l10n = context.l10n;
    final c = context.colors;
    return async.when(
      loading: () => const AppPage(child: Padding(padding: EdgeInsets.all(24), child: SkeletonBlock(height: 80))),
      error: (e, _) => AppPage(child: Text('$e')),
      data: (_) {
        final subs = ref.watch(scopedSubscriptionsProvider);
        final monthly = subs.fold<double>(0, (p, s) => p + fx.monthlyBase(s));
        final year = ForecastEngine(fx).nextTwelveMonths(subs).fold<double>(0, (p, m) => p + m.totalBase);
        final actions = ActionEngine.build(subs, methods, l10n);
        final totalBudget = budgets.where((b) => b.scope == 'total').firstOrNull;
        final overBudget = totalBudget != null && monthly > totalBudget.monthlyAmount;
        // AppPage must be the root (same as other tabs). Nesting it inside
        // ListView lets the column shrink below maxContentWidth on wide web.
        return AppPage(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              const ProfileSwitcher(compact: true),
              const SizedBox(height: 20),
              SectionLabel(l10n.monthlyLoad),
              const SizedBox(height: 8),
              TerminalAmount(hide ? '••••' : MoneyMath.format(monthly, fx.baseCurrency), size: 36),
              const SizedBox(height: 6),
              Text(
                '${l10n.yearForecast}  ${hide ? '••••' : MoneyMath.format(year, fx.baseCurrency)}',
                style: AppTypography.body(c.textMuted),
              ),
              if (overBudget) ...[
                const SizedBox(height: 10),
                StatusMark(l10n.overBudget, tone: c.warning),
              ],
              const SizedBox(height: 20),
              _OverviewStrip(
                subsCount: subs.where((s) => s.isBillable).length,
                pendingCount: ref.watch(pendingPurchaseOrdersProvider).length,
              ),
              const SizedBox(height: 28),
              SectionLabel(l10n.actionRequired),
              const SizedBox(height: 8),
              if (actions.isEmpty)
                Text(l10n.noUrgentDeadlines, style: AppTypography.body(c.textMuted))
              else
                ...actions.take(3).map(
                      (a) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SurfaceCard(
                          onTap: a.subscriptionId.isEmpty ? null : () => context.push('/subs/${a.subscriptionId}'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.title, style: AppTypography.label(c.textPrimary)),
                              const SizedBox(height: 4),
                              Text(a.headline, style: AppTypography.label(c.accent)),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              SectionLabel(l10n.upcomingPayments),
              const SizedBox(height: 4),
              ..._upcoming(subs).map(
                (s) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(s.serviceName),
                  subtitle: Text(s.nextBillingDate?.toIso8601String().substring(0, 10) ?? '—'),
                  trailing: Text(hide ? '••••' : MoneyMath.format(s.currentPrice, s.currency)),
                  onTap: () => context.push('/subs/${s.id}'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: SectionLabel(l10n.pendingOrders)),
                  TextButton(
                    onPressed: () => context.push('/orders'),
                    child: Text(l10n.viewAll),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ..._pendingOrders(ref).map(
                (o) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(o.title),
                  subtitle: Text(
                    '${o.platform} · ${l10n.purchaseStatusLabel(o.status)}'
                    '${o.expectedAt != null ? ' · ${o.expectedAt!.toIso8601String().substring(0, 10)}' : ''}',
                  ),
                  trailing: Icon(Icons.chevron_right, color: c.textMuted, size: 18),
                  onTap: () => context.push('/orders/${o.id}'),
                ),
              ),
              if (ref.watch(pendingPurchaseOrdersProvider).isEmpty)
                Text(l10n.noPendingOrders, style: AppTypography.body(c.textMuted)),
            ],
          ),
        );
      },
    );
  }

  List<SubscriptionView> _upcoming(List<SubscriptionView> subs) {
    final list = [...subs.where((s) => s.nextBillingDate != null)]
      ..sort((a, b) => a.nextBillingDate!.compareTo(b.nextBillingDate!));
    return list.take(5).toList();
  }

  List<PurchaseOrderView> _pendingOrders(WidgetRef ref) {
    final list = [...ref.watch(pendingPurchaseOrdersProvider)]
      ..sort((a, b) {
        final ae = a.expectedAt ?? a.orderedAt;
        final be = b.expectedAt ?? b.orderedAt;
        return ae.compareTo(be);
      });
    return list.take(5).toList();
  }
}

class _OverviewStrip extends StatelessWidget {
  const _OverviewStrip({required this.subsCount, required this.pendingCount});
  final int subsCount;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return Row(
      children: [
        Expanded(
          child: SurfaceCard(
            onTap: () => context.go('/subs'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.subscriptionsTracked, style: AppTypography.body(c.textMuted)),
                const SizedBox(height: 6),
                Text('$subsCount', style: AppTypography.label(c.textPrimary).copyWith(fontSize: 22)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SurfaceCard(
            onTap: () => context.push('/orders'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.pendingPreorders, style: AppTypography.body(c.textMuted)),
                const SizedBox(height: 6),
                Text(
                  '$pendingCount',
                  style: AppTypography.label(pendingCount > 0 ? c.warning : c.textPrimary).copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
