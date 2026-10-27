import 'package:drift/drift.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/seed/bootstrap.dart';
import 'package:subctrl/features/orders/purchase_flow.dart';
import 'package:uuid/uuid.dart';

class PurchaseOrderEventView {
  const PurchaseOrderEventView({
    required this.id,
    required this.orderId,
    required this.type,
    required this.at,
    required this.title,
    this.detail,
  });

  final String id;
  final String orderId;
  final PurchaseOrderEventType type;
  final DateTime at;
  final String title;
  final String? detail;
}

class PurchaseOrderView {
  const PurchaseOrderView({
    required this.id,
    required this.profileId,
    required this.platform,
    required this.title,
    required this.quantity,
    required this.status,
    required this.orderKind,
    required this.orderedAt,
    this.expectedAt,
    this.deliveredAt,
    this.reminderAt,
    this.price,
    this.depositPaid,
    this.balanceDue,
    this.shippingFee,
    this.serviceFee,
    this.currency,
    this.sellerName,
    this.orderNumber,
    this.trackingNumber,
    this.trackingUrl,
    this.forwarder,
    this.paymentNote,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String profileId;
  final String platform;
  final String title;
  final int quantity;
  final PurchaseStatus status;
  final PurchaseOrderKind orderKind;
  final DateTime orderedAt;
  final DateTime? expectedAt;
  final DateTime? deliveredAt;
  final DateTime? reminderAt;
  final double? price;
  final double? depositPaid;
  final double? balanceDue;
  final double? shippingFee;
  final double? serviceFee;
  final String? currency;
  final String? sellerName;
  final String? orderNumber;
  final String? trackingNumber;
  final String? trackingUrl;
  final String? forwarder;
  final String? paymentNote;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isPending => status.isPending;

  /// Total committed spend when breakdown fields exist; otherwise [price].
  double? get totalAmount {
    final parts = [depositPaid, balanceDue, shippingFee, serviceFee].whereType<double>();
    if (parts.isNotEmpty) {
      return parts.fold<double>(0, (a, b) => a + b);
    }
    return price;
  }
}

PurchaseStatus _parseStatus(String raw) {
  try {
    return PurchaseStatus.values.byName(raw);
  } catch (_) {
    return PurchaseStatus.preorder;
  }
}

PurchaseOrderKind _parseKind(String raw) {
  try {
    return PurchaseOrderKind.values.byName(raw);
  } catch (_) {
    return PurchaseOrderKind.preorder;
  }
}

PurchaseOrderEventType _parseEventType(String raw) {
  try {
    return PurchaseOrderEventType.values.byName(raw);
  } catch (_) {
    return PurchaseOrderEventType.noteUpdated;
  }
}

class PurchaseRepository {
  PurchaseRepository(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Stream<List<PurchaseOrderView>> watchAll() {
    return db.select(db.purchaseOrders).watch().map(
          (rows) => rows.map(_map).toList()
            ..sort((a, b) {
              final ae = a.expectedAt ?? a.orderedAt;
              final be = b.expectedAt ?? b.orderedAt;
              return ae.compareTo(be);
            }),
        );
  }

  Future<List<PurchaseOrderView>> listAll() async {
    final rows = await db.select(db.purchaseOrders).get();
    return rows.map(_map).toList();
  }

  Future<PurchaseOrderView?> getById(String id) async {
    final row = await (db.select(db.purchaseOrders)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _map(row);
  }

  Stream<List<PurchaseOrderEventView>> watchEvents(String orderId) {
    return (db.select(db.purchaseOrderEvents)..where((t) => t.orderId.equals(orderId))..orderBy([(t) => OrderingTerm.desc(t.at)]))
        .watch()
        .map((rows) => rows.map(_mapEvent).toList());
  }

  Future<List<PurchaseOrderEventView>> eventsFor(String orderId) async {
    final rows = await (db.select(db.purchaseOrderEvents)
          ..where((t) => t.orderId.equals(orderId))
          ..orderBy([(t) => OrderingTerm.desc(t.at)]))
        .get();
    return rows.map(_mapEvent).toList();
  }

  Future<List<PurchaseOrderView>> remindersDue() async {
    final rows = await db.select(db.purchaseOrders).get();
    return rows.map(_map).where((o) => o.reminderAt != null && o.isPending).toList();
  }

  Future<String> create({
    required String profileId,
    required String platform,
    required String title,
    required PurchaseStatus status,
    required DateTime orderedAt,
    PurchaseOrderKind orderKind = PurchaseOrderKind.preorder,
    int quantity = 1,
    DateTime? expectedAt,
    DateTime? reminderAt,
    double? price,
    double? depositPaid,
    double? balanceDue,
    double? shippingFee,
    double? serviceFee,
    String? currency,
    String? sellerName,
    String? orderNumber,
    String? trackingNumber,
    String? trackingUrl,
    String? forwarder,
    String? paymentNote,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    await db.into(db.purchaseOrders).insert(
          PurchaseOrdersCompanion.insert(
            id: id,
            profileId: profileId,
            platform: platform.trim(),
            title: title.trim(),
            quantity: Value(quantity),
            status: status.name,
            orderKind: Value(orderKind.name),
            orderedAt: orderedAt,
            expectedAt: Value(expectedAt),
            reminderAt: Value(reminderAt),
            price: Value(price),
            depositPaid: Value(depositPaid),
            balanceDue: Value(balanceDue),
            shippingFee: Value(shippingFee),
            serviceFee: Value(serviceFee),
            currency: Value(currency),
            sellerName: Value(sellerName),
            orderNumber: Value(orderNumber),
            trackingNumber: Value(trackingNumber),
            trackingUrl: Value(trackingUrl),
            forwarder: Value(forwarder),
            paymentNote: Value(paymentNote),
            notes: Value(notes),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await _logEvent(
      orderId: id,
      type: PurchaseOrderEventType.created,
      title: 'Order created',
      detail: title.trim(),
    );
    return id;
  }

  Future<void> updateFields({
    required String id,
    String? platform,
    String? title,
    int? quantity,
    PurchaseStatus? status,
    PurchaseOrderKind? orderKind,
    DateTime? orderedAt,
    DateTime? expectedAt,
    DateTime? reminderAt,
    double? price,
    double? depositPaid,
    double? balanceDue,
    double? shippingFee,
    double? serviceFee,
    String? currency,
    String? sellerName,
    String? orderNumber,
    String? trackingNumber,
    String? trackingUrl,
    String? forwarder,
    String? paymentNote,
    String? notes,
  }) async {
    final now = DateTime.now();
    await (db.update(db.purchaseOrders)..where((t) => t.id.equals(id))).write(
      PurchaseOrdersCompanion(
        platform: platform == null ? const Value.absent() : Value(platform.trim()),
        title: title == null ? const Value.absent() : Value(title.trim()),
        quantity: quantity == null ? const Value.absent() : Value(quantity),
        status: status == null ? const Value.absent() : Value(status.name),
        orderKind: orderKind == null ? const Value.absent() : Value(orderKind.name),
        orderedAt: orderedAt == null ? const Value.absent() : Value(orderedAt),
        expectedAt: expectedAt == null ? const Value.absent() : Value(expectedAt),
        reminderAt: reminderAt == null ? const Value.absent() : Value(reminderAt),
        price: price == null ? const Value.absent() : Value(price),
        depositPaid: depositPaid == null ? const Value.absent() : Value(depositPaid),
        balanceDue: balanceDue == null ? const Value.absent() : Value(balanceDue),
        shippingFee: shippingFee == null ? const Value.absent() : Value(shippingFee),
        serviceFee: serviceFee == null ? const Value.absent() : Value(serviceFee),
        currency: currency == null ? const Value.absent() : Value(currency),
        sellerName: sellerName == null ? const Value.absent() : Value(sellerName),
        orderNumber: orderNumber == null ? const Value.absent() : Value(orderNumber),
        trackingNumber: trackingNumber == null ? const Value.absent() : Value(trackingNumber),
        trackingUrl: trackingUrl == null ? const Value.absent() : Value(trackingUrl),
        forwarder: forwarder == null ? const Value.absent() : Value(forwarder),
        paymentNote: paymentNote == null ? const Value.absent() : Value(paymentNote),
        notes: notes == null ? const Value.absent() : Value(notes),
        updatedAt: Value(now),
      ),
    );
    await _logEvent(orderId: id, type: PurchaseOrderEventType.amountUpdated, title: 'Order updated');
  }

  Future<void> updateStatus(String id, PurchaseStatus status, {String? l10nLabel}) async {
    final prev = await getById(id);
    final now = DateTime.now();
    await (db.update(db.purchaseOrders)..where((t) => t.id.equals(id))).write(
      PurchaseOrdersCompanion(
        status: Value(status.name),
        deliveredAt: status == PurchaseStatus.delivered ? Value(now) : const Value.absent(),
        updatedAt: Value(now),
      ),
    );
    if (prev != null && prev.status != status) {
      await _logEvent(
        orderId: id,
        type: PurchaseOrderEventType.statusChanged,
        title: l10nLabel ?? status.name,
        detail: '${prev.status.name} → ${status.name}',
      );
    }
  }

  Future<void> advanceStatus(String id, {String? l10nLabel}) async {
    final order = await getById(id);
    if (order == null) return;
    final next = purchaseNextStatus(order.status);
    if (next == null) return;
    await updateStatus(id, next, l10nLabel: l10nLabel);
  }

  Future<void> delete(String id) async {
    await (db.delete(db.purchaseOrderEvents)..where((t) => t.orderId.equals(id))).go();
    await (db.delete(db.purchaseOrders)..where((t) => t.id.equals(id))).go();
  }

  Future<void> restoreOrder(Map<String, dynamic> json, {required List<Map<String, dynamic>>? eventList}) async {
    final id = json['id'] as String? ?? _uuid.v4();
    final now = DateTime.now();
    await db.into(db.purchaseOrders).insertOnConflictUpdate(
      PurchaseOrdersCompanion.insert(
        id: id,
        profileId: json['profileId'] as String? ?? personalProfileId,
        platform: (json['platform'] as String? ?? 'Other').trim(),
        title: (json['title'] as String? ?? 'Order').trim(),
        quantity: Value((json['quantity'] as num?)?.toInt() ?? 1),
        status: _parseStatus(json['status'] as String? ?? 'preorder').name,
        orderKind: Value(_parseKind(json['orderKind'] as String? ?? 'preorder').name),
        orderedAt: DateTime.tryParse(json['orderedAt'] as String? ?? '') ?? now,
        expectedAt: Value(_dt(json['expectedAt'])),
        deliveredAt: Value(_dt(json['deliveredAt'])),
        reminderAt: Value(_dt(json['reminderAt'])),
        price: Value((json['price'] as num?)?.toDouble()),
        depositPaid: Value((json['depositPaid'] as num?)?.toDouble()),
        balanceDue: Value((json['balanceDue'] as num?)?.toDouble()),
        shippingFee: Value((json['shippingFee'] as num?)?.toDouble()),
        serviceFee: Value((json['serviceFee'] as num?)?.toDouble()),
        currency: Value(json['currency'] as String?),
        sellerName: Value(json['sellerName'] as String?),
        orderNumber: Value(json['orderNumber'] as String?),
        trackingNumber: Value(json['trackingNumber'] as String?),
        trackingUrl: Value(json['trackingUrl'] as String?),
        forwarder: Value(json['forwarder'] as String?),
        paymentNote: Value(json['paymentNote'] as String?),
        notes: Value(json['notes'] as String?),
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? now,
        updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? now,
      ),
    );
    if (eventList != null) {
      await (db.delete(db.purchaseOrderEvents)..where((t) => t.orderId.equals(id))).go();
      for (final e in eventList) {
        if (e is! Map<String, dynamic>) continue;
        await db.into(db.purchaseOrderEvents).insertOnConflictUpdate(
          PurchaseOrderEventsCompanion.insert(
            id: e['id'] as String? ?? _uuid.v4(),
            orderId: id,
            type: _parseEventType(e['type'] as String? ?? 'noteUpdated').name,
            at: DateTime.tryParse(e['at'] as String? ?? '') ?? now,
            title: e['title'] as String? ?? 'Event',
            detail: Value(e['detail'] as String?),
          ),
        );
      }
    }
  }

  Future<void> _logEvent({
    required String orderId,
    required PurchaseOrderEventType type,
    required String title,
    String? detail,
  }) async {
    await db.into(db.purchaseOrderEvents).insert(
          PurchaseOrderEventsCompanion.insert(
            id: _uuid.v4(),
            orderId: orderId,
            type: type.name,
            at: DateTime.now(),
            title: title,
            detail: Value(detail),
          ),
        );
  }

  DateTime? _dt(dynamic v) {
    if (v is! String || v.isEmpty) return null;
    return DateTime.tryParse(v);
  }

  PurchaseOrderView _map(PurchaseOrder row) {
    return PurchaseOrderView(
      id: row.id,
      profileId: row.profileId,
      platform: row.platform,
      title: row.title,
      quantity: row.quantity,
      status: _parseStatus(row.status),
      orderKind: _parseKind(row.orderKind),
      orderedAt: row.orderedAt,
      expectedAt: row.expectedAt,
      deliveredAt: row.deliveredAt,
      reminderAt: row.reminderAt,
      price: row.price,
      depositPaid: row.depositPaid,
      balanceDue: row.balanceDue,
      shippingFee: row.shippingFee,
      serviceFee: row.serviceFee,
      currency: row.currency,
      sellerName: row.sellerName,
      orderNumber: row.orderNumber,
      trackingNumber: row.trackingNumber,
      trackingUrl: row.trackingUrl,
      forwarder: row.forwarder,
      paymentNote: row.paymentNote,
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  PurchaseOrderEventView _mapEvent(PurchaseOrderEvent row) {
    return PurchaseOrderEventView(
      id: row.id,
      orderId: row.orderId,
      type: _parseEventType(row.type),
      at: row.at,
      title: row.title,
      detail: row.detail,
    );
  }
}
