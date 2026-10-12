import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/shared/widgets/profile_switcher.dart';
import 'package:subctrl/shared/widgets/ui.dart';

class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});
  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends ConsumerState<BudgetScreen> {
  final totalCtrl = TextEditingController();
  final Map<String, TextEditingController> _catCtrls = {};

  @override
  void dispose() {
    totalCtrl.dispose();
    for (final c in _catCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _ctrlFor(String key, double? seed) {
    return _catCtrls.putIfAbsent(key, () => TextEditingController(text: seed == null || seed == 0 ? '' : seed.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final subs = ref.watch(scopedSubscriptionsProvider);
    final fx = ref.watch(currencyEngineProvider);
    final budgetsAsync = ref.watch(budgetsProvider);
    final spent = subs.fold<double>(0, (p, s) => p + fx.monthlyBase(s));
    final byCat = <String, double>{};
    for (final s in subs) {
      byCat[s.categorySlug] = (byCat[s.categorySlug] ?? 0) + fx.monthlyBase(s);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('BUDGET')),
      body: AppPage(
        child: budgetsAsync.when(
          loading: () => const SkeletonBlock(height: 80),
          error: (e, _) => Text('$e'),
          data: (rows) {
            final t = rows.where((b) => b.scope == 'total').firstOrNull;
            final limit = t?.monthlyAmount ?? 5000;
            if (totalCtrl.text.isEmpty) totalCtrl.text = limit.toStringAsFixed(0);
            final snapShot = BudgetEngine.total(spent, limit, fx.baseCurrency);
            final catBudgets = {
              for (final b in rows.where((b) => b.scope == 'category' && b.categoryId != null)) b.categoryId!: b,
            };

            return ListView(
              children: [
                const ProfileSwitcher(compact: true),
                const SizedBox(height: 12),
                SurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionLabel('TOTAL'),
                      Text(
                        '${MoneyMath.format(snapShot.spent, fx.baseCurrency)} / ${MoneyMath.format(snapShot.limit, fx.baseCurrency)}',
                      ),
                      Text(
                        '${(snapShot.ratio * 100).toStringAsFixed(0)}%',
                        style: TextStyle(color: snapShot.over ? context.colors.warning : context.colors.textPrimary),
                      ),
                      LinearProgressIndicator(
                        value: snapShot.ratio.clamp(0, 1),
                        color: snapShot.over ? context.colors.warning : context.colors.accent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: totalCtrl,
                  decoration: const InputDecoration(labelText: 'Monthly total budget'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () async {
                    final v = double.tryParse(totalCtrl.text);
                    if (v == null) return;
                    await ref.read(financeRepoProvider).upsertBudget(
                          id: 'budget-total',
                          scope: 'total',
                          amount: v,
                          currency: fx.baseCurrency,
                        );
                    ref.invalidate(budgetsProvider);
                  },
                  child: const Text('SAVE TOTAL'),
                ),
                const SizedBox(height: 24),
                const SectionLabel('CATEGORY BUDGETS'),
                const SizedBox(height: 8),
                for (final cat in CategorySlug.values) ...[
                  Builder(builder: (_) {
                    final spentCat = byCat[cat.name] ?? 0;
                    final budget = catBudgets[cat.name];
                    final limitCat = budget?.monthlyAmount ?? 0;
                    final snap = BudgetEngine.total(spentCat, limitCat <= 0 ? spentCat : limitCat, fx.baseCurrency);
                    final over = limitCat > 0 && spentCat > limitCat;
                    final ctrl = _ctrlFor(cat.name, budget?.monthlyAmount);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SurfaceCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(cat.label, style: AppTypography.label(context.colors.textPrimary))),
                                if (over) StatusMark('OVER', tone: context.colors.warning),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              limitCat <= 0
                                  ? '${MoneyMath.format(spentCat, fx.baseCurrency)} / —'
                                  : '${MoneyMath.format(spentCat, fx.baseCurrency)} / ${MoneyMath.format(limitCat, fx.baseCurrency)}',
                            ),
                            if (limitCat > 0) ...[
                              Text('${(snap.ratio * 100).toStringAsFixed(0)}%'),
                              LinearProgressIndicator(
                                value: snap.ratio.clamp(0, 1),
                                color: over ? context.colors.warning : context.colors.accent,
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: ctrl,
                                    decoration: const InputDecoration(labelText: 'Limit', isDense: true),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                FilledButton(
                                  onPressed: () async {
                                    final v = double.tryParse(ctrl.text);
                                    if (v == null || v <= 0) {
                                      if (budget != null) {
                                        await ref.read(financeRepoProvider).deleteBudget(budget.id);
                                      }
                                    } else {
                                      await ref.read(financeRepoProvider).upsertBudget(
                                            id: 'budget-cat-${cat.name}',
                                            scope: 'category',
                                            categoryId: cat.name,
                                            amount: v,
                                            currency: fx.baseCurrency,
                                          );
                                    }
                                    ref.invalidate(budgetsProvider);
                                  },
                                  child: const Text('SAVE'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
