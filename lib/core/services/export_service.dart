import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:subctrl/core/config/app_env.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/data/repositories/catalog_repository.dart';
import 'package:subctrl/data/repositories/purchase_repository.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class ExportService {
  ExportService(this.db, this.subs, this.finance, this.purchases);
  final AppDatabase db;
  final SubscriptionRepository subs;
  final FinanceRepository finance;
  final PurchaseRepository purchases;
  final _uuid = const Uuid();

  Future<Map<String, dynamic>> toJsonMap() async {
    final list = await subs.listAll();
    final payments = await finance.payments();
    final methods = await finance.methods();
    final budgets = await finance.budgets();
    final orderList = await purchases.listAll();
    final payload = <String, dynamic>{
      'version': 2,
      'exportedAt': DateTime.now().toIso8601String(),
      'subscriptions': [
        for (final s in list)
          {
            'id': s.id,
            'serviceId': s.serviceId,
            'serviceName': s.serviceName,
            'planId': s.planId,
            'categoryId': s.categoryId,
            'profileId': s.profileId,
            'status': s.status.name,
            'startDate': s.startDate.toIso8601String(),
            'nextBillingDate': s.nextBillingDate?.toIso8601String(),
            'accessEndDate': s.accessEndDate?.toIso8601String(),
            'autoRenew': s.autoRenew,
            'currency': s.currency,
            'currentPrice': s.currentPrice,
            'billingCycle': s.billingCycle,
            'customCycleDays': s.customCycleDays,
            'paymentMethodId': s.paymentMethodId,
            'renewalIntent': s.renewalIntent.name,
            'usageFrequency': s.usageFrequency.name,
            'usageCountPerMonth': s.usageCountPerMonth,
            'officialWebsiteUrl': s.officialWebsiteUrl,
            'manageSubscriptionUrl': s.manageSubscriptionUrl,
            'notes': s.notes,
            'createdAt': s.createdAt.toIso8601String(),
            'updatedAt': s.updatedAt.toIso8601String(),
            'phases': [
              for (final p in s.phases)
                {
                  'id': p.id,
                  'type': p.type.name,
                  'startDate': p.startDate.toIso8601String(),
                  'endDate': p.endDate?.toIso8601String(),
                  'price': p.price,
                  'currency': p.currency,
                  'billingCycle': p.billingCycle,
                  'regularPrice': p.regularPrice,
                  'regularCurrency': p.regularCurrency,
                  'promotionName': p.promotionName,
                  'cancelDeadline': p.cancelDeadline?.toIso8601String(),
                  'firstChargeDate': p.firstChargeDate?.toIso8601String(),
                  'trialEndDate': p.trialEndDate?.toIso8601String(),
                  'reminderDate': p.reminderDate?.toIso8601String(),
                  'autoRenew': p.autoRenew,
                },
            ],
            'events': [
              for (final e in await subs.events(s.id))
                {
                  'id': e.id,
                  'type': e.type.name,
                  'at': e.at.toIso8601String(),
                  'title': e.title,
                  'detail': e.detail,
                },
            ],
            'reminders': [
              for (final r in await subs.remindersFor(s.id))
                {
                  'id': r.id,
                  'kind': r.kind.name,
                  'offsetKind': r.offset.name,
                  'customDays': r.customDays,
                  'fireAt': r.fireAt.toIso8601String(),
                  'enabled': r.enabled,
                  'notificationId': r.notificationId,
                },
            ],
            'priceHistory': [
              for (final h in await subs.priceHistory(s.id))
                {
                  'id': h.id,
                  'oldPrice': h.oldPrice,
                  'newPrice': h.newPrice,
                  'currency': h.currency,
                  'effectiveDate': h.effectiveDate.toIso8601String(),
                  'reason': h.reason,
                },
            ],
          },
      ],
      'payments': [
        for (final p in payments)
          {
            'id': p.id,
            'subscriptionId': p.subscriptionId,
            'date': p.date.toIso8601String(),
            'originalAmount': p.originalAmount,
            'originalCurrency': p.originalCurrency,
            'exchangeRate': p.exchangeRate,
            'convertedAmount': p.convertedAmount,
            'baseCurrency': p.baseCurrency,
            'foreignFee': p.foreignFee,
            'actualChargedAmount': p.actualChargedAmount,
            'paymentMethodId': p.paymentMethodId,
            'note': p.note,
          },
      ],
      'paymentMethods': [
        for (final m in methods)
          {
            'id': m.id,
            'label': m.label,
            'type': m.type.name,
            'brand': m.brand,
            'last4': m.last4,
            'expiry': m.expiry?.toIso8601String(),
          },
      ],
      'budgets': [
        for (final b in budgets)
          {
            'id': b.id,
            'scope': b.scope,
            'categoryId': b.categoryId,
            'profileId': b.profileId,
            'monthlyAmount': b.monthlyAmount,
            'currency': b.currency,
          },
      ],
      'purchaseOrders': [
        for (final o in orderList)
          {
            'id': o.id,
            'profileId': o.profileId,
            'platform': o.platform,
            'title': o.title,
            'quantity': o.quantity,
            'status': o.status.name,
            'orderKind': o.orderKind.name,
            'orderedAt': o.orderedAt.toIso8601String(),
            'expectedAt': o.expectedAt?.toIso8601String(),
            'deliveredAt': o.deliveredAt?.toIso8601String(),
            'reminderAt': o.reminderAt?.toIso8601String(),
            'price': o.price,
            'depositPaid': o.depositPaid,
            'balanceDue': o.balanceDue,
            'shippingFee': o.shippingFee,
            'serviceFee': o.serviceFee,
            'currency': o.currency,
            'sellerName': o.sellerName,
            'orderNumber': o.orderNumber,
            'trackingNumber': o.trackingNumber,
            'trackingUrl': o.trackingUrl,
            'forwarder': o.forwarder,
            'paymentNote': o.paymentNote,
            'notes': o.notes,
            'createdAt': o.createdAt.toIso8601String(),
            'updatedAt': o.updatedAt.toIso8601String(),
            'events': [
              for (final e in await purchases.eventsFor(o.id))
                {
                  'id': e.id,
                  'type': e.type.name,
                  'at': e.at.toIso8601String(),
                  'title': e.title,
                  'detail': e.detail,
                },
            ],
          },
      ],
    };
    return payload;
  }

  String toCsv(List<SubscriptionView> subs, List<PurchaseOrderView> orders) {
    final buf = StringBuffer();
    buf.writeln('# subscriptions');
    buf.writeln('id,service,status,price,currency,cycle,next_billing,profile');
    for (final s in subs) {
      buf.writeln(
        '${s.id},${_csv(s.serviceName)},${s.status.name},${s.currentPrice},${s.currency},${s.billingCycle},${s.nextBillingDate?.toIso8601String() ?? ''},${s.profileId}',
      );
    }
    buf.writeln();
    buf.writeln('# purchase_orders');
    buf.writeln('id,platform,item,status,price,currency,profile,expected_at');
    for (final o in orders) {
      buf.writeln(
        '${o.id},${_csv(o.platform)},${_csv(o.title)},${o.status.name},${o.price ?? ''},${o.currency ?? ''},${o.profileId},${o.expectedAt?.toIso8601String() ?? ''}',
      );
    }
    return buf.toString();
  }

  String _csv(String v) => '"${v.replaceAll('"', '""')}"';

  Future<void> shareJson() async {
    final json = const JsonEncoder.withIndent('  ').convert(await toJsonMap());
    await _share('subctrl-export.json', json);
  }

  Future<void> shareCsv() async {
    final body = toCsv(await subs.listAll(), await purchases.listAll());
    await _share('subctrl-export.csv', body);
  }

  Future<String> backupPath() async {
    if (kIsWeb) return 'subctrl-backup.json';
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/subctrl-backup.json';
  }

  Future<String> backupFile() async {
    final json = const JsonEncoder.withIndent('  ').convert(await toJsonMap());
    if (kIsWeb) return json;
    final path = await backupPath();
    await File(path).writeAsString(json);
    return path;
  }

  Future<String?> readLocalBackup() async {
    if (kIsWeb) return null;
    final file = File(await backupPath());
    if (!await file.exists()) return null;
    return file.readAsString();
  }

  /// Overwrites local subscription ledger data from a backup JSON string.
  /// Does not import auth tokens. Catalog builtin services are preserved.
  Future<RestoreResult> restoreFromJson(String raw, {required bool confirmedOverwrite}) async {
    if (!confirmedOverwrite) {
      throw const RestoreNeedsConfirmation();
    }
    late final Map<String, dynamic> payload;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const RestoreFormatError('Backup root must be a JSON object.');
      }
      payload = decoded;
    } on FormatException {
      throw const RestoreFormatError('Invalid JSON backup.');
    }

    final subList = payload['subscriptions'];
    if (subList is! List) {
      throw const RestoreFormatError('Backup missing subscriptions array.');
    }

    await _clearLedger();

    final methods = payload['paymentMethods'];
    if (methods is List) {
      for (final rawMethod in methods) {
        if (rawMethod is! Map) continue;
        final m = Map<String, dynamic>.from(rawMethod);
        await db.into(db.paymentMethods).insert(
              PaymentMethodsCompanion.insert(
                id: (m['id'] as String?) ?? _uuid.v4(),
                label: (m['label'] as String?) ?? 'Card',
                type: (m['type'] as String?) ?? PaymentMethodType.other.name,
                brand: (m['brand'] as String?) ?? 'Other',
                last4: Value(m['last4'] as String?),
                expiry: Value(_parseDate(m['expiry'])),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    }

    final budgets = payload['budgets'];
    if (budgets is List) {
      for (final rawBudget in budgets) {
        if (rawBudget is! Map) continue;
        final b = Map<String, dynamic>.from(rawBudget);
        await finance.upsertBudget(
          id: (b['id'] as String?) ?? _uuid.v4(),
          scope: (b['scope'] as String?) ?? 'total',
          categoryId: b['categoryId'] as String?,
          amount: (b['monthlyAmount'] as num?)?.toDouble() ?? 0,
          currency: (b['currency'] as String?) ?? 'TWD',
        );
      }
    }

    final orderList = payload['purchaseOrders'];
    if (orderList is List) {
      for (final raw in orderList) {
        if (raw is! Map) continue;
        final o = Map<String, dynamic>.from(raw);
        final events = o['events'];
        await purchases.restoreOrder(
          o,
          eventList: events is List ? events.map((e) => Map<String, dynamic>.from(e as Map)).toList() : null,
        );
      }
    }

    var restored = 0;
    for (final rawSub in subList) {
      if (rawSub is! Map) continue;
      final s = Map<String, dynamic>.from(rawSub);
      final serviceId = await _ensureService(s);
      final id = (s['id'] as String?) ?? _uuid.v4();
      final now = DateTime.now();
      await db.into(db.subscriptions).insert(
            SubscriptionsCompanion.insert(
              id: id,
              serviceId: serviceId,
              planId: Value(s['planId'] as String?),
              categoryId: (s['categoryId'] as String?) ?? 'other',
              profileId: (s['profileId'] as String?) ?? personalProfileId,
              status: (s['status'] as String?) ?? SubscriptionStatus.active.name,
              startDate: _parseDate(s['startDate']) ?? now,
              nextBillingDate: Value(_parseDate(s['nextBillingDate'])),
              accessEndDate: Value(_parseDate(s['accessEndDate'])),
              autoRenew: Value(s['autoRenew'] as bool? ?? true),
              currency: (s['currency'] as String?) ?? 'TWD',
              currentPrice: (s['currentPrice'] as num?)?.toDouble() ?? 0,
              billingCycle: (s['billingCycle'] as String?) ?? 'monthly',
              customCycleDays: Value(s['customCycleDays'] as int?),
              paymentMethodId: Value(s['paymentMethodId'] as String?),
              renewalIntent: (s['renewalIntent'] as String?) ?? RenewalIntent.undecided.name,
              usageFrequency: (s['usageFrequency'] as String?) ?? UsageFrequency.monthly.name,
              usageCountPerMonth: Value(s['usageCountPerMonth'] as int?),
              officialWebsiteUrl: Value(s['officialWebsiteUrl'] as String?),
              manageSubscriptionUrl: Value(s['manageSubscriptionUrl'] as String?),
              notes: Value(s['notes'] as String?),
              createdAt: _parseDate(s['createdAt']) ?? now,
              updatedAt: _parseDate(s['updatedAt']) ?? now,
            ),
            mode: InsertMode.insertOrReplace,
          );

      final phases = s['phases'];
      if (phases is List) {
        var i = 0;
        for (final rawPhase in phases) {
          if (rawPhase is! Map) continue;
          final p = Map<String, dynamic>.from(rawPhase);
          await db.into(db.pricePhases).insert(
                PricePhasesCompanion.insert(
                  id: (p['id'] as String?) ?? _uuid.v4(),
                  subscriptionId: id,
                  type: (p['type'] as String?) ?? PricePhaseType.regular.name,
                  startDate: _parseDate(p['startDate']) ?? now,
                  endDate: Value(_parseDate(p['endDate'])),
                  price: (p['price'] as num?)?.toDouble() ?? 0,
                  currency: (p['currency'] as String?) ?? 'TWD',
                  billingCycle: (p['billingCycle'] as String?) ?? 'monthly',
                  regularPrice: Value((p['regularPrice'] as num?)?.toDouble()),
                  regularCurrency: Value(p['regularCurrency'] as String?),
                  promotionName: Value(p['promotionName'] as String?),
                  cancelDeadline: Value(_parseDate(p['cancelDeadline'])),
                  firstChargeDate: Value(_parseDate(p['firstChargeDate'])),
                  trialEndDate: Value(_parseDate(p['trialEndDate'])),
                  reminderDate: Value(_parseDate(p['reminderDate'])),
                  autoRenew: Value(p['autoRenew'] as bool? ?? true),
                  sortOrder: Value(i++),
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
      }

      final events = s['events'];
      if (events is List) {
        for (final rawEvent in events) {
          if (rawEvent is! Map) continue;
          final e = Map<String, dynamic>.from(rawEvent);
          await db.into(db.subscriptionEvents).insert(
                SubscriptionEventsCompanion.insert(
                  id: (e['id'] as String?) ?? _uuid.v4(),
                  subscriptionId: id,
                  type: (e['type'] as String?) ?? SubscriptionEventType.created.name,
                  at: _parseDate(e['at']) ?? now,
                  title: (e['title'] as String?) ?? 'EVENT',
                  detail: Value(e['detail'] as String?),
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
      }

      final reminders = s['reminders'];
      if (reminders is List) {
        for (final rawRem in reminders) {
          if (rawRem is! Map) continue;
          final r = Map<String, dynamic>.from(rawRem);
          await db.into(db.reminders).insert(
                RemindersCompanion.insert(
                  id: (r['id'] as String?) ?? _uuid.v4(),
                  subscriptionId: id,
                  kind: (r['kind'] as String?) ?? ReminderKind.upcomingRenewal.name,
                  offsetKind: (r['offsetKind'] as String?) ?? ReminderOffset.days3.name,
                  customDays: Value(r['customDays'] as int?),
                  fireAt: _parseDate(r['fireAt']) ?? now,
                  enabled: Value(r['enabled'] as bool? ?? true),
                  notificationId: (r['notificationId'] as int?) ?? r.hashCode.abs() % 2147483647,
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
      }

      final history = s['priceHistory'];
      if (history is List) {
        for (final rawHist in history) {
          if (rawHist is! Map) continue;
          final h = Map<String, dynamic>.from(rawHist);
          await db.into(db.priceHistory).insert(
                PriceHistoryCompanion.insert(
                  id: (h['id'] as String?) ?? _uuid.v4(),
                  subscriptionId: id,
                  oldPrice: (h['oldPrice'] as num?)?.toDouble() ?? 0,
                  newPrice: (h['newPrice'] as num?)?.toDouble() ?? 0,
                  currency: (h['currency'] as String?) ?? 'TWD',
                  effectiveDate: _parseDate(h['effectiveDate']) ?? now,
                  reason: (h['reason'] as String?) ?? 'Restored',
                ),
                mode: InsertMode.insertOrReplace,
              );
        }
      }
      restored++;
    }

    final payments = payload['payments'];
    if (payments is List) {
      for (final rawPay in payments) {
        if (rawPay is! Map) continue;
        final p = Map<String, dynamic>.from(rawPay);
        await db.into(db.paymentRecords).insert(
              PaymentRecordsCompanion.insert(
                id: (p['id'] as String?) ?? _uuid.v4(),
                subscriptionId: (p['subscriptionId'] as String?) ?? '',
                date: _parseDate(p['date']) ?? DateTime.now(),
                originalAmount: (p['originalAmount'] as num?)?.toDouble() ?? 0,
                originalCurrency: (p['originalCurrency'] as String?) ?? 'TWD',
                exchangeRate: (p['exchangeRate'] as num?)?.toDouble() ?? 1,
                convertedAmount: (p['convertedAmount'] as num?)?.toDouble() ?? 0,
                baseCurrency: (p['baseCurrency'] as String?) ?? 'TWD',
                foreignFee: (p['foreignFee'] as num?)?.toDouble() ?? 0,
                actualChargedAmount: (p['actualChargedAmount'] as num?)?.toDouble() ?? 0,
                paymentMethodId: Value(p['paymentMethodId'] as String?),
                note: Value(p['note'] as String?),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    }

    await db.update(db.userPreferences).write(
          const UserPreferencesCompanion(demoSeedEnabled: Value(false)),
        );

    final remainingBudgets = await finance.budgets();
    if (remainingBudgets.isEmpty) {
      await finance.upsertBudget(
        id: 'budget-total',
        scope: 'total',
        amount: 5000,
        currency: 'TWD',
      );
    }

    return RestoreResult(subscriptionCount: restored);
  }

  Future<void> _clearLedger() async {
    await db.delete(db.purchaseOrderEvents).go();
    await db.delete(db.purchaseOrders).go();
    await db.delete(db.reminders).go();
    await db.delete(db.pricePhases).go();
    await db.delete(db.paymentRecords).go();
    await db.delete(db.priceHistory).go();
    await db.delete(db.subscriptionEvents).go();
    await db.delete(db.subscriptions).go();
    await db.delete(db.paymentMethods).go();
    await db.delete(db.budgets).go();
  }

  Future<String> _ensureService(Map<String, dynamic> s) async {
    final existingId = s['serviceId'] as String?;
    if (existingId != null) {
      final found = await (db.select(db.services)..where((t) => t.id.equals(existingId))).getSingleOrNull();
      if (found != null) return existingId;
    }
    final name = (s['serviceName'] as String?) ?? 'Restored';
    final categoryId = (s['categoryId'] as String?) ?? 'other';
    final id = existingId ?? _uuid.v4();
    await db.into(db.services).insert(
          ServicesCompanion.insert(
            id: id,
            name: name,
            categoryId: categoryId,
            officialWebsiteUrl: Value(s['officialWebsiteUrl'] as String?),
            manageSubscriptionUrl: Value(s['manageSubscriptionUrl'] as String?),
            isCustom: const Value(true),
            isBuiltin: const Value(false),
          ),
          mode: InsertMode.insertOrIgnore,
        );
    return id;
  }

  DateTime? _parseDate(dynamic v) {
    if (v is! String || v.isEmpty) return null;
    return DateTime.tryParse(v);
  }

  Future<void> _share(String name, String body) async {
    if (kIsWeb) {
      await SharePlus.instance.share(ShareParams(text: body, subject: name));
      return;
    }
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsString(body);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }
}

class RestoreResult {
  const RestoreResult({required this.subscriptionCount});
  final int subscriptionCount;
}

class RestoreNeedsConfirmation implements Exception {
  const RestoreNeedsConfirmation();
  @override
  String toString() => 'Confirm overwrite before restoring. Local subscription data will be replaced.';
}

class RestoreFormatError implements Exception {
  const RestoreFormatError(this.message);
  final String message;
  @override
  String toString() => message;
}

class SyncException implements Exception {
  SyncException(this.message);
  final String message;
  @override
  String toString() => message;
}

class SyncService {
  SyncService(this.export);
  final ExportService export;

  /// Spark（免費用量）可用；不需 Blaze／Storage。
  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      FirebaseFirestore.instance.collection('users').doc(uid).collection('meta').doc('backup');

  Future<String> status(AppLocalizations l10n) async {
    if (!AppEnv.cloudInBuild) return l10n.syncNotAvailable;
    final uid = _firebaseUid;
    if (uid == null) return l10n.syncNeedLogin;
    if (!AppEnv.canUseCloud(uid)) return l10n.syncNotAuthorized;
    return l10n.syncReady;
  }

  void _ensureCloudAccess(AppLocalizations l10n) {
    if (!AppEnv.cloudInBuild) {
      throw SyncException(l10n.syncNotAvailable);
    }
    final uid = _firebaseUid;
    if (uid == null) {
      throw SyncException(l10n.syncNeedLogin);
    }
    if (!AppEnv.canUseCloud(uid)) {
      throw SyncException(l10n.syncNotAuthorized);
    }
  }

  String? get _firebaseUid {
    if (Firebase.apps.isEmpty) return null;
    try {
      return firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    } catch (_) {
      return null;
    }
  }

  Future<void> upload(AppLocalizations l10n) async {
    _ensureCloudAccess(l10n);
    final uid = _firebaseUid!;
    final map = await export.toJsonMap();
    final json = jsonEncode(map);
    // Firestore doc ~1MB limit; subscription ledger JSON is normally far smaller.
    if (json.length > 900 * 1024) {
      throw SyncException(l10n.syncBackupTooLarge);
    }
    try {
      await _doc(uid).set({
        'payload': json,
        'updatedAt': FieldValue.serverTimestamp(),
        'version': 1,
      });
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw SyncException(l10n.syncFirestoreDenied);
      }
      throw SyncException(e.message ?? e.code);
    }
  }

  /// Returns backup JSON string, or null if document does not exist.
  Future<String?> download(AppLocalizations l10n) async {
    _ensureCloudAccess(l10n);
    final uid = _firebaseUid!;
    try {
      final snap = await _doc(uid).get();
      if (!snap.exists) return null;
      final payload = snap.data()?['payload'];
      if (payload is! String || payload.isEmpty) return null;
      return payload;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw SyncException(l10n.syncFirestoreDenied);
      }
      throw SyncException(e.message ?? e.code);
    }
  }
}
