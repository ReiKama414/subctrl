class BillingMath {
  /// Adds [months] using last-day clamping: 31 Jan → 28/29 Feb, then 28 Mar
  /// unless a later custom rule is supplied by the caller.
  static DateTime addMonthsClamped(DateTime date, int months) {
    final total = date.month - 1 + months;
    final year = date.year + (total / 12).floor();
    final month = (total % 12) + 1;
    final lastDay = DateTime(year, month + 1, 0).day;
    final day = date.day < lastDay ? date.day : lastDay;
    return DateTime(
      year,
      month,
      day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }

  /// Preset keys used by the add-subscription offer step:
  /// 7 / 14 / 30 = calendar days; 60 / 90 / 180 / 365 = 2 / 3 / 6 / 12 months.
  static DateTime addFreePeriod(DateTime start, int presetDays) {
    final from = dateOnly(start);
    switch (presetDays) {
      case 60:
        return addMonthsClamped(from, 2);
      case 90:
        return addMonthsClamped(from, 3);
      case 180:
        return addMonthsClamped(from, 6);
      case 365:
        return addMonthsClamped(from, 12);
      default:
        return from.add(Duration(days: presetDays));
    }
  }

  static DateTime addCycle(
    DateTime from, {
    required String cycle,
    int interval = 1,
    int? customDays,
  }) {
    switch (cycle) {
      case 'daily':
        return from.add(Duration(days: interval));
      case 'weekly':
        return from.add(Duration(days: 7 * interval));
      case 'monthly':
        return addMonthsClamped(from, interval);
      case 'quarterly':
        return addMonthsClamped(from, 3 * interval);
      case 'semiannual':
        return addMonthsClamped(from, 6 * interval);
      case 'yearly':
        return addMonthsClamped(from, 12 * interval);
      case 'custom':
        return from.add(Duration(days: (customDays ?? 30) * interval));
      default:
        return addMonthsClamped(from, interval);
    }
  }

  static double monthlyEquivalent(double amount, String cycle, {int? customDays}) {
    switch (cycle) {
      case 'daily':
        return amount * 30.437;
      case 'weekly':
        return amount * (365.25 / 7 / 12);
      case 'monthly':
        return amount;
      case 'quarterly':
        return amount / 3;
      case 'semiannual':
        return amount / 6;
      case 'yearly':
        return amount / 12;
      case 'custom':
        final days = customDays ?? 30;
        return amount * (30.437 / days);
      default:
        return amount;
    }
  }

  static double yearlyEquivalent(double amount, String cycle, {int? customDays}) {
    return monthlyEquivalent(amount, cycle, customDays: customDays) * 12;
  }

  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static bool isLeapYear(int year) =>
      (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;

  static DateTime applySafetyBuffer(DateTime officialDeadline, int bufferDays) {
    return dateOnly(officialDeadline).subtract(Duration(days: bufferDays));
  }

  static int daysUntil(DateTime target, DateTime now) {
    return dateOnly(target).difference(dateOnly(now)).inDays;
  }
}
