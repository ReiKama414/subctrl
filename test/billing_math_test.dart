import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/core/utils/billing_math.dart';

void main() {
  test('month-end billing clamps January 31 to February 28', () {
    expect(BillingMath.addMonthsClamped(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
  });

  test('February 28 monthly goes to March 28', () {
    expect(BillingMath.addMonthsClamped(DateTime(2026, 2, 28), 1), DateTime(2026, 3, 28));
  });

  test('leap year February 29', () {
    expect(BillingMath.addMonthsClamped(DateTime(2024, 1, 31), 1), DateTime(2024, 2, 29));
    expect(BillingMath.isLeapYear(2024), isTrue);
    expect(BillingMath.isLeapYear(2026), isFalse);
  });

  test('yearly billing', () {
    expect(BillingMath.addCycle(DateTime(2026, 10, 6), cycle: 'yearly'), DateTime(2027, 10, 6));
  });

  test('monthly equivalent', () {
    expect(BillingMath.monthlyEquivalent(240, 'yearly'), 20);
    expect(BillingMath.monthlyEquivalent(120, 'semiannual'), 20);
    expect(BillingMath.monthlyEquivalent(60, 'quarterly'), 20);
    expect(BillingMath.monthlyEquivalent(20, 'monthly'), 20);
    expect(BillingMath.yearlyEquivalent(20, 'monthly'), 240);
  });

  test('semiannual billing advances six months', () {
    expect(BillingMath.addCycle(DateTime(2026, 1, 15), cycle: 'semiannual'), DateTime(2026, 7, 15));
  });

  test('cancel safety buffer is independent of trial end', () {
    final official = DateTime(2026, 11, 29);
    expect(BillingMath.applySafetyBuffer(official, 2), DateTime(2026, 11, 27));
  });

  test('days until', () {
    expect(BillingMath.daysUntil(DateTime(2026, 11, 30), DateTime(2026, 11, 27)), 3);
  });
}
