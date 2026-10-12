import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/models/views.dart';
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
    return async.when(
      loading: () => const AppPage(child: Padding(padding: EdgeInsets.all(24), child: SkeletonBlock(height: 80))),
      error: (e, _) => AppPage(child: Text('$e')),
      data: (_) {
        final subs = ref.watch(scopedSubscriptionsProvider);
        final monthly = subs.fold<double>(0, (p, s) => p + fx.monthlyBase(s));
        final year = ForecastEngine(fx).nextTwelveMonths(subs).fold<double>(0, (p, m) => p + m.totalBase);
        final actions = ActionEngine.build(subs, methods);
        final fxCount = subs.where((s) => s.currency != fx.baseCurrency).length;
        final totalBudget = budgets.where((b) => b.scope == 'total').firstOrNull;
        final overBudget = totalBudget != null && monthly > totalBudget.monthlyAmount;
        return ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            AppPage(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionLabel(l10n.controlCenter),
                  const SizedBox(height: 8),
                  const ProfileSwitcher(compact: true),
                  const SizedBox(height: 12),
                  if (overBudget)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: StatusMark(
                        l10n.overBudget,
                        tone: context.colors.warning,
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: SurfaceCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionLabel(l10n.monthlyLoad),
                              const SizedBox(height: 8),
                              TerminalAmount(hide ? '••••' : MoneyMath.format(monthly, fx.baseCurrency), size: 28),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SurfaceCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionLabel(l10n.yearForecast),
                              const SizedBox(height: 8),
                              TerminalAmount(hide ? '••••' : MoneyMath.format(year, fx.baseCurrency), size: 22),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      StatusMark('${subs.where((s) => s.status == SubscriptionStatus.active || s.status == SubscriptionStatus.trial || s.status == SubscriptionStatus.promo).length} ${l10n.activeCount}'),
                      StatusMark('$fxCount ${l10n.foreign}'),
                      StatusMark('${actions.length} ${l10n.actionRequiredCount}', tone: actions.isEmpty ? null : context.colors.warning),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SectionLabel(l10n.actionRequired),
                  const SizedBox(height: 8),
                  if (actions.isEmpty)
                    Text(l10n.noUrgentDeadlines, style: AppTypography.body(context.colors.textMuted))
                  else
                    ...actions.map((a) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: SurfaceCard(
                            onTap: a.subscriptionId.isEmpty ? null : () => context.push('/subs/${a.subscriptionId}'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a.title, style: AppTypography.label(context.colors.textPrimary)),
                                const SizedBox(height: 6),
                                Text(a.headline, style: AppTypography.label(context.colors.accent)),
                                const SizedBox(height: 6),
                                for (final line in a.lines) Text(line, style: AppTypography.body(context.colors.textSecondary)),
                              ],
                            ),
                          ),
                        )),
                  const SizedBox(height: 16),
                  SectionLabel(l10n.upcomingPayments),
                  const SizedBox(height: 8),
                  ..._upcoming(subs).map((s) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(s.serviceName),
                        subtitle: Text(s.nextBillingDate?.toIso8601String().substring(0, 10) ?? '—'),
                        trailing: Text(hide ? '••••' : MoneyMath.format(s.currentPrice, s.currency)),
                        onTap: () => context.push('/subs/${s.id}'),
                      )),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  List<SubscriptionView> _upcoming(List<SubscriptionView> subs) {
    final list = [...subs.where((s) => s.nextBillingDate != null)]
      ..sort((a, b) => a.nextBillingDate!.compareTo(b.nextBillingDate!));
    return list.take(6).toList();
  }
}
