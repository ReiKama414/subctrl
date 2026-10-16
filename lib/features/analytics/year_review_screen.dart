import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class YearReviewScreen extends ConsumerWidget {
  const YearReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = DateTime.now().year;
    final payments = ref.watch(financeRepoProvider);
    final l10n = context.l10n;
    return FutureBuilder(
      future: payments.payments(),
      builder: (context, snap) {
        final fx = ref.watch(currencyEngineProvider);
        final subs = ref.watch(scopedSubscriptionsProvider);
        final scopedIds = subs.map((s) => s.id).toSet();
        final yearPays = (snap.data ?? [])
            .where((p) => p.date.year == year && (scopedIds.isEmpty || scopedIds.contains(p.subscriptionId)))
            .toList();
        final total = yearPays.fold<double>(0, (p, e) => p + e.actualChargedAmount);
        final bySub = <String, double>{};
        for (final p in yearPays) {
          bySub[p.subscriptionId] = (bySub[p.subscriptionId] ?? 0) + p.actualChargedAmount;
        }
        String most = '—';
        if (bySub.isNotEmpty) {
          final id = bySub.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
          most = subs.where((s) => s.id == id).map((s) => s.serviceName).firstOrNull ?? id;
        }
        String increase = '—';
        var maxM = 0.0;
        for (final s in subs) {
          final m = fx.monthlyBase(s);
          if (m > maxM) {
            maxM = m;
            increase = s.serviceName;
          }
        }
        final cancelled = subs.where((s) => s.status == SubscriptionStatus.cancelled || s.status == SubscriptionStatus.expired).length;
        final savings = subs
            .where((s) => s.status == SubscriptionStatus.cancelled)
            .fold<double>(0, (p, s) => p + fx.quote(s.currentPrice, s.currency).estimatedCharge);
        final foreign = yearPays.where((p) => p.originalCurrency != fx.baseCurrency).fold<double>(0, (p, e) => p + e.actualChargedAmount);
        return Scaffold(
          appBar: AppBar(title: Text(l10n.yearInReview)),
          body: AppPage(
            child: ListView(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              children: [
                SurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionLabel('$year · ${l10n.totalSpent}'),
                      const SizedBox(height: 8),
                      TerminalAmount(MoneyMath.format(total, fx.baseCurrency), size: 36),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SurfaceCard(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Column(
                    children: [
                      _row(context, Icons.workspace_premium_rounded, l10n.mostExpensive, most),
                      _row(context, Icons.trending_up_rounded, l10n.biggestIncrease, increase),
                      _row(context, Icons.cancel_rounded, l10n.cancelledCount, '$cancelled'),
                      _row(context, Icons.savings_rounded, l10n.cancelledSavings, MoneyMath.format(savings, fx.baseCurrency)),
                      _row(context, Icons.currency_exchange_rounded, l10n.foreignSpend, MoneyMath.format(foreign, fx.baseCurrency)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _row(BuildContext context, IconData icon, String k, String v) {
    final c = context.colors;
    return ListTile(
      leading: Icon(icon),
      title: Text(k),
      trailing: Text(v, style: AppTypography.amount(c.textPrimary, size: 15)),
    );
  }
}
