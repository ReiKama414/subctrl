class CurrencyInfo {
  const CurrencyInfo({
    required this.code,
    required this.symbol,
    required this.name,
    this.decimals = 2,
  });

  final String code;
  final String symbol;
  final String name;
  final int decimals;
}

class AppCurrencies {
  static const twd = CurrencyInfo(code: 'TWD', symbol: 'NT\$', name: 'New Taiwan Dollar', decimals: 0);
  static const usd = CurrencyInfo(code: 'USD', symbol: 'US\$', name: 'US Dollar');
  static const jpy = CurrencyInfo(code: 'JPY', symbol: '¥', name: 'Japanese Yen', decimals: 0);
  static const eur = CurrencyInfo(code: 'EUR', symbol: '€', name: 'Euro');
  static const gbp = CurrencyInfo(code: 'GBP', symbol: '£', name: 'British Pound');
  static const hkd = CurrencyInfo(code: 'HKD', symbol: 'HK\$', name: 'Hong Kong Dollar');
  static const cny = CurrencyInfo(code: 'CNY', symbol: 'CN¥', name: 'Chinese Yuan');
  static const krw = CurrencyInfo(code: 'KRW', symbol: '₩', name: 'South Korean Won', decimals: 0);
  static const sgd = CurrencyInfo(code: 'SGD', symbol: 'S\$', name: 'Singapore Dollar');
  static const aud = CurrencyInfo(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar');
  static const cad = CurrencyInfo(code: 'CAD', symbol: 'C\$', name: 'Canadian Dollar');

  static const featured = [twd, usd, jpy, eur, gbp, hkd, cny, krw, sgd, aud, cad];

  static const iso = [
    'TWD', 'USD', 'JPY', 'EUR', 'GBP', 'HKD', 'CNY', 'KRW', 'SGD', 'AUD', 'CAD',
    'CHF', 'NZD', 'SEK', 'NOK', 'DKK', 'INR', 'THB', 'MYR', 'PHP', 'IDR', 'VND',
    'MXN', 'BRL', 'ZAR', 'PLN', 'TRY', 'AED', 'SAR',
  ];

  static CurrencyInfo of(String code) {
    for (final item in featured) {
      if (item.code == code) return item;
    }
    return CurrencyInfo(code: code, symbol: code, name: code);
  }

  /// Approximate USD-based fallbacks used until a live rate is stored.
  static const Map<String, double> usdFallbacks = {
    'USD': 1,
    'TWD': 32.60,
    'JPY': 149.80,
    'EUR': 0.92,
    'GBP': 0.78,
    'HKD': 7.78,
    'CNY': 7.12,
    'KRW': 1350,
    'SGD': 1.31,
    'AUD': 1.52,
    'CAD': 1.37,
    'CHF': 0.88,
    'NZD': 1.66,
    'SEK': 10.40,
    'NOK': 10.70,
    'DKK': 6.85,
    'INR': 83.50,
    'THB': 35.20,
    'MYR': 4.45,
    'PHP': 57.20,
    'IDR': 15600,
    'VND': 25400,
    'MXN': 17.80,
    'BRL': 5.45,
    'ZAR': 18.10,
    'PLN': 3.95,
    'TRY': 32.80,
    'AED': 3.67,
    'SAR': 3.75,
  };
}
