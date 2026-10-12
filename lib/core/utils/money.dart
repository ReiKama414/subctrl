import 'package:intl/intl.dart';
import 'package:subctrl/core/constants/currencies.dart';

class MoneyMath {
  static double round(double value, int decimals) {
    final factor = _pow10(decimals);
    return (value * factor).round() / factor;
  }

  static double _pow10(int n) {
    var r = 1.0;
    for (var i = 0; i < n; i++) {
      r *= 10;
    }
    return r;
  }

  /// Convert [amount] from [from] to [to] using USD-normalized rates.
  /// [ratesVsUsd] maps currency code → units per 1 USD (e.g. TWD: 32.6).
  static double convert({
    required double amount,
    required String from,
    required String to,
    required Map<String, double> ratesVsUsd,
  }) {
    if (from == to) return amount;
    final fromRate = ratesVsUsd[from] ?? AppCurrencies.usdFallbacks[from];
    final toRate = ratesVsUsd[to] ?? AppCurrencies.usdFallbacks[to];
    if (fromRate == null || toRate == null || fromRate == 0) return amount;
    final usd = amount / fromRate;
    return usd * toRate;
  }

  static double rateBetween(String from, String to, Map<String, double> ratesVsUsd) {
    if (from == to) return 1;
    return convert(amount: 1, from: from, to: to, ratesVsUsd: ratesVsUsd);
  }

  static double applyForeignFee(double convertedAmount, double feePercent) {
    return convertedAmount * (feePercent / 100.0);
  }

  static double estimatedCharge(double convertedAmount, double feePercent) {
    return convertedAmount + applyForeignFee(convertedAmount, feePercent);
  }

  static String format(double amount, String currency, {bool compact = false}) {
    final info = AppCurrencies.of(currency);
    final decimals = info.decimals;
    final pattern = decimals == 0 ? '#,##0' : '#,##0.${'0' * decimals}';
    final number = NumberFormat(pattern).format(round(amount, decimals));
    if (compact) return number;
    return '${info.symbol} $number';
  }

  static String percentChange(double oldPrice, double newPrice) {
    if (oldPrice == 0) return '—';
    final pct = ((newPrice - oldPrice) / oldPrice) * 100;
    final sign = pct >= 0 ? '+' : '';
    return '$sign${pct.toStringAsFixed(1)}%';
  }
}
