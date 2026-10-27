import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/core/utils/money.dart';
import 'package:subctrl/data/models/finance_models.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/l10n/app_localizations.dart';

export 'package:subctrl/data/models/finance_models.dart';

class CurrencyEngine {
  CurrencyEngine({
    required this.ratesVsUsd,
    required this.baseCurrency,
    required this.feePercent,
    this.updatedAt,
    this.lastError,
  });

  final Map<String, double> ratesVsUsd;
  final String baseCurrency;
  final double feePercent;
  final DateTime? updatedAt;
  final String? lastError;

  ConversionQuote quote(double amount, String currency) {
    final rate = MoneyMath.rateBetween(currency, baseCurrency, ratesVsUsd);
    final converted = MoneyMath.convert(
      amount: amount,
      from: currency,
      to: baseCurrency,
      ratesVsUsd: ratesVsUsd,
    );
    final fee = currency == baseCurrency ? 0.0 : MoneyMath.applyForeignFee(converted, feePercent);
    return ConversionQuote(
      originalAmount: amount,
      originalCurrency: currency,
      convertedAmount: converted,
      baseCurrency: baseCurrency,
      exchangeRate: rate,
      rateUpdatedAt: updatedAt,
      foreignFee: fee,
      estimatedCharge: converted + fee,
      usedFallback: lastError != null,
    );
  }

  double monthlyBase(SubscriptionView sub, {DateTime? on}) {
    final when = on ?? DateTime.now();
    if (sub.status == SubscriptionStatus.expired || sub.status == SubscriptionStatus.paused) {
      return 0;
    }
    if (sub.status == SubscriptionStatus.cancelled) {
      final end = sub.accessEndDate;
      if (end != null && BillingMath.dateOnly(end).isBefore(BillingMath.dateOnly(when))) {
        return 0;
      }
      if (sub.autoRenew == false) return 0;
    }
    final phase = sub.phaseOn(when);
    final amount = phase?.price ?? sub.currentPrice;
    final currency = phase?.currency ?? sub.currency;
    final cycle = phase?.billingCycle ?? sub.billingCycle;
    final q = quote(amount, currency);
    return BillingMath.monthlyEquivalent(q.estimatedCharge, cycle, customDays: sub.customCycleDays);
  }
}

class ForecastEngine {
  ForecastEngine(this.fx);

  final CurrencyEngine fx;

  List<ForecastMonth> nextTwelveMonths(List<SubscriptionView> subs, {DateTime? from}) {
    final start = BillingMath.dateOnly(from ?? DateTime.now());
    final months = <ForecastMonth>[];
    for (var i = 0; i < 12; i++) {
      final monthDate = DateTime(start.year, start.month + i, 1);
      final lines = <ForecastLine>[];
      for (final sub in subs) {
        lines.addAll(_occurrencesInMonth(sub, monthDate));
      }
      final total = lines.fold<double>(0, (p, e) => p + e.amountBase);
      months.add(ForecastMonth(
        year: monthDate.year,
        month: monthDate.month,
        totalBase: total,
        lines: lines,
      ));
    }
    return months;
  }

  bool _stillPaying(SubscriptionView sub, DateTime date) {
    if (sub.status == SubscriptionStatus.expired || sub.status == SubscriptionStatus.paused) {
      return false;
    }
    if (sub.status == SubscriptionStatus.cancelled) {
      final end = sub.accessEndDate ?? sub.nextBillingDate;
      if (end == null) return false;
      return !BillingMath.dateOnly(date).isAfter(BillingMath.dateOnly(end));
    }
    return true;
  }

  List<ForecastLine> _occurrencesInMonth(SubscriptionView sub, DateTime monthStart) {
    if (!_stillPaying(sub, DateTime(monthStart.year, monthStart.month + 1, 0))) {
      // May still have a charge in this month if next billing is in-month
    }
    final monthEnd = DateTime(monthStart.year, monthStart.month + 1, 0, 23, 59);
    final out = <ForecastLine>[];
    var cursor = sub.nextBillingDate ?? sub.startDate;
    var guard = 0;
    while (cursor.isAfter(monthEnd) && guard < 48) {
      cursor = _previous(sub, cursor);
      guard++;
    }
    guard = 0;
    while (!cursor.isAfter(monthEnd) && guard < 64) {
      if (!cursor.isBefore(monthStart) && _stillPaying(sub, cursor)) {
        final phase = sub.phaseOn(cursor);
        final amount = phase?.price ?? sub.currentPrice;
        final currency = phase?.currency ?? sub.currency;
        final q = fx.quote(amount, currency);
        out.add(ForecastLine(
          subscriptionId: sub.id,
          name: sub.serviceName,
          amountBase: q.estimatedCharge,
          reason: _reason(phase, amount),
          date: cursor,
        ));
      }
      cursor = BillingMath.addCycle(
        cursor,
        cycle: sub.billingCycle,
        customDays: sub.customCycleDays,
      );
      guard++;
    }
    return out;
  }

