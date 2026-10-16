import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/l10n/app_localizations.dart';

import 'support.dart';

void main() {
  test('USD to TWD conversion keeps original amount', () {
    const rates = {'USD': 1.0, 'TWD': 32.6};
    final converted = MoneyMath.convert(amount: 20, from: 'USD', to: 'TWD', ratesVsUsd: rates);
    expect(converted, closeTo(652, 0.01));
    expect(MoneyMath.estimatedCharge(converted, 1.5), closeTo(661.78, 0.05));
  });

  test('same currency conversion is identity', () {
    expect(MoneyMath.convert(amount: 199, from: 'TWD', to: 'TWD', ratesVsUsd: {'TWD': 32.6, 'USD': 1}), 199);
  });

  test('percent change', () {
    expect(MoneyMath.percentChange(18, 20), '+11.1%');
  });

  test('trial phase is free until trial end', () {
    final sub = sampleSub(
      status: SubscriptionStatus.trial,
      price: 20,
      phases: [
        PhaseView(
          id: 'p1',
          subscriptionId: 's1',
          type: PricePhaseType.free,
          startDate: DateTime(2026, 9, 27),
          endDate: DateTime(2026, 10, 27),
          price: 0,
          currency: 'USD',
          billingCycle: 'monthly',
          trialEndDate: DateTime(2026, 10, 27),
          cancelDeadline: DateTime(2026, 10, 26),
          firstChargeDate: DateTime(2026, 10, 28),
          regularPrice: 20,
        ),
      ],
    );
    expect(sub.phaseOn(DateTime(2026, 10, 10))?.price, 0);
    expect(sub.phaseOn(DateTime(2026, 10, 28))?.price, isNull);
  });

  test('forecast includes monthly charge', () {
    final fx = CurrencyEngine(ratesVsUsd: const {'USD': 1, 'TWD': 32.6}, baseCurrency: 'TWD', feePercent: 0);
    final months = ForecastEngine(fx).nextTwelveMonths(
      [sampleSub(next: DateTime(2026, 10, 15), start: DateTime(2026, 1, 15))],
      from: DateTime(2026, 10, 1),
    );
    expect(months.first.totalBase, greaterThan(0));
    expect(months.length, 12);
  });

  test('what-if simulator', () {
    final fx = CurrencyEngine(ratesVsUsd: const {'USD': 1, 'TWD': 1}, baseCurrency: 'TWD', feePercent: 0);
    final a = sampleSub(id: 'a', name: 'Netflix', price: 300, currency: 'TWD');
    final b = sampleSub(id: 'b', name: 'ChatGPT', price: 20, currency: 'USD');
    final r = WhatIfEngine(fx).simulate([a, b], {'a'});
    expect(r.savedMonthly, closeTo(fx.monthlyBase(a), 0.01));
    expect(r.newMonthly, closeTo(fx.monthlyBase(b), 0.01));
    expect(r.savedYearly, closeTo(r.savedMonthly * 12, 0.01));
  });

  test('budget over flag', () {
    final snap = BudgetEngine.total(4286, 5000, 'TWD');
    expect(snap.over, isFalse);
    expect(BudgetEngine.total(5100, 5000, 'TWD').over, isTrue);
  });

  test('promo transition uses later regular price', () {
    final sub = sampleSub(
      status: SubscriptionStatus.promo,
      price: 10,
      phases: [
        PhaseView(
          id: 'promo',
          subscriptionId: 's1',
          type: PricePhaseType.promo,
          startDate: DateTime(2026, 8, 1),
          endDate: DateTime(2026, 10, 31),
          price: 10,
          currency: 'USD',
          billingCycle: 'monthly',
          regularPrice: 20,
        ),
        PhaseView(
          id: 'reg',
          subscriptionId: 's1',
          type: PricePhaseType.regular,
          startDate: DateTime(2026, 11, 1),
          price: 20,
          currency: 'USD',
          billingCycle: 'monthly',
        ),
      ],
    );
    expect(sub.phaseOn(DateTime(2026, 10, 15))?.price, 10);
    expect(sub.phaseOn(DateTime(2026, 11, 2))?.price, 20);
  });

  test('action required sees trial ending', () {
    final items = ActionEngine.build(
      [
        sampleSub(
          status: SubscriptionStatus.trial,
          phases: [
            PhaseView(
              id: 't',
              subscriptionId: 's1',
              type: PricePhaseType.free,
              startDate: DateTime.now().subtract(const Duration(days: 10)),
              endDate: DateTime.now().add(const Duration(days: 3)),
              price: 0,
              currency: 'USD',
              billingCycle: 'monthly',
              trialEndDate: DateTime.now().add(const Duration(days: 3)),
              cancelDeadline: DateTime.now().add(const Duration(days: 2)),
              regularPrice: 20,
            ),
          ],
        ),
      ],
      const [],
      AppLocalizations(const Locale('en')),
    );
    expect(items.any((e) => e.kind == 'trial'), isTrue);
  });
}
