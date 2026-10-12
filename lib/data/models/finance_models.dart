class ConversionQuote {
  const ConversionQuote({
    required this.originalAmount,
    required this.originalCurrency,
    required this.convertedAmount,
    required this.baseCurrency,
    required this.exchangeRate,
    required this.rateUpdatedAt,
    required this.foreignFee,
    required this.estimatedCharge,
    required this.usedFallback,
  });

  final double originalAmount;
  final String originalCurrency;
  final double convertedAmount;
  final String baseCurrency;
  final double exchangeRate;
  final DateTime? rateUpdatedAt;
  final double foreignFee;
  final double estimatedCharge;
  final bool usedFallback;
}

class ForecastMonth {
  const ForecastMonth({
    required this.year,
    required this.month,
    required this.totalBase,
    required this.lines,
  });

  final int year;
  final int month;
  final double totalBase;
  final List<ForecastLine> lines;
}

class ForecastLine {
  const ForecastLine({
    required this.subscriptionId,
    required this.name,
    required this.amountBase,
    required this.reason,
    required this.date,
  });

  final String subscriptionId;
  final String name;
  final double amountBase;
  final String reason;
  final DateTime date;
}

class WhatIfResult {
  const WhatIfResult({
    required this.currentMonthly,
    required this.newMonthly,
    required this.savedMonthly,
    required this.savedYearly,
  });

  final double currentMonthly;
  final double newMonthly;
  final double savedMonthly;
  final double savedYearly;
}

class BudgetSnapshot {
  const BudgetSnapshot({
    required this.spent,
    required this.limit,
    required this.currency,
    this.label = 'TOTAL',
  });

  final double spent;
  final double limit;
  final String currency;
  final String label;

  double get ratio => limit <= 0 ? 0 : spent / limit;
  bool get over => limit > 0 && spent > limit;
}

class CalendarDayEvent {
  const CalendarDayEvent({
    required this.date,
    required this.kind,
    required this.subscriptionId,
    required this.title,
    required this.amountBase,
    required this.currencyLabel,
  });

  final DateTime date;
  final String kind;
  final String subscriptionId;
  final String title;
  final double amountBase;
  final String currencyLabel;
}

class ActionItem {
  const ActionItem({
    required this.kind,
    required this.subscriptionId,
    required this.title,
    required this.headline,
    required this.lines,
  });

  final String kind;
  final String subscriptionId;
  final String title;
  final String headline;
  final List<String> lines;
}

class ChartPoint {
  const ChartPoint({required this.date, required this.official, required this.actual});

  final DateTime date;
  final double official;
  final double actual;
}

class YearReview {
  const YearReview({
    required this.year,
    required this.totalSpent,
    required this.mostExpensiveName,
    required this.biggestIncreaseName,
    required this.cancelledCount,
    required this.estimatedSavings,
    required this.foreignSpend,
  });

  final int year;
  final double totalSpent;
  final String mostExpensiveName;
  final String biggestIncreaseName;
  final int cancelledCount;
  final double estimatedSavings;
  final double foreignSpend;
}