  DateTime _previous(SubscriptionView sub, DateTime date) {
    switch (sub.billingCycle) {
      case 'weekly':
        return date.subtract(const Duration(days: 7));
      case 'daily':
        return date.subtract(const Duration(days: 1));
      case 'yearly':
        return BillingMath.addMonthsClamped(date, -12);
      case 'semiannual':
        return BillingMath.addMonthsClamped(date, -6);
      case 'quarterly':
        return BillingMath.addMonthsClamped(date, -3);
      default:
        return BillingMath.addMonthsClamped(date, -1);
    }
  }

  String _reason(PhaseView? phase, double amount) {
    if (amount == 0) return 'FREE PERIOD';
    if (phase?.type == PricePhaseType.promo) return phase?.promotionName ?? 'PROMO';
    if (phase?.type == PricePhaseType.free) return 'FREE PERIOD';
    return 'REGULAR';
  }
}

class WhatIfEngine {
  WhatIfEngine(this.fx);
  final CurrencyEngine fx;

  WhatIfResult simulate(List<SubscriptionView> all, Set<String> cancelIds) {
    var current = 0.0;
    var next = 0.0;
    for (final sub in all) {
      final m = fx.monthlyBase(sub);
      current += m;
      if (!cancelIds.contains(sub.id)) next += m;
    }
    return WhatIfResult(
      currentMonthly: current,
      newMonthly: next,
      savedMonthly: current - next,
      savedYearly: (current - next) * 12,
    );
  }
}

class BudgetEngine {
  static BudgetSnapshot total(double spent, double limit, String currency) {
    return BudgetSnapshot(spent: spent, limit: limit, currency: currency);
  }
}

class ActionEngine {
  static List<ActionItem> build(
    List<SubscriptionView> subs,
    List<PaymentMethodView> methods,
    AppLocalizations l10n, {
    DateTime? now,
    int windowDays = 30,
  }) {
    final today = BillingMath.dateOnly(now ?? DateTime.now());
    final items = <ActionItem>[];
    for (final sub in subs) {
      final phase = sub.currentPhase;
      if (sub.needsPriceReview(now: today)) {
        final after = sub.proposedResumePrice(now: today);
        final offer = sub.endedOfferPhase(now: today);
        items.add(ActionItem(
          kind: 'price_review',
          subscriptionId: sub.id,
          title: sub.serviceName,
          headline: l10n.actionPriceReview,
          lines: [
            l10n.actionAfterTrial(
              MoneyMath.format(after, offer?.regularCurrency ?? sub.currency),
              l10n.billingCycleLabel(
                BillingCycle.values.where((c) => c.name == sub.billingCycle).firstOrNull ?? BillingCycle.monthly,
              ),
            ),
          ],
        ));
      }
      if (phase?.trialEndDate != null) {
        final left = BillingMath.daysUntil(phase!.trialEndDate!, today);
        if (left > 0 && left <= windowDays) {
          final after = phase.regularPrice ?? sub.currentPrice;
          items.add(ActionItem(
            kind: 'trial',
            subscriptionId: sub.id,
            title: sub.serviceName,
            headline: l10n.actionFreePeriod,
            lines: [
              l10n.actionDaysLeft(left),
              l10n.actionAfterTrial(
                MoneyMath.format(after, phase.regularCurrency ?? sub.currency),
                l10n.billingCycleLabel(
                  BillingCycle.values.where((c) => c.name == sub.billingCycle).firstOrNull ?? BillingCycle.monthly,
                ),
              ),
              if (phase.cancelDeadline != null)
                l10n.actionCancelBy(_fmt(phase.reminderDate ?? phase.cancelDeadline!)),
            ],
          ));
        }
      }
      if (phase?.type == PricePhaseType.promo && phase?.endDate != null) {
        final left = BillingMath.daysUntil(phase!.endDate!, today);
        if (left > 0 && left <= windowDays) {
          items.add(ActionItem(
            kind: 'promo',
            subscriptionId: sub.id,
            title: sub.serviceName,
            headline: l10n.actionPromoEnds,
            lines: [
              l10n.actionDays(left),
              l10n.actionCurrent(MoneyMath.format(phase.price, phase.currency)),
              l10n.actionAfter(
                MoneyMath.format(phase.regularPrice ?? sub.currentPrice, phase.regularCurrency ?? sub.currency),
              ),
            ],
          ));
        }
      }
      if (phase?.cancelDeadline != null) {
        final left = BillingMath.daysUntil(phase!.cancelDeadline!, today);
        if (left >= 0 && left <= windowDays) {
          items.add(ActionItem(
            kind: 'deadline',
            subscriptionId: sub.id,
            title: sub.serviceName,
            headline: l10n.actionCancelDeadline,
            lines: [
              _fmt(phase.cancelDeadline!),
              if (phase.reminderDate != null) l10n.actionReminder(_fmt(phase.reminderDate!)),
            ],
          ));
        }
      }
      if (sub.nextBillingDate != null &&
          sub.status != SubscriptionStatus.expired &&
          sub.currentPrice > 0) {
        final left = BillingMath.daysUntil(sub.nextBillingDate!, today);
        if (left >= 0 && left <= 14) {
          items.add(ActionItem(
            kind: 'renewal',
            subscriptionId: sub.id,
            title: sub.serviceName,
            headline: l10n.actionRenews(_fmt(sub.nextBillingDate!)),
            lines: [MoneyMath.format(sub.currentPrice, sub.currency)],
          ));
        }
      }
      if (phase?.firstChargeDate != null) {
        final left = BillingMath.daysUntil(phase!.firstChargeDate!, today);
        if (left >= 0 && left <= windowDays) {
          items.add(ActionItem(
            kind: 'first_charge',
            subscriptionId: sub.id,
            title: sub.serviceName,
            headline: l10n.actionFirstCharge,
            lines: [_fmt(phase.firstChargeDate!), MoneyMath.format(sub.currentPrice, sub.currency)],
          ));
        }
      }
    }
    for (final method in methods) {
      if (method.expiry == null) continue;
      final left = BillingMath.daysUntil(method.expiry!, today);
      if (left >= 0 && left <= 45) {
        items.add(ActionItem(
          kind: 'card_expiry',
          subscriptionId: '',
          title: method.display,
          headline: l10n.actionCardExpiry,
          lines: [_fmt(method.expiry!), l10n.actionDays(left)],
        ));
      }
    }
    return items;
  }

