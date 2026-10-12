import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:subctrl/core/constants/currencies.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/catalog_repository.dart';

class FxService {
  FxService(this.finance, this.settings);
  final FinanceRepository finance;
  final SettingsRepository settings;

  Future<FxUpdateResult> refresh({http.Client? client}) async {
    final c = client ?? http.Client();
    try {
      final res = await c.get(Uri.parse('https://open.er-api.com/v6/latest/USD')).timeout(
            const Duration(seconds: 12),
          );
      if (res.statusCode != 200) {
        return _fail('Exchange rate request failed (${res.statusCode}).');
      }
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      if (body['result'] != 'success') {
        return _fail('Exchange rate provider rejected the request.');
      }
      final rates = (body['rates'] as Map).map((k, v) => MapEntry(k.toString(), (v as num).toDouble()));
      final now = DateTime.now();
      await finance.upsertRates(rates, manual: false, at: now);
      await settings.patch(UserPreferencesCompanion(
        ratesUpdatedAt: Value(now),
        lastFxError: const Value(null),
      ));
      return FxUpdateResult(ok: true, updatedAt: now, rates: rates);
    } catch (_) {
      return _fail('Unable to update exchange rate.');
    } finally {
      if (client == null) c.close();
    }
  }

  Future<FxUpdateResult> _fail(String message) async {
    final prefs = await settings.get();
    await settings.patch(UserPreferencesCompanion(lastFxError: Value(message)));
    return FxUpdateResult(
      ok: false,
      message: message,
      updatedAt: prefs.ratesUpdatedAt,
      rates: await finance.rates(),
    );
  }

  Future<void> overrideRate(String code, double unitsPerUsd) async {
    await finance.upsertRates({code: unitsPerUsd}, manual: true, at: DateTime.now());
    await settings.patch(UserPreferencesCompanion(
      ratesUpdatedAt: Value(DateTime.now()),
      lastFxError: const Value(null),
    ));
  }

  Map<String, double> fallbacks() => Map.of(AppCurrencies.usdFallbacks);
}

class FxUpdateResult {
  FxUpdateResult({required this.ok, this.message, this.updatedAt, this.rates = const {}});
  final bool ok;
  final String? message;
  final DateTime? updatedAt;
  final Map<String, double> rates;
}
