import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class YearReviewScreen extends ConsumerWidget {
  const YearReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = DateTime.now().year;
    final payments = ref.watch(financeRepoProvider);
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
        // biggest increase from price history isn't loaded fully; use monthly
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
          appBar: AppBar(title: const Text('YEAR IN REVIEW')),
          body: AppPage(
            child: ListView(
              children: [
                SectionLabel('$year'),
                _row('TOTAL SPENT', MoneyMath.format(total, fx.baseCurrency)),
                _row('MOST EXPENSIVE', most),
                _row('BIGGEST INCREASE', increase),
                _row('CANCELLED', '$cancelled'),
                _row('ESTIMATED SAVINGS', MoneyMath.format(savings, fx.baseCurrency)),
                _row('FOREIGN SPEND', MoneyMath.format(foreign, fx.baseCurrency)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _row(String k, String v) => ListTile(title: SectionLabel(k), trailing: Text(v));
}