  static String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class CalendarEngine {
  static List<CalendarDayEvent> events(
    List<SubscriptionView> subs,
    CurrencyEngine fx, {
    required DateTime month,
  }) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0);
    final out = <CalendarDayEvent>[];
    for (final sub in subs) {
      if (sub.nextBillingDate != null && _in(sub.nextBillingDate!, start, end)) {
        final q = fx.quote(sub.currentPrice, sub.currency);
        out.add(CalendarDayEvent(
          date: BillingMath.dateOnly(sub.nextBillingDate!),
          kind: CalendarEventKind.payment.name,
          subscriptionId: sub.id,
          title: sub.serviceName,
          amountBase: q.estimatedCharge,
          currencyLabel: MoneyMath.format(q.estimatedCharge, fx.baseCurrency),
        ));
      }
      for (final phase in sub.phases) {
        void add(DateTime? d, CalendarEventKind kind) {
          if (d == null || !_in(d, start, end)) return;
          out.add(CalendarDayEvent(
            date: BillingMath.dateOnly(d),
            kind: kind.name,
            subscriptionId: sub.id,
            title: sub.serviceName,
            amountBase: 0,
            currencyLabel: kind.name.replaceAll('_', ' ').toUpperCase(),
          ));
        }

        add(phase.trialEndDate, CalendarEventKind.trialEnd);
        add(phase.endDate, phase.type == PricePhaseType.promo ? CalendarEventKind.promoEnd : CalendarEventKind.priceChange);
        add(phase.cancelDeadline, CalendarEventKind.cancelDeadline);
      }
      if (sub.accessEndDate != null &&
          (sub.status == SubscriptionStatus.cancelled || sub.status == SubscriptionStatus.expired) &&
          _in(sub.accessEndDate!, start, end)) {
        out.add(CalendarDayEvent(
          date: BillingMath.dateOnly(sub.accessEndDate!),
          kind: CalendarEventKind.expiry.name,
          subscriptionId: sub.id,
          title: sub.serviceName,
          amountBase: 0,
          currencyLabel: 'EXPIRY',
        ));
      }
    }
    out.sort((a, b) => a.date.compareTo(b.date));
    return out;
  }

  static bool _in(DateTime d, DateTime start, DateTime end) {
    final x = BillingMath.dateOnly(d);
    return !x.isBefore(start) && !x.isAfter(end);
  }
}

class ChartEngine {
  static List<ChartPoint> series({
    required List<PriceHistoryView> history,
    required List<PaymentView> payments,
    required ChartRange range,
    required DateTime now,
  }) {
    DateTime from;
    switch (range) {
      case ChartRange.months3:
        from = BillingMath.addMonthsClamped(now, -3);
      case ChartRange.months6:
        from = BillingMath.addMonthsClamped(now, -6);
      case ChartRange.year1:
        from = BillingMath.addMonthsClamped(now, -12);
      case ChartRange.all:
        from = DateTime(2000);
    }
    final points = <ChartPoint>[];
    final hist = history.where((h) => !h.effectiveDate.isBefore(from)).toList()
      ..sort((a, b) => a.effectiveDate.compareTo(b.effectiveDate));
    for (final h in hist) {
      final pay = payments.where((p) => BillingMath.dateOnly(p.date) == BillingMath.dateOnly(h.effectiveDate));
      points.add(ChartPoint(
        date: h.effectiveDate,
        official: h.newPrice,
        actual: pay.isEmpty ? h.newPrice : pay.first.originalAmount,
      ));
    }
    for (final p in payments.where((p) => !p.date.isBefore(from))) {
      if (points.any((c) => BillingMath.dateOnly(c.date) == BillingMath.dateOnly(p.date))) continue;
      points.add(ChartPoint(date: p.date, official: p.originalAmount, actual: p.originalAmount));
    }
    points.sort((a, b) => a.date.compareTo(b.date));
    return points;
  }
}
